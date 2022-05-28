import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ai_dang/my_expansion_panel.dart';

var lightGray = const Color(0xffF3F3F3);
var black = const Color(0xff393939);
var red = const Color(0xffCF2525);
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
  final Icon _arrowDown = Icon(Icons.keyboard_arrow_down);
  final Icon _arrowUp = Icon(Icons.keyboard_arrow_up);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: lightGray,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.32,
                    child: Image.file(
                      widget.image,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
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
                                  20.0, 0.0, 20.0, 0.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                              padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 30.0),
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  child: const Center(child: Text('Entry A')),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(width: 1.5, color: gray),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  child: const Center(child: Text('Entry A')),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(width: 1.5, color: gray),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  child: const Center(child: Text('Entry A')),
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
                ]),
              ),
            )));
  }
}
