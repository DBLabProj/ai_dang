import 'package:ai_dang/utils/session.dart';
import 'package:ai_dang/views/home.dart';
import 'package:ai_dang/widgets/colors.dart';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:ai_dang/widgets/myExpansionPanel.dart';
import 'dart:io';
import '../utils/cropImage.dart';
import '../utils/dbHandler.dart';
import '../main.dart';
import '../utils/levenshteinDistance.dart';
import '../utils/request.dart';
import '../widgets/nutInfoIndicator.dart';

class PredResultPage extends StatelessWidget {
  final image;
  final predResult;
  const PredResultPage(
      {Key? key, @required this.image, @required this.predResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyStatefulWidget(image: image, predResult: predResult);
  }
}

class MyStatefulWidget extends StatefulWidget {
  final image;
  final predResult;
  const MyStatefulWidget(
      {Key? key, @required this.image, @required this.predResult})
      : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  double imageHeight = 0;

  List<dynamic> results = [];
  String _groupValue = '';
  List foodList = [];
  List addFoodList = [];
  String _desc = '';
  final _descTextCon = TextEditingController();

  Future<List> getFoodInfo(detectInfo, resizeHeight, ratio) async {
    BoundingBoxColors boundColors = BoundingBoxColors();
    List foodList = [];
    var predNo = widget.predResult['predict_no'];
    String imageUrl = "http://203.252.240.74:5000/static/images/$predNo.jpg";
    int index = 1;

    for (var detection in detectInfo) {
      if (detection['confidence'] < 0.5) {
        continue;
      }
      Map food = {};
      food['index'] = index++;
      food['name'] = detection['name'].toString();

      Map rect = {};
      rect['x'] = detection['xmin'].toDouble() * ratio;
      rect['y'] = detection['ymin'].toDouble() * ratio;
      rect['w'] = (detection['xmax'].toDouble() * ratio) - rect['x'];
      rect['h'] = (detection['ymax'].toDouble() * ratio) - rect['y'];
      rect['color'] = boundColors.get();
      food['acc'] =
          (detection['confidence'].toDouble() * 100).toInt().toString();

      food['rect'] = rect;

      food['thumbnail'] =
          await cropNetworkImage(imageUrl, resizeHeight.toInt(), rect);
      food['servingSelected'] = [false, true, false, false];

      // 음식 영양정보 받아오기
      var sqlRs = await getNutrient(food['name']);
      int minDist = 9999999;
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
      for (var row in sqlRs) {
        // 여러 행 중 가장 유사도가 높은 행으로
        int distance =
            levenshtein(food['name'], row['food_name'], caseSensitive: true);
        if (distance < minDist) {
          minDist = distance;
          // 영양정보 갱신
          nutrient['serving_size'] = row['serving_size'] ?? 0.0;
          nutrient['energy'] = row['energy'] ?? 0.0;
          nutrient['protein'] = row['protein'] ?? 0.0;
          nutrient['fat'] = row['fat'] ?? 0.0;
          nutrient['carbohydrate'] = row['carbohydrate'] ?? 0.0;
          nutrient['total_sugar'] = row['total_sugar'] ?? 0.0;
          nutrient['salt'] = row['salt'] ?? 0.0;
          nutrient['cholesterol'] = row['cholesterol'] ?? 0.0;
        }
      }
      food['nutrient'] = nutrient;
      foodList.add(food);
    }
    return foodList;
  }

  Future preProcess() async {
    return _memoizer.runOnce(() async {
      // 음식 이미지 원본 사이즈
      double sourceHeight = widget.predResult['image_height'].toDouble();
      // 음식 이미지 사이즈
      double imageHeight = MediaQuery.of(context).size.height * 0.4;
      // 실계산을 위해 현재 사이즈와 원본 사이즈 비율 산정
      double ratio = imageHeight / sourceHeight;
      List foodList =
          await getFoodInfo(widget.predResult['detection'], imageHeight, ratio);
      return {'foodList': foodList, 'imageHeight': imageHeight};
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: preProcess(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          EasyLoading.dismiss();
          imageHeight = snapshot.data['imageHeight'];
          foodList = snapshot.data['foodList'];
        } else {
          EasyLoading.show(status: '로딩중...');
        }
        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: <Widget>[
                foodImage(),
                SliverFillRemaining(
                  child: Column(
                    children: [
                      // 측정 결과, 영양정보 영역 --------------------------------------
                      predictMessage(),
                      // 하단 스크롤 영역 ---------------------------------------------
                      predictResult(),
                    ],
                  ),
                )
              ],
            ),
          ),
          // 입력완료 버튼 앱 바 -------------------------------------------------------
          bottomNavigationBar: confirmButtonBar(),
        );
      },
    );
  }

  Widget foodImage() {
    var predNo = widget.predResult['predict_no'];

    return SliverAppBar(
      stretch: true,
      onStretchTrigger: () {
        // Function callback for stretch
        return Future<void>.value();
      },
      backgroundColor: Colors.white,
      expandedHeight: imageHeight,
      flexibleSpace: FlexibleSpaceBar(
          stretchModes: const <StretchMode>[
            StretchMode.zoomBackground,
            StretchMode.blurBackground,
            StretchMode.fadeTitle,
          ],
          // 음식 사진 -------------------------------------------------------
          background: Container(
            color: lightGrey,
            child: Center(
              child: Stack(
                children: <Widget>[
                  Image.network(
                    "http://203.252.240.74:5000/static/images/$predNo.jpg",
                    fit: BoxFit.fitHeight,
                    height: imageHeight,
                  ),
                  for (var food in foodList) ...[
                    // 바운딩 박스
                    Positioned(
                        left: food['rect']['x'],
                        top: food['rect']['y'],
                        child: Container(
                          width: food['rect']['w'],
                          height: food['rect']['h'],
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: food['rect']['color'],
                            ),
                          ),
                        )),
                    // 감지 라벨
                    // 만약 라벨이 잘리는 경우 처리
                    if (food['rect']['y'] < (imageHeight * 0.1)) ...[
                      Positioned(
                          left: food['rect']['x'],
                          top: food['rect']['y'] + food['rect']['h'],
                          child: Container(
                            color: food['rect']['color'],
                            padding: const EdgeInsets.fromLTRB(4, 1, 4, 1),
                            child: Text(food['name'],
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ))
                    ] else ...[
                      Positioned(
                          left: food['rect']['x'],
                          bottom: imageHeight - food['rect']['y'],
                          child: Container(
                            color: food['rect']['color'],
                            padding: const EdgeInsets.fromLTRB(4, 1, 4, 1),
                            child: Text(food['name'],
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ))
                    ]
                  ]
                ],
              ),
            ),
          )),
    );
  }

  Widget predictMessage() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              // 인디게이터바 ----------------------------------------------
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Container(
                  width: 80,
                  height: 5,
                  decoration: BoxDecoration(
                      color: lightGrey,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              // 측정결과 역역 ----------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('음식 이미지 처리 결과,',
                          textScaleFactor: 1.1,
                          style: TextStyle(
                              color: black, fontWeight: FontWeight.w500)),
                      Row(
                        children: [
                          Text('${foodList.length}개의 음식',
                              textScaleFactor: 1.6,
                              style: TextStyle(
                                  color: red, fontWeight: FontWeight.w900)),
                          Text('이 분류 되었습니다.',
                              textScaleFactor: 1.6,
                              style: TextStyle(
                                  color: black, fontWeight: FontWeight.w900))
                        ],
                      ),
                    ],
                  ),
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    // 영양정보 펼치기 버튼
                    IconButton(
                      iconSize: 36,
                      padding: EdgeInsets.zero, // 패딩 설정
                      constraints: const BoxConstraints(), // constraints
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        results = [];
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              searchFoodDialog('음식 추가하기'),
                        );
                      },
                    ),
                    Text('음식 추가하기',
                        style: TextStyle(
                            color: black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  ]),
                ],
              ),
            ],
          )),
    );
  }


  Widget predictResult() {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: lightGrey,
        padding: const EdgeInsets.fromLTRB(20, 2, 20, 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(height: 18),
              for (var food in foodList) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 155,
                          height: 180,
                          child: food['thumbnail'],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    food['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 26),
                                  ),
                                  const SizedBox(width: 3),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(4, 4, 4, 4),
                                    decoration: BoxDecoration(
                                        color: food['rect']['color'],
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Center(
                                        child: Text(
                                      "${food['acc']}%일치",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          color: Colors.white),
                                    )),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          foodList.remove(food);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: black,
                                      ))
                                ],
                              ),
                              Text(
                                  '먹은 양을 선택해주세요. (제공량 ${food['nutrient']['serving_size'].toInt()}g)'),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 40,
                                child: ToggleButtons(
                                  selectedColor: red,
                                  splashColor: red.withOpacity(0.2),
                                  fillColor: red.withOpacity(0.2),
                                  highlightColor: red.withOpacity(0.4),
                                  children: <Widget>[
                                    SizedBox(
                                        width: 55,
                                        child: Center(
                                            child: Text(
                                          '1/2회\n${(food['nutrient']['serving_size'] * 0.5).toInt()}g',
                                          style: const TextStyle(fontSize: 13),
                                          textAlign: TextAlign.center,
                                        ))),
                                    SizedBox(
                                        width: 55,
                                        child: Center(
                                            child: Text(
                                          '1회\n${(food['nutrient']['serving_size']).toInt()}g',
                                          style: const TextStyle(fontSize: 13),
                                          textAlign: TextAlign.center,
                                        ))),
                                    SizedBox(
                                        width: 55,
                                        child: Center(
                                            child: Text(
                                          '1과1/2회\n${(food['nutrient']['serving_size'] * 1.5).toInt()}g',
                                          style: const TextStyle(fontSize: 13),
                                          textAlign: TextAlign.center,
                                        ))),
                                    SizedBox(
                                        width: 55,
                                        child: Center(
                                            child: Text(
                                          '2회\n${(food['nutrient']['serving_size'] * 2).toInt()}g',
                                          style: const TextStyle(fontSize: 13),
                                          textAlign: TextAlign.center,
                                        ))),
                                  ],
                                  onPressed: (int index) {
                                    setState(() {
                                      for (int buttonIndex = 0;
                                          buttonIndex <
                                              food['servingSelected'].length;
                                          buttonIndex++) {
                                        if (buttonIndex == index) {
                                          food['servingSelected'][buttonIndex] =
                                              !food['servingSelected']
                                                  [buttonIndex];
                                        } else {
                                          food['servingSelected'][buttonIndex] =
                                              false;
                                        }
                                      }
                                    });
                                  },
                                  isSelected: food['servingSelected'],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              // 영양 인디게이터
                              nutInfoIndicator([
                                food['nutrient']['carbohydrate'],
                                food['nutrient']['protein'],
                                food['nutrient']['fat'],
                                food['nutrient']['total_sugar']
                              ])
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
              for (var food in addFoodList) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: grey,
                          width: 155,
                          height: 185,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    food['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 26),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          foodList.remove(food);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: black,
                                      ))
                                ],
                              ),
                              Text(
                                  '먹은 양을 선택해주세요. (제공량 ${food['nutrient']['serving_size'].toInt()}g)'),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 40,
                                child: ToggleButtons(
                                  selectedColor: red,
                                  splashColor: red.withOpacity(0.2),
                                  fillColor: red.withOpacity(0.2),
                                  highlightColor: red.withOpacity(0.4),
                                  children: <Widget>[
                                    SizedBox(
                                        width: 55,
                                        child: Center(
                                            child: Text(
                                          '1/2회\n${(food['nutrient']['serving_size'] * 0.5).toInt()}g',
                                          style: const TextStyle(fontSize: 13),
                                          textAlign: TextAlign.center,
                                        ))),
                                    SizedBox(
                                        width: 55,
                                        child: Center(
                                            child: Text(
                                          '1회\n${(food['nutrient']['serving_size']).toInt()}g',
                                          style: const TextStyle(fontSize: 13),
                                          textAlign: TextAlign.center,
                                        ))),
                                    SizedBox(
                                        width: 55,
                                        child: Center(
                                            child: Text(
                                          '1과1/2회\n${(food['nutrient']['serving_size'] * 1.5).toInt()}g',
                                          style: const TextStyle(fontSize: 13),
                                          textAlign: TextAlign.center,
                                        ))),
                                    SizedBox(
                                        width: 55,
                                        child: Center(
                                            child: Text(
                                          '2회\n${(food['nutrient']['serving_size'] * 2).toInt()}g',
                                          style: const TextStyle(fontSize: 13),
                                          textAlign: TextAlign.center,
                                        ))),
                                  ],
                                  onPressed: (int index) {
                                    setState(() {
                                      for (int buttonIndex = 0;
                                          buttonIndex <
                                              food['servingSelected'].length;
                                          buttonIndex++) {
                                        if (buttonIndex == index) {
                                          food['servingSelected'][buttonIndex] =
                                              !food['servingSelected']
                                                  [buttonIndex];
                                        } else {
                                          food['servingSelected'][buttonIndex] =
                                              false;
                                        }
                                      }
                                    });
                                  },
                                  isSelected: food['servingSelected'],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              // 영양 인디게이터
                              nutInfoIndicator([
                                food['nutrient']['carbohydrate'],
                                food['nutrient']['protein'],
                                food['nutrient']['fat'],
                                food['nutrient']['total_sugar']
                              ])
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }


  Widget searchFoodDialog(title) {
    double width = MediaQuery.of(context).size.width * 0.8;
    double height = MediaQuery.of(context).size.width * 0.6;
    if (width > 500) {
      width = 500;
    }
    if (height > 800) {
      height = 800;
    }

    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: black, fontWeight: FontWeight.w600),
          ),
          content: SizedBox(
            width: width,
            height: height,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: lightGrey,
                  ),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    onChanged: (text) async {
                      if (text.length > 1) {
                        var sqlRs = await getNutrient(text);
                        setState(() {
                          results = [];
                          for (var row in sqlRs) {
                            results.add(row);
                          }
                        });
                      }
                    },
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        icon: Padding(
                            padding: EdgeInsets.only(left: 13),
                            child: Icon(Icons.search))),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var result in results) ...[
                            Container(
                                width: width,
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(color: grey))),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        result['food_name'],
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Radio(
                                        value: result['food_name'].toString(),
                                        onChanged: (value) {
                                          setState(() {
                                            _groupValue = value.toString();
                                          });
                                        },
                                        groupValue: _groupValue,
                                      ),
                                    ]))
                          ]
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
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
                for (var row in results) {
                  if (row['food_name'] == _groupValue) {
                    // 영양정보 갱신
                    nutrient['serving_size'] = row['serving_size'] ?? 0.0;
                    nutrient['energy'] = row['energy'] ?? 0.0;
                    nutrient['protein'] = row['protein'] ?? 0.0;
                    nutrient['fat'] = row['fat'] ?? 0.0;
                    nutrient['carbohydrate'] = row['carbohydrate'] ?? 0.0;
                    nutrient['total_sugar'] = row['total_sugar'] ?? 0.0;
                    nutrient['salt'] = row['salt'] ?? 0.0;
                    nutrient['cholesterol'] = row['cholesterol'] ?? 0.0;
                    addFoodList.add({
                      'name': row['food_name'],
                      'nutrient': nutrient,
                      'servingSelected': [false, true, false, false]
                    });
                    break;
                  }
                }
                Navigator.pop(context, 'OK');
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }


  Widget confirmMealDialog() {
    double width = MediaQuery.of(context).size.width * 0.75;
    if (width > 300) {
      width = 300;
    }

    Map mealNutrient = {
    'serving_size': 0.0,
    'energy': 0.0,
    'protein': 0.0,
    'fat': 0.0,
    'carbohydrate': 0.0,
    'total_sugar': 0.0,
    'salt': 0.0,
    'cholesterol': 0.0
    };

    for(var food in foodList) {
      mealNutrient['energy'] += food['nutrient']['energy'];
      mealNutrient['carbohydrate'] += food['nutrient']['carbohydrate'];
      mealNutrient['fat'] += food['nutrient']['fat'];
      mealNutrient['total_sugar'] += food['nutrient']['total_sugar'];
      mealNutrient['salt'] += food['nutrient']['salt'];
      mealNutrient['cholesterol'] += food['nutrient']['cholesterol'];
    }

    for(var food in addFoodList) {
      mealNutrient['energy'] += food['nutrient']['energy'];
      mealNutrient['carbohydrate'] += food['nutrient']['carbohydrate'];
      mealNutrient['fat'] += food['nutrient']['fat'];
      mealNutrient['total_sugar'] += food['nutrient']['total_sugar'];
      mealNutrient['salt'] += food['nutrient']['salt'];
      mealNutrient['cholesterol'] += food['nutrient']['cholesterol'];
    }

    return Container(
      color: lightGrey,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
            mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Row(
            //   children: [
            //     Text('식단 구성이 ',
            //         textScaleFactor: 1.6,
            //         style: TextStyle(
            //             color: black, fontWeight: FontWeight.w900)),
            //     Text('완료',
            //         textScaleFactor: 1.6,
            //         style: TextStyle(
            //             color: red, fontWeight: FontWeight.w900)),
            //     Text('되었습니다.',
            //         textScaleFactor: 1.6,
            //         style: TextStyle(
            //             color: black, fontWeight: FontWeight.w900))
            //   ],
            // ),
            sugarInfo(mealNutrient),
            // 설명 라벨 영역 -------------------------------------
            Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(
                    20, 30, 20, 20),
                child: const Text(
                  '식단에 관한 설명을 적어주세요.',
                  style: TextStyle(fontSize: 16),
                )),
            inputDesc(),
            const SizedBox(height: 30,),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ))),
              onPressed: () {
                setState(() {
                  EasyLoading.show(status: '로딩중...');
                  String predNo = widget.predResult['predict_no'];
                  String userId = Session.instance.userInfo['email'].toString();
                  // insertMeal(userId, _amount.toString(), predNo, _desc)
                  //     .then((mealNo) {
                  //
                  //   setState(() {
                  //     EasyLoading.dismiss();
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) =>  MyHomePage()),
                  //     );
                  //   });
                  // });
                });
              },
              child: SizedBox(
                width: width,
                height: 60,
                child: const Center(
                    child: Text(
                      '식 단  입 력 완 료',
                      textScaleFactor: 1.6,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget confirmButtonBar() {
    double width = MediaQuery.of(context).size.width * 0.75;
    if (width > 300) {
      width = 300;
    }
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return confirmMealDialog();
                  },
                  isScrollControlled:true
                );
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ))),
              child: SizedBox(
                width: width,
                height: 60,
                child: const Center(
                    child: Text(
                  '식 단  확 인 하 기',
                  textScaleFactor: 1.6,
                  style: TextStyle(fontWeight: FontWeight.w600),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sugarInfo(nut) {
    // 당류 먹은 비율 (0 ~ 1) ------------------------------------
    double eatSugarPercent =
    (nut['total_sugar'] / Session.instance.dietInfo['recom_sugar']);
    // 위험정보 메세지 (<0.1: 안전 / <0.3: 위험 / <0.5: 매우 위험)
    String dangerText = '';
    if (eatSugarPercent < 0.1) {
      dangerText = '안전';
    } else if(eatSugarPercent < 0.3) {
      dangerText = '약간 위험';
    } else if(eatSugarPercent < 0.5) {
      dangerText = '위험';
    } else {
      dangerText = '매우 위험';
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // 당뇨병 위험정도 메세지 --------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('당뇨병에 ', style: TextStyle(fontSize: 21)),
              Text(dangerText,
                  style: TextStyle(fontSize: 21, color: red, fontWeight: FontWeight.w700)),
              const Text('한 식단입니다.', style: TextStyle(fontSize: 21)),
            ],
          ),
          // 공백 -----------------------------------------------
          const SizedBox(height: 20),
          // 위험정도 인디케이터 -----------------------------------
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: StepProgressIndicator(
              totalSteps: 100,
              currentStep: (eatSugarPercent * 100).toInt(),
              size: 30,
              padding: 0,
              selectedColor: Colors.yellow,
              unselectedColor: Colors.cyan,
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.orangeAccent, redAccent],
              ),
              unselectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [grey, grey],
              ),
            ),
          ),
          // 인디케이터 밑 퍼센트 라벨 ------------------------------
          const SizedBox(height: 6),
          Stack(children: [
            (eatSugarPercent > 0.1) ?
            Align(
              alignment:
              Alignment.lerp(Alignment.topLeft, Alignment.topRight, 0.02)!,
              child: Text(
                '0%',
                textScaleFactor: 1.2,
                style: TextStyle(color: black, fontWeight: FontWeight.w700),
              ),
            ) : const Align(),

            Align(
              alignment: Alignment.lerp(
                  Alignment.topLeft, Alignment.topRight, eatSugarPercent)!,
              child: Text(
                '${(eatSugarPercent * 100).toInt().toString()}%',
                textScaleFactor: 1.2,
                style: TextStyle(color: redAccent, fontWeight: FontWeight.w700),
              ),
            ),
            // 85% 밑에 나오면 100% 라벨 출력 ------------------------------------
            (eatSugarPercent < 0.85) ?
            Align(
              alignment:
              Alignment.lerp(Alignment.topLeft, Alignment.topRight, 0.98)!,
              child: Text(
                '100%',
                textScaleFactor: 1.2,
                style: TextStyle(color: black, fontWeight: FontWeight.w700),
              ),
            ) : const Align(),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('권장 당류 섭취량의 ${(eatSugarPercent * 100).toInt().toString()}%를 섭취했습니다.',
              style: const TextStyle(fontSize: 16),),
          ),
          // 총 당류 정보 ----------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: [
                // 탄수화물 -------------------------------------
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('탄수화물',
                          textScaleFactor: 1.1, style: TextStyle(color: black)),
                      Text('${nut['carbohydrate'].toStringAsFixed(2)}g',
                          textScaleFactor: 1.2,
                          style:
                          TextStyle(color: black, fontWeight: FontWeight.w700))
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.5, color: grey),
                    ),
                  ),
                ),
                // 단백질 ---------------------------------------
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('단백질',
                          textScaleFactor: 1.1, style: TextStyle(color: black)),
                      Text('${nut['carbohydrate'].toStringAsFixed(2)}g',
                          textScaleFactor: 1.2,
                          style:
                          TextStyle(color: black, fontWeight: FontWeight.w700))
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.5, color: grey),
                    ),
                  ),
                ),
                // 지방 ----------------------------------------
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('지방',
                          textScaleFactor: 1.1, style: TextStyle(color: black)),
                      Text('${nut['carbohydrate'].toStringAsFixed(2)}g',
                          textScaleFactor: 1.2,
                          style:
                          TextStyle(color: black, fontWeight: FontWeight.w700))
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.5, color: grey),
                    ),
                  ),
                ),
                // 총 당류 -------------------------------------
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('총 당류',
                          textScaleFactor: 1.1, style: TextStyle(color: black)),
                      Text('${nut['total_sugar'].toStringAsFixed(2)}g',
                          textScaleFactor: 1.2,
                          style:
                          TextStyle(color: black, fontWeight: FontWeight.w700))
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.5, color: grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget inputDesc() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.2,
        ),
        child: TextField(
          controller: _descTextCon,
          onChanged: (text) {
            _desc = text;
          },
          maxLines: 4, //or null
          style: TextStyle(color: black, height: 1.5),
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
