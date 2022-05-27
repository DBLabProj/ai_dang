import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var lightGray = const Color(0xffF3F3F3);
var black = const Color(0xff393939);
var red = const Color(0xffCF2525);

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
                  ExpansionPanelList(
                    animationDuration: const Duration(milliseconds: 300),
                    children: [
                      ExpansionPanel(
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
                        body: Text('gg'),
                        hasIcon: false,
                        isExpanded: _expanded,
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
