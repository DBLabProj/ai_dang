import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var lightGray = const Color(0xffF3F3F3);

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
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Image.file(
                      widget.image,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  // 측정결과 가져오기
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: 130,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('dd'),
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            )));
  }
}
