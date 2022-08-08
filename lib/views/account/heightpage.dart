import 'package:ai_dang/views/account/age.dart';
import 'package:ai_dang/views/account/weightpage.dart';
import 'package:ai_dang/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../loginPage.dart';

class heightpage extends StatefulWidget {
  final signUpList;
  const heightpage({Key? key, @required this.signUpList}) : super(key: key);

  @override
  _heightpageState createState() => _heightpageState();
}

class _heightpageState extends State<heightpage> {
  int _currentIntValue = 170;

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
                                    '신장을 선택하세요.',
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
                                          minValue: 50,
                                          maxValue: 250,
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
                                          'cm',
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
                                          MaterialPageRoute(builder: (context) => weightpage(signUpList:widget.signUpList)),
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //
  //     body: Center(
  //       child: Column(
  //         children: <Widget>[
  //           SizedBox(
  //             height: (MediaQuery.of(context).size.height) * 0.10,
  //           ),
  //           Container(
  //             color: Colors.white,
  //             height: (MediaQuery.of(context).size.height) -
  //                 (MediaQuery.of(context).size.height) * 0.1,
  //             width: (MediaQuery.of(context).size.width) -
  //                 (MediaQuery.of(context).size.width) * 0.3,
  //             child: Column(
  //               children: <Widget>[
  //                 Text(
  //                   '신장을 선택하세요.',
  //                   style: TextStyle(
  //                       fontSize:
  //                       ((MediaQuery.of(context).size.width) * 0.20) *
  //                           0.26,
  //                       color: Color(0xffCF2525)),
  //                 ),
  //                 SizedBox(height: (MediaQuery.of(context).size.height) * 0.05,
  //                 ),
  //                 SizedBox(
  //                   child: Column(
  //                     children: <Widget>[
  //                       SizedBox(height: (MediaQuery.of(context).size.height)*0.1),
  //                       // Text('Default', style: Theme.of(context).textTheme.headline6),
  //
  //                       Stack(
  //                         children: [
  //                           Container(
  //                             child: NumberPicker(
  //                                 itemHeight: (MediaQuery.of(context).size.height)*0.10,
  //                                 itemWidth: (MediaQuery.of(context).size.width)*0.6,
  //                                 value: _currentIntValue,
  //                                 minValue: 100,
  //                                 maxValue: 200,
  //                                 step: 1,
  //                                 haptics: true,
  //                                 decoration: BoxDecoration(
  //                                     border: Border(
  //                                       top:BorderSide(width: 1, color: Colors.grey),
  //                                       bottom: BorderSide(width: 1, color: Colors.grey),
  //                                     )
  //                                 ),
  //                                 selectedTextStyle: TextStyle(
  //                                     fontSize: (MediaQuery.of(context).size.height)*0.065,
  //                                     fontWeight: FontWeight.w600,
  //                                     color: Color(0xffCF2525)),
  //                                 textStyle: TextStyle(
  //                                     fontSize: (MediaQuery.of(context).size.height)*0.05,
  //                                     fontWeight: FontWeight.w300,
  //                                     color: Color(0xff9E9E9E)),
  //
  //                                 onChanged: (value) => setState(() => _currentIntValue = value)
  //                             ),
  //                           ),
  //                           Container(
  //                             child: Positioned(
  //                               bottom: (MediaQuery.of(context).size.height)*0.13,
  //                               right: (MediaQuery.of(context).size.width)*0.1,
  //                               child: Container(
  //                                 child: Text('cm',style: TextStyle(
  //                                     fontSize: (MediaQuery.of(context).size.height)*0.030,
  //                                     color: Color(0xffCF2525)
  //                                 ),),
  //                               ),
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                       SizedBox(
  //                         height: (MediaQuery.of(context).size.height) * 0.14,
  //                       ),
  //                       SizedBox(
  //                         height: (MediaQuery.of(context).size.height) * 0.065,
  //                         width: (MediaQuery.of(context).size.width) -
  //                             (MediaQuery.of(context).size.width) * 0.4,
  //                         child: ElevatedButton(
  //                           onPressed: () {
  //
  //                             widget.signUpList.add(_currentIntValue);
  //                             print(widget.signUpList);
  //                             Navigator.push(
  //                               context,
  //                               MaterialPageRoute(builder: (context) => weightpage(signUpList:widget.signUpList)),
  //                             );
  //                           },
  //                           child: Text('다음 단계로', style: TextStyle(
  //                               fontSize: ((MediaQuery.of(context).size.width) * 0.16) *  0.26
  //                           ),),
  //                           style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(10.0)),
  //                             primary : Color(0xffCF2525),),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         height: (MediaQuery.of(context).size.height) * 0.02,
  //                       ),
  //
  //                       SizedBox(
  //                         height: (MediaQuery.of(context).size.height) * 0.065,
  //                         width: (MediaQuery.of(context).size.width) -
  //                             (MediaQuery.of(context).size.width) * 0.4,
  //                         child: ElevatedButton(
  //                           onPressed: () {
  //
  //                             widget.signUpList.removeLast();
  //
  //                             Navigator.push(
  //                               context,
  //                               MaterialPageRoute(builder: (context) => agepage(signUpList: widget.signUpList)),
  //                             );
  //                           },
  //                           child: Text('이전 단계로', style: TextStyle(
  //                               color: Color(0xffCF2525),
  //                               fontSize: ((MediaQuery.of(context).size.width) * 0.16) *  0.26
  //                           ),),
  //                           style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(10.0),
  //                               side: BorderSide(
  //                                   color: Color(0xffCF2525)
  //                               )),
  //                             primary : Colors.white,),
  //                         ),
  //                       ),
  //                     ],
  //                   )
  //                 ),
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

