import 'package:ai_dang/views/account/weightpage.dart';
import 'package:ai_dang/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:ai_dang/utils/dbHandler.dart';


import '../loginPage.dart';

class diseasetype extends StatefulWidget {
  final signUpList;
  const diseasetype({Key? key, @required this.signUpList}) : super(key: key);

  @override
  _diseasetypeState createState() => _diseasetypeState();
}

class _diseasetypeState extends State<diseasetype> {
  var diseasetype;

  void signUp(signUpList){
    var conn = ConnHandler.instance.conn;
    insertUsers(signUpList);
  }

  var redSide = const BorderSide(color: Colors.red, width: 3);
  var greySide = BorderSide(color: Colors.grey.shade300, width: 1.5);

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
                                    '당뇨병 유형을 선택하세요.',
                                    style: TextStyle(
                                        fontSize: 24, color: Color(0xffCF2525)),
                                  ),
                                  const SizedBox(height: 30),
                                  SizedBox(
                                    width: 110,
                                    height: 110,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          diseasetype = "제2형";
                                        });
                                      },
                                      child: const Image(
                                        image: AssetImage("assets/image/diet.png"), width: 75,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          splashFactory: NoSplash.splashFactory,
                                          primary: Colors.white,
                                          shadowColor: Colors.transparent,
                                          elevation: 0.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(600)),
                                          side:
                                          (diseasetype == "제2형" ? redSide : greySide)),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 20),
                                    child: Text("제 2형", textScaleFactor: 1.2),
                                  ),
                                  SizedBox(
                                    width: 110,
                                    height: 110,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          diseasetype = "제1형";
                                        });
                                      },
                                      child: const Image(
                                        image: AssetImage("assets/image/insulin.png"), width: 75,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          splashFactory: NoSplash.splashFactory,
                                          primary: Colors.white,
                                          shadowColor: Colors.transparent,
                                          elevation: 0.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(600)),
                                          side:
                                          (diseasetype == "제1형" ? redSide : greySide)),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 20),
                                    child: Text("제 1형", textScaleFactor: 1.2),
                                  ),
                                  SizedBox(
                                    width: 110,
                                    height: 110,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          diseasetype = "임신성";
                                        });
                                      },
                                      child: const Image(
                                        image: AssetImage("assets/image/gestational-diabetes.png"), width: 75,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          splashFactory: NoSplash.splashFactory,
                                          primary: Colors.white,
                                          shadowColor: Colors.transparent,
                                          elevation: 0.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(600)),
                                          side:
                                          (diseasetype == "임신성" ? redSide : greySide)),
                                    ),
                                  ),
                                  const Padding( 
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 30),
                                    child: Text("임신성", textScaleFactor: 1.2),
                                  ),
                                  // 다음 단계로 버튼 -------------------------------------------
                                  SizedBox(
                                    width: areaWidth * 0.75,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        widget.signUpList.add(diseasetype);
                                        print(widget.signUpList);
                                        signUp(widget.signUpList);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const loginPage()),
                                        );
                                      },
                                      child: const Text('마치기',
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
  //
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     body: Center(
  //         child: Column(
  //           children: <Widget>[
  //             SizedBox(
  //               height: (MediaQuery.of(context).size.height) * 0.10,
  //             ),
  //             Container(
  //                 color: Colors.white,
  //                 height: (MediaQuery.of(context).size.height) -
  //                     (MediaQuery.of(context).size.height) * 0.1,
  //                 width: (MediaQuery.of(context).size.width) -
  //                     (MediaQuery.of(context).size.width) * 0.3,
  //                 child:Column(
  //                   children: <Widget>[
  //                     Text(
  //                       '당뇨 유형을 선택하세요.',
  //                       style: TextStyle(
  //                           fontSize:
  //                           ((MediaQuery.of(context).size.width) * 0.20) *
  //                               0.26,
  //                           color: Color(0xffCF2525)),
  //                     ),
  //                     SizedBox(height: (MediaQuery.of(context).size.height) * 0.03,
  //                     ),
  //
  //                     SizedBox(
  //                       width: (MediaQuery.of(context).size.width) * 0.25,
  //                       height: (MediaQuery.of(context).size.height) * 0.16,
  //                       child: ElevatedButton(
  //
  //                         onPressed: (){
  //                           setState(() {
  //                             diseasetype = "제2형";
  //                             if(diseasetype == "제2형") {
  //                               btnOneStyle = BorderSide(color: Colors.red);
  //                               btnTwoStyle = null;
  //                               btnThrStyle = null;
  //                             }
  //                           });
  //                         },
  //                         child: Text(
  //                           '제2형',style: TextStyle(
  //                           color: Colors.grey,
  //                           fontSize: (MediaQuery.of(context).size.width)*0.06,
  //                           fontWeight: FontWeight.w300
  //                         ),
  //                         ),
  //                         style: ElevatedButton.styleFrom(
  //                             primary: Colors.white,
  //                             shadowColor: Colors.red,
  //                             elevation: 3,
  //                             shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(600)
  //                             ),
  //                             side: btnOneStyle,
  //
  //                         ),
  //                       ),
  //                     ),
  //
  //                     SizedBox(
  //                       height: (MediaQuery.of(context).size.height) * 0.03,
  //                     ),
  //
  //                     SizedBox(
  //                       width: (MediaQuery.of(context).size.width) * 0.25,
  //                       height: (MediaQuery.of(context).size.height) * 0.16,
  //                       child: ElevatedButton(
  //
  //                         onPressed: (){
  //                           setState(() {
  //                             diseasetype = "제1형";
  //                             if(diseasetype == "제1형") {
  //                               btnOneStyle = null;
  //                               btnTwoStyle = BorderSide(color: Colors.red);
  //                               btnThrStyle = null;
  //                             }
  //                           });
  //                         },
  //                         child: Text(
  //                           '제1형',style: TextStyle(
  //                             color: Colors.grey,
  //                             fontSize: (MediaQuery.of(context).size.width)*0.06,
  //                             fontWeight: FontWeight.w300
  //                         ),
  //                         ),
  //                         style: ElevatedButton.styleFrom(
  //                             primary: Colors.white,
  //                             shadowColor: Colors.red,
  //                             elevation: 3,
  //                             shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(500)
  //                             ),
  //                             side: btnTwoStyle),),
  //                     ),
  //
  //                     SizedBox(
  //                       height: (MediaQuery.of(context).size.height) * 0.03,
  //                     ),
  //
  //                     SizedBox(
  //                       width: (MediaQuery.of(context).size.width) * 0.25,
  //                       height: (MediaQuery.of(context).size.height) * 0.16,
  //                       child: ElevatedButton(
  //
  //                         onPressed: (){
  //                           setState(() {
  //                             diseasetype = "임신성";
  //                             if(diseasetype == "임신성" ) {
  //                               btnOneStyle = null;
  //                               btnTwoStyle = null;
  //                               btnThrStyle = BorderSide(color: Colors.red);
  //                             }
  //                           });
  //                         },
  //                         child: Text(
  //                           '임신성',style: TextStyle(
  //                             color: Colors.grey,
  //                             fontSize: (MediaQuery.of(context).size.width)*0.06,
  //                             fontWeight: FontWeight.w300
  //                         ),
  //                         ),
  //                         style: ElevatedButton.styleFrom(
  //                             primary: Colors.white,
  //                             shadowColor: Colors.red,
  //                             elevation: 3,
  //                             shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(500)
  //                             ),
  //                             side: btnThrStyle),),
  //                     ),
  //                     SizedBox(
  //                       height: (MediaQuery.of(context).size.height) * 0.025,
  //                     ),
  //
  //
  //                     SizedBox(
  //                       height: (MediaQuery.of(context).size.height) * 0.065,
  //                       width: (MediaQuery.of(context).size.width) -
  //                           (MediaQuery.of(context).size.width) * 0.4,
  //                       child: ElevatedButton(
  //                         onPressed: () {
  //
  //                           widget.signUpList.add(diseasetype);
  //                           print(widget.signUpList);
  //
  //                           signUp(widget.signUpList);
  //
  //                           Navigator.push(
  //                             context,
  //                             MaterialPageRoute(builder: (context) => loginPage()),
  //                           );
  //                         },
  //                         child: Text('마치기', style: TextStyle(
  //                             fontSize: ((MediaQuery.of(context).size.width) * 0.16) *  0.26
  //                         ),),
  //                         style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(10.0)),
  //                           primary : Color(0xffCF2525),),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: (MediaQuery.of(context).size.height) * 0.02,
  //                     ),
  //
  //                     SizedBox(
  //                       height: (MediaQuery.of(context).size.height) * 0.065,
  //                       width: (MediaQuery.of(context).size.width) -
  //                           (MediaQuery.of(context).size.width) * 0.4,
  //                       child: ElevatedButton(
  //                         onPressed: () {
  //                           widget.signUpList.removeLast();
  //                           Navigator.push(
  //                             context,
  //                             MaterialPageRoute(builder: (context) => weightpage(signUpList:widget.signUpList)),
  //                           );
  //                         },
  //                         child: Text('이전 단계로', style: TextStyle(
  //                           color: Color(0xffCF2525),
  //                           fontSize: ((MediaQuery.of(context).size.width) * 0.16) *  0.26,
  //                         ),),
  //
  //                         style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(10.0),
  //                             side: BorderSide(
  //                                 color: Color(0xffCF2525)
  //                             )),
  //                           primary : Colors.white,),
  //                       ),
  //                     ),
  //                   ],
  //                 )
  //             ),
  //           ],
  //         )
  //     ),
  //   );
  // }
}