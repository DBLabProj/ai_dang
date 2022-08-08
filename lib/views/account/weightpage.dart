import 'package:ai_dang/views/account/diseasetype.dart';
import 'package:ai_dang/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../loginPage.dart';
import 'heightpage.dart';



class weightpage extends StatefulWidget {
  final signUpList;
  const weightpage({Key? key, @required this.signUpList}) : super(key: key);

  @override
  _weightpageState createState() => _weightpageState();
}

class _weightpageState extends State<weightpage> {
  int _currentIntValue = 65;

  @override
  Widget build(BuildContext context) {
    double areaWidth = (MediaQuery.of(context).size.width) * 0.75;
    if (areaWidth > 300) {
      areaWidth = 300;
    }
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                              width: areaWidth,
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  const Text(
                                    '체중을 선택하세요.',
                                    style: TextStyle(
                                        fontSize: 24, color: Color(0xffCF2525)),
                                  ),
                                  const SizedBox(height:60),
                                  Stack(
                                    children: [
                                      NumberPicker(
                                          itemHeight: 80,
                                          itemWidth: 250,
                                          value: _currentIntValue,
                                          minValue: 30,
                                          maxValue: 200,
                                          step: 1,
                                          haptics: true,
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                    width: 1, color: Colors.grey),
                                                bottom: BorderSide(
                                                    width: 1, color: Colors.grey),
                                              )),
                                          selectedTextStyle: const TextStyle(
                                              fontSize: 48,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xffCF2525)),
                                          textStyle: const TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w300,
                                              color: Color(0xff9E9E9E)),
                                          onChanged: (value) => setState(
                                                  () => _currentIntValue = value)),
                                      const Positioned(
                                        bottom: 105,
                                        right: 40,
                                        child: Text(
                                          'kg', 
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Color(0xffCF2525)),
                                        ),
                                      )
                                    ],
                                  ),

                                  const SizedBox(height:90),
                                  // 다음 단계로 버튼 -------------------------------------------
                                  SizedBox(
                                    width: areaWidth * 0.75,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        widget.signUpList.add(_currentIntValue);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => diseasetype(signUpList:widget.signUpList)),
                                        );
                                      },
                                      child: const Text('다음 단계로',
                                          textScaleFactor: 1.4),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0)),
                                        primary: const Color(0xffCF2525),
                                      ),
                                    ),
                                  ),
                                  // 다음 단계로 버튼 -------------------------------------------
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: areaWidth * 0.75,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        widget.signUpList.removeLast();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        '이전 단계로',
                                        textScaleFactor: 1.4,
                                        style: TextStyle(color: red),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                            side: const BorderSide(
                                                color: Color(0xffCF2525))),
                                        primary: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}


