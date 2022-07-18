import 'package:ai_dang/session.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:async';

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
  var conn = await ConnHandler.instance.conn;
  String sql = '''
    SELECT  P.result, M.datetime, M.amount, M.description, P.image_name, 
            F.total_sugar, F.energy, F.protein, F.fat, F.carbohydrate
    FROM    meal M
            INNER JOIN predict P
            ON (M.predict_no = P.no)
            INNER JOIN main_food_info F
            ON (P.result = F.food_name)
    WHERE   (date_format(M.datetime, '%Y%m%d') = date_format(?, '%Y%m%d'))
    AND     (M.user = ?)
  ''';
  var result = await conn.query(sql, [selectedDay, userName]);
  return result;
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

Future insertUsers(signUpList) async {
  var conn = await ConnHandler.instance.conn;
  var result = await conn.query(
          'INSERT INTO user VALUES(?,?,?,?,?,?,?,?,?)',
      [null, signUpList[2], signUpList[0], signUpList[4], signUpList[1], signUpList[3], signUpList[5], signUpList[6], signUpList[7]]
  );
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

Future insertBoard(_title, _content) async {
  var conn = await ConnHandler.instance.conn;
  var title = _title;
  var content = _content;
  var writer = "user1";
  DateTime datetime = DateTime.now().toUtc().add(const Duration(hours: 9));
  String sql = '''
    INSERT INTO board (board_title, board_content, board_add, board_writer)
    VALUES (?, ?, ?, ?)
  ''';

  var result = await conn.query(sql, [title, content, datetime, writer]);

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
    SELECT  * FROM main_food_info
    WHERE   food_name = ?
  ''';

  var result = await conn.query(sql, [foodName]);
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
Future change_height(changeheight, id) async{
  var conn = await ConnHandler.instance.conn;

  String sql = '''
    update user set height = '$changeheight' where id = '$id'
  ''';

  var result = await conn.query(sql);
  return result;
}

// 통계페이지
Future getConsumeInfo() async {
  var conn = await ConnHandler.instance.conn;
  String sql = '''
    SELECT	concat(YEAR(M.datetime), '/', MONTH(M.datetime), '/',
            (WEEK(M.datetime) - WEEK(DATE_SUB(M.datetime, INTERVAL DAYOFMONTH(M.datetime)-1 DAY)) + 1)) as week,
        date_format(M.datetime, '%Y%m%d') as date,
        sum((energy * (amount/2))) as energy_SUM, sum((carbohydrate * (amount/2))) as cbhydra_SUM,
        sum((protein * (amount/2))) as protein_SUM, sum((fat * (amount/2))) as fat_SUM,
            sum((total_sugar * (amount/2))) as sugar_SUM
    FROM    meal M
        INNER JOIN predict P
        ON (M.predict_no = P.no)
        INNER JOIN main_food_info F
        ON (P.result = F.food_name)
    WHERE 	M.user = ?
    GROUP BY week, date WITH ROLLUP;
  ''';

  String userId = Session.instance.userInfo['email'].toString();
  var result = await conn.query(sql, [userId]);
  return result;
}