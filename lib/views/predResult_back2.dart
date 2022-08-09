import 'dart:ui';

import 'package:ai_dang/utils/cropImage.dart';
import 'package:ai_dang/utils/session.dart';
import 'package:ai_dang/widgets/nutInfoIndicator.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../utils/dbHandler.dart';
import '../main.dart';
import '../utils/request.dart';
import '../widgets/colors.dart';

class PredResultPage2 extends StatelessWidget {
  final image;
  final predResult;
  const PredResultPage2(
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
  bool _expanded = false;

  final AsyncMemoizer _memoizer = AsyncMemoizer();
  int _amount = 1;
  String _desc = '';
  final Icon _arrowDown = const Icon(Icons.keyboard_arrow_down);
  final Icon _arrowUp = const Icon(Icons.keyboard_arrow_up);
  final _descTextCon = TextEditingController();
  Map nut = {
    'serving_size': 0,
    'energy': 0,
    'protein': 0,
    'fat': 0,
    'hydrate': 0,
    'total_sugar': 0
  };

  double imageHeight = 0;

  List rects = [];

  Future<List> getRectInfo(detectInfo, resizeHeight, ratio) async {
    BoundingBoxColors boundColors = BoundingBoxColors();
    List rects = [];
    var predNo = widget.predResult['predict_no'];
    String imageUrl = "http://203.252.240.74:5000/static/images/$predNo.jpg";
    int index = 1;
    for (var detection in detectInfo) {
      Map rect = {};
      rect['index'] = index++;
      rect['name'] = detection['name'].toString();
      rect['x'] = detection['xmin'].toDouble() * ratio;
      rect['y'] = detection['ymin'].toDouble() * ratio;
      rect['w'] = (detection['xmax'].toDouble() * ratio) - rect['x'];
      rect['h'] = (detection['ymax'].toDouble() * ratio) - rect['y'];
      rect['acc'] =
          (detection['confidence'].toDouble() * 100).toInt().toString();
      rect['thumbnail'] =
          await cropNetworkImage(imageUrl, resizeHeight.toInt(), rect);
      rect['servingSelected'] = [false, true, false, false];
      rect['color'] = boundColors.get();
      rects.add(rect);
    }
    return rects;
  }

  Future preProcess() async {
    return _memoizer.runOnce(() async {
      // var sqlRs = await getNutrient(widget.predResult['class_name']);
      //
      // for (var row in sqlRs) {
      //   nut['serving_size'] = row[1];
      //   nut['energy'] = row[3];
      //   nut['protein'] = row[5];
      //   nut['fat'] = row[6];
      //   nut['hydrate'] = row[7];
      //   nut['total_sugar'] = row[8];
      // }

      // 음식 이미지 원본 사이즈
      double sourceHeight = widget.predResult['image_height'].toDouble();
      // 음식 이미지 사이즈
      double imageHeight = MediaQuery.of(context).size.height * 0.4;
      // 실계산을 위해 현재 사이즈와 원본 사이즈 비율 산정
      double ratio = imageHeight / sourceHeight;
      List rects =
          await getRectInfo(widget.predResult['detection'], imageHeight, ratio);
      return {'nut': nut, 'rects': rects, 'imageHeight': imageHeight};
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: preProcess(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          nut = snapshot.data['nut'];
          imageHeight = snapshot.data['imageHeight'];
          rects = snapshot.data['rects'];
        }
        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                foodImage(),
                SliverFillRemaining(child: predictResult()),
              ]),
            ),
          );
      },
    );
  }

  Widget foodImage() {
    var predNo = widget.predResult['predict_no'];

    double imageHeight = MediaQuery.of(context).size.height * 0.4;

    return Container(
        color: lightGrey,
        child: Center(
          child: Stack(
            children: <Widget>[
              Image.network(
                "http://203.252.240.74:5000/static/images/$predNo.jpg",
                fit: BoxFit.fitHeight,
                height: imageHeight,
              ),
              for (var rect in rects) ...[
                // 바운딩 박스
                Positioned(
                    left: rect['x'],
                    top: rect['y'],
                    child: Container(
                      width: rect['w'],
                      height: rect['h'],
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: rect['color'],
                        ),
                      ),
                    )),
                // 감지 라벨
                // 만약 라벨이 잘리는 경우 처리
                if (rect['y'] < (imageHeight * 0.1)) ...[
                  Positioned(
                      left: rect['x'],
                      top: rect['y'] + rect['h'],
                      child: Container(
                        color: rect['color'],
                        padding: const EdgeInsets.fromLTRB(4, 1, 4, 1),
                        child: Text(rect['name'],
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                      ))
                ] else ...[
                  Positioned(
                      left: rect['x'],
                      bottom: imageHeight - rect['y'],
                      child: Container(
                        color: rect['color'],
                        padding: const EdgeInsets.fromLTRB(4, 1, 4, 1),
                        child: Text(rect['name'],
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
      );
  }

  Widget predictResult() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.all(20),
        height: 400,
        child: Column(
          children: [
            for (int i = 0; i < rects.length; i++) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: grey),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Center(
                    //   child: Container(
                    //     width: 20, height: 20,
                    //     decoration: BoxDecoration(
                    //       color: rect['color'],
                    //       borderRadius: BorderRadius.circular(9999)
                    //     ),
                    //     child: Center(child: Text(rect['index'].toString(), style: TextStyle(color: Colors.white),)),
                    //   )
                    // ),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: 155,
                        height: 185,
                        child: rects[i]['thumbnail'],
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
                                  rects[i]['name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 26),
                                ),
                                const SizedBox(width: 3),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 4, 4, 4),
                                  decoration: BoxDecoration(
                                      color: rects[i]['color'],
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Center(
                                      child: Text(
                                    "${rects[i]['acc']}%일치",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Colors.white),
                                  )),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text('먹은 양을 선택해주세요. (제공량)'),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 30,
                              child: ToggleButtons(
                                selectedColor: red,
                                splashColor: red.withOpacity(0.2),
                                fillColor: red.withOpacity(0.2),
                                highlightColor: red.withOpacity(0.4),
                                children: const <Widget>[
                                  SizedBox(
                                      width: 55,
                                      child: Center(
                                          child: Text(
                                        '1/2회',
                                        style: TextStyle(fontSize: 13),
                                      ))),
                                  SizedBox(
                                      width: 55,
                                      child: Center(
                                          child: Text(
                                        '1회',
                                        style: TextStyle(fontSize: 13),
                                      ))),
                                  SizedBox(
                                      width: 55,
                                      child: Center(
                                          child: Text(
                                        '1과1/2회',
                                        style: TextStyle(fontSize: 13),
                                      ))),
                                  SizedBox(
                                      width: 55,
                                      child: Center(
                                          child: Text(
                                        '2회',
                                        style: TextStyle(fontSize: 13),
                                      ))),
                                ],
                                onPressed: (int index) {
                                  setState(() {
                                    for (int buttonIndex = 0;
                                        buttonIndex <
                                            rects[i]['servingSelected'].length;
                                        buttonIndex++) {
                                      if (buttonIndex == index) {
                                        rects[i]['servingSelected']
                                                [buttonIndex] =
                                            !rects[i]['servingSelected']
                                                [buttonIndex];
                                      } else {
                                        rects[i]['servingSelected']
                                            [buttonIndex] = false;
                                      }
                                    }
                                  });
                                },
                                isSelected: rects[i]['servingSelected'],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            // 영양 인디게이터
                            nutInfoIndicator([12, 14, 6, 5])

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10,)
            ]
          ],
        ),
      )
    ]);
  }

  Widget sugarInfo() {
    // 당류 먹은 비율 (0 ~ 1) ------------------------------------
    double eatSugarPercent =
        (nut['total_sugar'] / Session.instance.dietInfo['recom_sugar']);
    // 위험정보 메세지 (<0.1: 안전 / <0.3: 위험 / <0.5: 매우 위험)
    String dangerText = '';
    if (eatSugarPercent < 0.1) {
      dangerText = '안전';
    } else if (eatSugarPercent < 0.3) {
      dangerText = '약간 위험';
    } else if (eatSugarPercent < 0.5) {
      dangerText = '위험';
    } else {
      dangerText = '매우 위험';
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
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
              const Text('당뇨병에 ', textScaleFactor: 1.3),
              Text(dangerText,
                  textScaleFactor: 1.3,
                  style: TextStyle(color: red, fontWeight: FontWeight.w700)),
              const Text('한 음식입니다.', textScaleFactor: 1.3),
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
              size: 20,
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
            (eatSugarPercent > 0.1)
                ? Align(
                    alignment: Alignment.lerp(
                        Alignment.topLeft, Alignment.topRight, 0.02)!,
                    child: Text(
                      '0%',
                      textScaleFactor: 1.2,
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.w700),
                    ),
                  )
                : const Align(),

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
            (eatSugarPercent < 0.85)
                ? Align(
                    alignment: Alignment.lerp(
                        Alignment.topLeft, Alignment.topRight, 0.98)!,
                    child: Text(
                      '100%',
                      textScaleFactor: 1.2,
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.w700),
                    ),
                  )
                : const Align(),
          ]),
          // 총 당류 정보 ----------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('총 당류',
                      textScaleFactor: 1.1, style: TextStyle(color: black)),
                  Text('${nut['total_sugar']}g',
                      textScaleFactor: 1.2,
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.w700))
                ],
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.5, color: darkGrey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectAmount() {
    return Column(
      children: <Widget>[
        // 1/2회 제공량 ------------------------------------
        GestureDetector(
          onTap: () {
            setState(() {
              _amount = 1;
            });
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: (_amount == 1) ? red : Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1 / 2회 제공량',
                  textScaleFactor: 1.3,
                  style: TextStyle(color: red, fontWeight: FontWeight.w600),
                ),
                Text('${(nut['serving_size'] * 0.5).toInt()}g',
                    textScaleFactor: 1.1, style: TextStyle(color: black))
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        // 1회 제공량 --------------------------------------
        GestureDetector(
          onTap: () {
            setState(() {
              _amount = 2;
            });
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: (_amount == 2) ? red : Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1회 제공량',
                  textScaleFactor: 1.3,
                  style: TextStyle(color: red, fontWeight: FontWeight.w600),
                ),
                Text('${nut['serving_size'].toInt()}g',
                    textScaleFactor: 1.1, style: TextStyle(color: black))
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        // 1과 1/2 제공량 ----------------------------------
        GestureDetector(
          onTap: () {
            setState(() {
              _amount = 3;
            });
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: (_amount == 3) ? red : Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1과 1 / 2회 제공량',
                  textScaleFactor: 1.3,
                  style: TextStyle(color: red, fontWeight: FontWeight.w600),
                ),
                Text('${(nut['serving_size'] * 1.5).toInt()}g',
                    textScaleFactor: 1.1, style: TextStyle(color: black))
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        GestureDetector(
          onTap: () {
            setState(() {
              _amount = 4;
            });
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: (_amount == 4) ? red : Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '2회 제공량',
                  textScaleFactor: 1.3,
                  style: TextStyle(color: red, fontWeight: FontWeight.w600),
                ),
                Text('${(nut['serving_size'] * 2).toInt()}g',
                    textScaleFactor: 1.1, style: TextStyle(color: black))
              ],
            ),
          ),
        ),
      ],
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
          maxLines: 6, //or null
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

  Widget confirmButtonBar() {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  EasyLoading.show(status: '로딩중...');
                  String predNo = widget.predResult['predict_no'];
                  String userId = Session.instance.userInfo['email'].toString();
                  insertMeal(userId, _amount.toString(), predNo, _desc)
                      .then((mealNo) {
                    setState(() {
                      EasyLoading.dismiss();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    });
                  });
                });
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ))),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                height: 60,
                child: const Center(
                    child: Text(
                  '입  력  완  료',
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
}
