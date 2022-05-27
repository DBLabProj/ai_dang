import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  @override
  Widget build(BuildContext context) {
    print(widget.predResult);
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
                  // 측정결과 가져오기
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: 135,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('측정 결과,',
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                              Row(
                                children: [
                                  Text('${widget.predResult['class_name']}',
                                      style: TextStyle(
                                          color: red,
                                          fontSize: 32,
                                          fontWeight: FontWeight.w900)),
                                  Text(' 입니다.',
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 32,
                                          fontWeight: FontWeight.w900))
                                ],
                              ),
                            ],
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                  IconButton(
                                    iconSize: 48,
                                    padding: EdgeInsets.zero, // 패딩 설정
                                    constraints: BoxConstraints(), // constraints
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                    ), onPressed: () {  },

                                  ),
                                  Text('영양정보 펼치기',
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                              ]),
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            )));
  }
}
