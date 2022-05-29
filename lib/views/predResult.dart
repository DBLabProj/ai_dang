import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ai_dang/my_expansion_panel.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

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

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        fontFamily: 'Noto_Sans_KR',
      ),
      home: MyStatefulWidget(image: image, predResult: predResult),
    );
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
  final Icon _arrowDown = const Icon(Icons.keyboard_arrow_down);
  final Icon _arrowUp = const Icon(Icons.keyboard_arrow_up);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: lightGray,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(children: [
                  // 음식 사진 ---------------------------------------------------
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.32,
                    child: Image.file(
                      widget.image,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  // 측정 결과, 영양정보 영역 --------------------------------------
                  MyExpansionPanelList(
                    animationDuration: const Duration(milliseconds: 300),
                    children: [
                      MyExpansionPanel(
                        hasIcon: false,
                        isExpanded: _expanded,
                        headerBuilder: (context, isExpanded) {
                          return Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            height: 135,
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('측정 결과,',
                                          textScaleFactor: 1.2,
                                          style: TextStyle(
                                              color: black,
                                              fontWeight: FontWeight.w500)),
                                      Row(
                                        children: [
                                          Text(
                                              '${widget.predResult['class_name']}',
                                              textScaleFactor: 2.0,
                                              style: TextStyle(
                                                  color: red,
                                                  fontWeight: FontWeight.w900)),
                                          Text(' 입니다.',
                                              textScaleFactor: 2.0,
                                              style: TextStyle(
                                                  color: black,
                                                  fontWeight: FontWeight.w900))
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // 영양정보 펼치기 버튼
                                        IconButton(
                                          iconSize: 36,
                                          padding: EdgeInsets.zero, // 패딩 설정
                                          constraints:
                                              const BoxConstraints(), // constraints
                                          icon: (_expanded)
                                              ? _arrowUp
                                              : _arrowDown,
                                          onPressed: () {
                                            setState(() {
                                              _expanded = !_expanded;
                                            });
                                          },
                                        ),
                                        Text(
                                            (_expanded)
                                                ? '영양정보 접기'
                                                : '영양정보 펼치기',
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                color: black,
                                                fontWeight: FontWeight.w500)),
                                      ]),
                                ],
                              ),
                            ),
                          );
                        },
                        // 영양정보 영역 (펼쳐질때)
                        body: Column(
                          children: [
                            // 구분선, 1회제공량
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  30.0, 0.0, 30.0, 0.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 0.0),
                                  child: Text(
                                    '1회제공량(300g) 기준',
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
                            ListView(
                              shrinkWrap: true,
                              padding: const EdgeInsets.fromLTRB(
                                  40.0, 10.0, 40.0, 30.0),
                              children: <Widget>[
                                // 열량 정보  ------------------------------------
                                Container(
                                  height: 50,
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 0.0, 15.0, 0.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('열량',
                                          style: TextStyle(color: black)),
                                      Text('307kcal',
                                          textScaleFactor: 1.3,
                                          style: TextStyle(
                                              color: black,
                                              fontWeight: FontWeight.w700))
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(width: 1.5, color: gray),
                                    ),
                                  ),
                                ),
                                // 탄수화물 정보 ----------------------------------
                                Container(
                                  height: 50,
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 0.0, 15.0, 0.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('탄수화물',
                                          style: TextStyle(color: black)),
                                      Text('23.46g',
                                          textScaleFactor: 1.3,
                                          style: TextStyle(
                                              color: black,
                                              fontWeight: FontWeight.w700))
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(width: 1.5, color: gray),
                                    ),
                                  ),
                                ),
                                // 단백질 정보 -----------------------------------
                                Container(
                                  height: 50,
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 0.0, 15.0, 0.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('단백질',
                                          style: TextStyle(color: black)),
                                      Text('27.58g',
                                          textScaleFactor: 1.3,
                                          style: TextStyle(
                                              color: black,
                                              fontWeight: FontWeight.w700))
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(width: 1.5, color: gray),
                                    ),
                                  ),
                                ),
                                // 지방 정보 -------------------------------------
                                Container(
                                  height: 50,
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 0.0, 15.0, 0.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('지방',
                                          style: TextStyle(color: black)),
                                      Text('9.15g',
                                          textScaleFactor: 1.3,
                                          style: TextStyle(
                                              color: black,
                                              fontWeight: FontWeight.w700))
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(width: 1.5, color: gray),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                    expandedHeaderPadding: EdgeInsets.all(0),
                    expansionCallback: (panelIndex, isExpanded) {
                      _expanded = !_expanded;
                      setState(() {});
                    },
                  ),
                  // 하단 스크롤 영역 ---------------------------------------------
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Card(
                        child: Column(
                          children: [
                            // 총 당류 정보 영역 ------------------------------------------
                            Container(
                              padding: const EdgeInsets.all(20.0),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  // 당뇨병 위험정도 메세지 --------------------------------
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('당뇨병에 ', textScaleFactor: 1.2),
                                      Text('매우 위험',
                                          textScaleFactor: 1.2,
                                          style: TextStyle(
                                              color: red,
                                              fontWeight: FontWeight.w700)),
                                      const Text('한 음식입니다.', textScaleFactor: 1.2),
                                    ],
                                  ),
                                  // 공백 -----------------------------------------------
                                  const SizedBox(height: 20),
                                  // 위험정도 인디케이터 -----------------------------------
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: StepProgressIndicator(
                                      totalSteps: 100,
                                      currentStep: 100,
                                      size: 20,
                                      padding: 0,
                                      selectedColor: Colors.yellow,
                                      unselectedColor: Colors.cyan,
                                      roundedEdges: const Radius.circular(10),
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
                                  // 공백 -----------------------------------------------
                                  const SizedBox(height: 20),
                                  // 총 당류 정보 ----------------------------------------
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('총 당류', style: TextStyle(color: black)),
                                        Text('21.09g',
                                            textScaleFactor: 1.3,
                                            style: TextStyle(
                                                color: black,
                                                fontWeight: FontWeight.w700))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            // 제공량 선택 라벨 영역 -----------------------------------------
                            Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
                                child: const Text(
                                  '얼마나 드셨나요? (제공량 선택)',
                                  textScaleFactor: 1.1,
                                )),
                            // 제공량 선택 영역 ---------------------------------------------
                          ],
                        ),
                      ),
                    ),
                  ),

                ]),
              ),
            )));
  }
}
