import 'package:ai_dang/session.dart';
import 'package:ai_dang/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:ai_dang/widgets/myExpansionPanel.dart';
import 'dart:io';
import '../dbHandler.dart';
import '../main.dart';
import '../request.dart';

var lightGray = const Color(0xffF3F3F3);
var black = const Color(0xff393939);
var red = const Color(0xffCF2525);
var redAccent = const Color(0xffFF0701);
var lime = const Color(0xff91FF00);
var gray = const Color(0xffDADADA);
var deepGray = const Color(0xff535353);

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
  bool _expanded = false;

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

  Future<Map> get() async {
    var sqlRs = await getNutrient(widget.predResult['class_name']);

    for (var row in sqlRs) {
      nut['serving_size'] = row[1];
      nut['energy'] = row[3];
      nut['protein'] = row[5];
      nut['fat'] = row[6];
      nut['hydrate'] = row[7];
      nut['total_sugar'] = row[8];
    }
    return nut;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: get(),
      builder: (context, AsyncSnapshot<Map> snapshot) {
        if(!snapshot.hasData) {
          EasyLoading.show(status: '로딩 중..');
        } else {
          EasyLoading.dismiss();
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
                      predictResult(),
                      // 하단 스크롤 영역 ---------------------------------------------
                      Expanded(
                        child: Container(
                          color: lightGray,
                          padding: const EdgeInsets.fromLTRB(25, 2, 25, 0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                const SizedBox(height: 25),
                                // 총 당류 인디케이터 영역 -----------------------------
                                sugarInfo(),
                                // 제공량 선택 라벨 영역 -------------------------------
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 40, 20, 20),
                                    child: const Text(
                                      '얼마나 드셨나요? (제공량 선택)',
                                      textScaleFactor: 1.1,
                                    )),
                                // 제공량 선택 영역 -----------------------------------
                                selectAmount(),
                                // 설명 라벨 영역 -------------------------------------
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 40, 20, 20),
                                    child: const Text(
                                      '음식에 관한 설명을 적어주세요.',
                                      textScaleFactor: 1.1,
                                    )),
                                // 설명 텍스트 입력 영역 -------------------------------
                                inputDesc(),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
    return SliverAppBar(
      stretch: true,
      onStretchTrigger: () {
        // Function callback for stretch
        return Future<void>.value();
      },
      backgroundColor: Colors.white,
      expandedHeight: MediaQuery.of(context).size.height * 0.3,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const <StretchMode>[
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
        ],
        // 음식 사진 -------------------------------------------------------
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.file(
              widget.image,
              fit: BoxFit.fitWidth,
            ),
          ],
        ),
      ),
    );
  }

  Widget predictResult() {
    return MyExpansionPanelList(
      animationDuration: const Duration(milliseconds: 300),
      expandedHeaderPadding: const EdgeInsets.all(0),
      expansionCallback: (panelIndex, isExpanded) {
        _expanded = !_expanded;
        setState(() {});
      },
      children: [
        MyExpansionPanel(
          hasIcon: false,
          isExpanded: _expanded,
          headerBuilder: (context, isExpanded) {
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
                              color: lightGray,
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
                              Text('분류 결과,',
                                  textScaleFactor: 1.1,
                                  style: TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.w500)),
                              Row(
                                children: [
                                  Text('${widget.predResult['class_name']}',
                                      textScaleFactor: 1.6,
                                      style: TextStyle(
                                          color: red,
                                          fontWeight: FontWeight.w900)),
                                  Text(' 입니다.',
                                      textScaleFactor: 1.6,
                                      style: TextStyle(
                                          color: black,
                                          fontWeight: FontWeight.w900))
                                ],
                              ),
                            ],
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // 영양정보 펼치기 버튼
                                IconButton(
                                  iconSize: 36,
                                  padding: EdgeInsets.zero, // 패딩 설정
                                  constraints:
                                      const BoxConstraints(), // constraints
                                  icon: (_expanded) ? _arrowUp : _arrowDown,
                                  onPressed: () {
                                    setState(() {
                                      _expanded = !_expanded;
                                    });
                                  },
                                ),
                                Text((_expanded) ? '영양정보 접기' : '영양정보 펼치기',
                                    textScaleFactor: 0.8,
                                    style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.w500)),
                              ]),
                        ],
                      ),
                    ],
                  )),
            );
          },
          // 영양정보 영역 (펼쳐질때)
          body: Column(
            children: [
              // 구분선, 1회제공량
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                    child: Text(
                      '1회제공량(${nut['serving_size']} g) 기준',
                      textScaleFactor: 1.1,
                      style: TextStyle(color: deepGray),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.5, color: gray),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // 열량 정보  ------------------------------------
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('열량',
                              textScaleFactor: 1.1,
                              style: TextStyle(color: black)),
                          Text('${nut['energy']}kcal',
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                  color: black, fontWeight: FontWeight.w700))
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.5, color: gray),
                        ),
                      ),
                    ),
                    // 탄수화물 정보 ----------------------------------
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('탄수화물',
                              textScaleFactor: 1.1,
                              style: TextStyle(color: black)),
                          Text('${nut['hydrate']}g',
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                  color: black, fontWeight: FontWeight.w700))
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.5, color: gray),
                        ),
                      ),
                    ),
                    // 단백질 정보 -----------------------------------
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('단백질',
                              textScaleFactor: 1.1,
                              style: TextStyle(color: black)),
                          Text('${nut['protein']}g',
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                  color: black, fontWeight: FontWeight.w700))
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.5, color: gray),
                        ),
                      ),
                    ),
                    // 지방 정보 -------------------------------------
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('지방',
                              textScaleFactor: 1.1,
                              style: TextStyle(color: black)),
                          Text('${nut['fat']}g',
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                  color: black, fontWeight: FontWeight.w700))
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.5, color: gray),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget sugarInfo() {
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
                colors: [gray, gray],
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
                  top: BorderSide(width: 1.5, color: gray),
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
                        MaterialPageRoute(
                            builder: (context) =>  MyHomePage(pageNum: 1,)),
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
