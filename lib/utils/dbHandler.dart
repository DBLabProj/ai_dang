import 'package:ai_dang/utils/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:async';
import 'dart:convert';

class ConnHandler {
  static final ConnHandler _connHandler = ConnHandler._internal();
  ConnHandler._internal();
  static ConnHandler get instance => _connHandler;

  static var _conn;

  Future<MySqlConnection> get conn async {
    if (_conn != null) {
      return _conn;
    }
    await connect();
    return _conn;
  }

  Future connect() async {
    var settings = ConnectionSettings(
        host: '203.252.240.74',
        port: 3306,
        user: 'dblab',
        password: 'dblab6100!@#',
        db: 'ai_dang'
    );
    var conn = MySqlConnection.connect(settings);
    await Future.delayed(const Duration(milliseconds: 1000));
    _conn = conn;
  }
}

Future selectDayMeal(selectedDay, userName) async {
  List mealList = [];
  var conn = await ConnHandler.instance.conn;
  String sql = '''
    SELECT  *
    FROM    meal 
    WHERE   (date_format(datetime, '%Y%m%d') = date_format(?, '%Y%m%d'))
    AND     (user = ?)
  ''';
  var result = await conn.query(sql, [selectedDay, userName]);
  for(var row in result) {
    List foodList = jsonDecode(row['foods']);
    for (var food in foodList) {
      Map nutrient = {
        'serving_size': 0.0,
        'energy': 0.0,
        'protein': 0.0,
        'fat': 0.0,
        'carbohydrate': 0.0,
        'total_sugar': 0.0,
        'salt': 0.0,
        'cholesterol': 0.0
      };
      result = await conn.query('''
    SELECT * FROM food_info WHERE food_name = ?
    ''', [food['name']]);
      for (var row in result) {
        nutrient['serving_size'] = row['serving_size'] ?? 0.0;
        nutrient['energy'] = row['energy'] ?? 0.0;
        nutrient['protein'] = row['protein'] ?? 0.0;
        nutrient['fat'] = row['fat'] ?? 0.0;
        nutrient['carbohydrate'] = row['carbohydrate'] ?? 0.0;
        nutrient['total_sugar'] = row['total_sugar'] ?? 0.0;
        nutrient['salt'] = row['salt'] ?? 0.0;
        nutrient['cholesterol'] = row['cholesterol'] ?? 0.0;
      }
      food['nutrient'] = nutrient;
    }
    Map meal = {};
    meal['datetime'] = row['datetime'];
    meal['description'] = row['description'];
    meal['foodList'] = foodList;
    meal['image_name'] = row['image_name'];
    mealList.add(meal);
  }


  return mealList;
}


Future getUserInfo(email) async {
  var conn = await ConnHandler.instance.conn;

  var result = await conn.query(
      'select name, email, age, sex, height, weight, dt, password, id from user where email = "$email"');
  for (var row in result) {
    await Session.instance.setInfo({
      'name': row[0],
      'email': row[1],
      'age': row[2],
      'sex': row[3],
      'height': row[4],
      'weight': row[5],
      'dt': row[6],
      'password': row[7],
      'id': row[8],
    });
  }

  return result;
}
Future insertMeal(user, foodList, desc, imageName) async {
  var conn = await ConnHandler.instance.conn;
  var result = await conn.query( '''
			SELECT	concat(today_date, concat('-', serial_no)) as meal_no
			FROM	(SELECT	concat('M', date_format(now(), "%Y%m%d")) as today_date,
							right(concat('00', row_count + 1), 3) as serial_no
					FROM	(SELECT count(*) as row_count
							FROM	meal
							WHERE	date_format(datetime, '%Y%m%d') = date_format(now(), '%Y%m%d')) in_tb) out_tb
		''');
  String mealNo = '';
  for(var row in result) {
    mealNo = row['meal_no'];
  }

  DateTime datetime = DateTime.now().toUtc().add(const Duration(hours: 9));

  var result2 = await conn.query(
      'INSERT INTO meal VALUES(?, ?, ?, ?, ?, ?)',
      [mealNo, datetime, user, desc, jsonEncode(foodList), imageName]
  );
  return result2;
}

Future insertUsers(signUpList) async {
  var conn = await ConnHandler.instance.conn;
  var result = await conn.query(
          'INSERT INTO user VALUES(?,?,?,?,?,?,?,?,?)',
      [null, signUpList[2], signUpList[0], signUpList[4], signUpList[1], signUpList[3], signUpList[5], signUpList[6], signUpList[7]]
  );
  return result;
}

Future deleteUser(_email) async{
  var conn = await ConnHandler.instance.conn;
  String sql ='''
    DELETE FROM USER WHERE email = '$_email' 
  ''';

  var result = await conn.query(sql);
  return result;
}

Future cntBoardList() async {
  var conn = await ConnHandler.instance.conn;

  String sql = '''
    SELECT COUNT(*) AS cnt
    FROM board
    ORDER BY board_uid desc
  ''';

  var result = await conn.query(sql);
  return result;
}

Future boardList(pageStart) async {
  var conn = await ConnHandler.instance.conn;

  String sql = '''
    SELECT * FROM board
    ORDER BY board_uid desc
  ''';

  var result = await conn.query(sql);
  return result;
}

Future commentList(_boardUid) async {
  var conn = await ConnHandler.instance.conn;
  var boardUid = _boardUid;

  String sql = '''
    SELECT * FROM comment
    WHERE board_uid = ?
    ORDER BY comment_uid
  ''';

  var result = await conn.query(sql, [boardUid]);
  return result;
}

Future reCommentList(_commentUid) async {
  var conn = await ConnHandler.instance.conn;
  var commentUid = _commentUid;

  String sql = '''
    SELECT * FROM recomment
    WHERE comment_uid = ?
    ORDER BY recomment_uid
  ''';

  var result = await conn.query(sql, [commentUid]);
  return result;
}

Future insertBoard(_title, _content, _userId, _imageText) async {
  var conn = await ConnHandler.instance.conn;
  var title = _title;
  var content = _content;
  var writer = _userId;
  var image = _imageText;
  DateTime datetime = DateTime.now().toUtc().add(const Duration(hours: 9));
  String sql = '''
    INSERT INTO board (board_title, board_content, board_add, board_writer, board_image)
    VALUES (?, ?, ?, ?, ?)
  ''';

  var result = await conn.query(sql, [title, content, datetime, writer, image]);

  return result;
}
Future insertBloodCheck(_email, _date_time, _bloodsugar_level, _content) async{
  var conn = await ConnHandler.instance.conn;
  var email = _email;
  var date_time = _date_time;
  var bloodsugar_level = _bloodsugar_level;
  var content = _content;
  DateTime write_time = DateTime.now().toUtc().add(const Duration(hours: 9));
  String sql = '''
    INSERT INTO blood (email, date_time, bloodsugar_level, content,write_time)
    VALUES (?,?,?,?,?)
  ''';

  var result = await conn.query(sql, [email, date_time, bloodsugar_level, content, write_time]);

  return result;
}


Future insertComment(_commentContent, _boardUid, _userId) async {
  var conn = await ConnHandler.instance.conn;
  var content = _commentContent;
  var writer = _userId;
  var boardUid = _boardUid;
  DateTime datetime = DateTime.now().toUtc().add(const Duration(hours: 9));
  String sql = '''
    INSERT INTO comment (comment_content, comment_reg, comment_writer, board_uid)
    VALUES (?, ?, ?, ?)
  ''';

  var result = await conn.query(sql, [content, datetime, writer, boardUid]);

  return result;
}

Future insertReComment(_reCommentContent, _commentUid, _userId) async {
  var conn = await ConnHandler.instance.conn;
  var content = _reCommentContent;
  var writer = _userId;
  var commentUid = _commentUid;
  DateTime datetime = DateTime.now().toUtc().add(const Duration(hours: 9));
  String sql = '''
    INSERT INTO recomment (recomment_content, recomment_reg, recomment_writer, comment_uid)
    VALUES (?, ?, ?, ?)
  ''';

  var result = await conn.query(sql, [content, datetime, writer, commentUid]);

  return result;
}

Future modifyBoard(_title, _content, _userId, _imageText, _boardUid) async {
  var conn = await ConnHandler.instance.conn;
  var title = _title;
  var content = _content;
  var image = _imageText;
  var boardUid = _boardUid;

  DateTime datetime = DateTime.now().toUtc().add(const Duration(hours: 9));

  String sql = '''
    UPDATE board SET board_title = ? , board_content = ?, board_add = ?, board_image = ?
    WHERE board_uid = ?
  ''';

  var result = await conn.query(sql, [title, content, datetime, image, boardUid]);

  return result;
}

Future deleteBoard(_boardUid) async {
  var conn = await ConnHandler.instance.conn;
  var boardUid = _boardUid;

  String sql = '''
    DELETE FROM board WHERE board_uid = ?
  ''';

  var result = await conn.query(sql, [boardUid]);

  return result;
}

Future deleteComment(_commentUid) async {
  var conn = await ConnHandler.instance.conn;
  var commentUid = _commentUid;

  String sql = '''
    DELETE FROM comment WHERE comment_uid = ?
  ''';

  var result = await conn.query(sql, [commentUid]);

  return result;
}

Future getBoard(_search) async {
  var conn = await ConnHandler.instance.conn;
  var search = _search;

  String sql = '''
    SELECT * FROM board
    WHERE board_title LIKE CONCAT('%', ?, '%') or board_content LIKE CONCAT('%', ?, '%')
    ORDER BY board_uid desc
  ''';

  var result = await conn.query(sql, [search, search]);

  return result;
}

Future getNutrient(foodName) async {
  var conn = await ConnHandler.instance.conn;
  // String sql = '''
  //   SELECT DISTINCT	F.*
  //   FROM    predict P JOIN main_food_info F
  //           ON	(P.result = F.food_name)
  //   WHERE	P.no = ?;
  // ''';

  String sql = '''
    SELECT  * FROM food_info
    WHERE   food_name like ?
  ''';

  var result = await conn.query(sql, ['%$foodName%']);
  return result;
}

// 회원 정보 가져오기
// Future get_userInfo(id) async{
//   var conn = await ConnHandler.instance.conn;
//
//   String sql = '''
//   select * from user where email = '$id'
//   ''';
//
//   var result = await conn.query(sql);
//
//   return result;
// }



// 비밀번호 변경
Future change_pass(changepass,id) async{
  var conn = await ConnHandler.instance.conn;

  String sql ='''
      update user set password = '$changepass' where id = '$id'
    ''';

  var result = await conn.query(sql);
  return result;
}

// 나이 변경
Future change_age(changeAge,id) async{
  var conn = await ConnHandler.instance.conn;

  String sql ='''
    update user set age = '$changeAge' where id = '$id'
  ''';

  var result = await conn.query(sql);
  return result;
}

// 신장 변경
Future change_height(changeHeight, id) async{
  var conn = await ConnHandler.instance.conn;

  String sql = '''
    update user set height = '$changeHeight' where id = '$id'
  ''';

  var result = await conn.query(sql);
  return result;
}

// 체중 변경
Future change_weight(changeWeight, id) async{
  var conn = await ConnHandler.instance.conn;

  String sql = '''
    update user set weight = '$changeWeight' where id = '$id'
  ''';

  var result = await conn.query(sql);
  return result;
}

// 당뇨유형 변경
Future change_dt(changeDt, id) async{
  var conn = await ConnHandler.instance.conn;

  String sql = '''
    update user set dt = '$changeDt' where id = '$id'
  ''';

  var result = await conn.query(sql);
  return result;
}


// 통계페이지
Future getConsumeInfo() async {
  var conn = await ConnHandler.instance.conn;
  String userId = Session.instance.userInfo['email'].toString();

  String sql = '''
      SELECT	concat(YEAR(M.datetime), '/', LPAD(MONTH(M.datetime), '2', '0'), '/',
          (WEEK(M.datetime) - WEEK(DATE_SUB(M.datetime, INTERVAL DAYOFMONTH(M.datetime)-1 DAY)) + 1)) as week,
          date_format(M.datetime, '%Y%m%d') as date,
          sum((energy * (amount/2))) as energy_SUM, sum((carbohydrate * (amount/2))) as cbhydra_SUM,
          sum((protein * (amount/2))) as protein_SUM, sum((fat * (amount/2))) as fat_S00UM,
          sum((total_sugar * (amount/2))) as sugar_SUM, sum((salt * (amount/2))) as salt_SUM,
          sum((cholesterol * (amount/2))) as cholesterol_SUM
      FROM    meal M,
          JSON_TABLE(M.foods, "\$[*]"
            COLUMNS ( 
              name varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci PATH "\$.name",
              amount int PATH "\$.amount"
            )
          ) F INNER JOIN food_info FI
          ON	F.name = FI.food_name
      WHERE 	M.user = '$userId'
      GROUP BY week, date WITH ROLLUP;
  ''';
  var result = await conn.query(sql);
  return result;
}
