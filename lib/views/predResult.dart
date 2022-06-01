import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:ai_dang/my_expansion_panel.dart';

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
  bool _loading = false;

  int _amount = 1;
  String _desc = '';

  final Icon _arrowDown = const Icon(Icons.keyboard_arrow_down);
  final Icon _arrowUp = const Icon(Icons.keyboard_arrow_up);

  final _descTextCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _loading,
      child: Scaffold(
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
                      child: Padding(
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
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 40, 20, 20),
                                  child: const Text(
                                    '얼마나 드셨나요? (제공량 선택)',
                                    textScaleFactor: 1.2,
                                  )),
                              // 제공량 선택 영역 -----------------------------------
                              selectAmount(),
                              // 설명 라벨 영역 -------------------------------------
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 40, 20, 20),
                                  child: const Text(
                                    '음식에 관한 설명을 적어주세요.',
                                    textScaleFactor: 1.2,
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
      ),
    );
  }

  Widget foodImage() {
    return SliverAppBar(
      stretch: true,
      onStretchTrigger: () {
        // Function callback for stretch
        return Future<void>.value();
      },
      expandedHeight: 300.0,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('측정 결과,',
                            textScaleFactor: 1.3,
                            style: TextStyle(
                                color: black, fontWeight: FontWeight.w500)),
                        Row(
                          children: [
                            Text('${widget.predResult['class_name']}',
                                textScaleFactor: 2.4,
                                style: TextStyle(
                                    color: red, fontWeight: FontWeight.w900)),
                            Text(' 입니다.',
                                textScaleFactor: 2.4,
                                style: TextStyle(
                                    color: black, fontWeight: FontWeight.w900))
                          ],
                        ),
                      ],
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // 영양정보 펼치기 버튼
                          IconButton(
                            iconSize: 48,
                            padding: EdgeInsets.zero, // 패딩 설정
                            constraints: const BoxConstraints(), // constraints
                            icon: (_expanded) ? _arrowUp : _arrowDown,
                            onPressed: () {
                              setState(() {
                                _expanded = !_expanded;
                              });
                            },
                          ),
                          Text((_expanded) ? '영양정보 접기' : '영양정보 펼치기',
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                  color: black, fontWeight: FontWeight.w500)),
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
                padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                    child: Text(
                      '1회제공량(300g) 기준',
                      textScaleFactor: 1.2,
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
                padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 30.0),
                child: Column(
                  children: <Widget>[
                    // 열량 정보  ------------------------------------
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('열량',
                              textScaleFactor: 1.2,
                              style: TextStyle(color: black)),
                          Text('307kcal',
                              textScaleFactor: 1.4,
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
                          const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('탄수화물',
                              textScaleFactor: 1.2,
                              style: TextStyle(color: black)),
                          Text('23.46g',
                              textScaleFactor: 1.4,
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
                          const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('단백질',
                              textScaleFactor: 1.2,
                              style: TextStyle(color: black)),
                          Text('27.58g',
                              textScaleFactor: 1.4,
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
                          const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('지방',
                              textScaleFactor: 1.2,
                              style: TextStyle(color: black)),
                          Text('9.15g',
                              textScaleFactor: 1.4,
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
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 0.8,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        children: [
          // 당뇨병 위험정도 메세지 --------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('당뇨병에 ', textScaleFactor: 1.5),
              Text('매우 위험',
                  textScaleFactor: 1.5,
                  style: TextStyle(color: red, fontWeight: FontWeight.w700)),
              const Text('한 음식입니다.', textScaleFactor: 1.5),
            ],
          ),
          // 공백 -----------------------------------------------
          const SizedBox(height: 20),
          // 위험정도 인디케이터 -----------------------------------
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: StepProgressIndicator(
              totalSteps: 100,
              currentStep: 100,
              size: 25,
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
          // 공백 -----------------------------------------------
          const SizedBox(height: 20),
          // 총 당류 정보 ----------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('총 당류',
                    textScaleFactor: 1.2, style: TextStyle(color: black)),
                Text('21.09g',
                    textScaleFactor: 1.6,
                    style: TextStyle(color: black, fontWeight: FontWeight.w700))
              ],
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
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: (_amount == 1) ? red : Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                (_amount == 1)
                    ? BoxShadow()
                    : BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 0.8,
                        offset: const Offset(0, 3))
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1 / 2회 제공량',
                  textScaleFactor: 1.6,
                  style: TextStyle(color: red, fontWeight: FontWeight.w600),
                ),
                Text('150g',
                    textScaleFactor: 1.4, style: TextStyle(color: black))
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
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: (_amount == 2) ? red : Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                (_amount == 2)
                    ? const BoxShadow()
                    : BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 0.8,
                        offset: const Offset(0, 3))
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1회 제공량',
                  textScaleFactor: 1.6,
                  style: TextStyle(color: red, fontWeight: FontWeight.w600),
                ),
                Text('300g',
                    textScaleFactor: 1.4, style: TextStyle(color: black))
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
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: (_amount == 3) ? red : Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                (_amount == 3)
                    ? const BoxShadow()
                    : BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 0.8,
                        offset: const Offset(0, 3))
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1과 1 / 2회 제공량',
                  textScaleFactor: 1.6,
                  style: TextStyle(color: red, fontWeight: FontWeight.w600),
                ),
                Text('450g',
                    textScaleFactor: 1.4, style: TextStyle(color: black))
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
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: (_amount == 4) ? red : Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                (_amount == 4)
                    ? const BoxShadow()
                    : BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 0.8,
                        offset: const Offset(0, 3))
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '2회 제공량',
                  textScaleFactor: 1.6,
                  style: TextStyle(color: red, fontWeight: FontWeight.w600),
                ),
                Text('600g',
                    textScaleFactor: 1.4, style: TextStyle(color: black))
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
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 0.8,
              offset: const Offset(0, 3))
        ],
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
          maxLines: 8, //or null
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
                  _loading = true;
                  String predNo = widget.predResult['predict_no'];
                  insertMeal('', _amount.toString(), predNo, _desc).then((mealNo) {
                    setState(() { _loading = false;
                    Navigator.pop(context);});

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
