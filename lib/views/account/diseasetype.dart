import 'package:ai_dang/views/account/weightpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import '../loginPage.dart';

class diseasetype extends StatefulWidget {
  final signUpList;
  const diseasetype({Key? key, @required this.signUpList}) : super(key: key);

  @override
  _diseasetypeState createState() => _diseasetypeState();
}

class _diseasetypeState extends State<diseasetype> {
  var diseasetype;
  var btnOneStyle;
  var btnTwoStyle;
  var btnThrStyle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: (MediaQuery.of(context).size.height) * 0.10,
              ),
              Container(
                  color: Colors.white,
                  height: (MediaQuery.of(context).size.height) -
                      (MediaQuery.of(context).size.height) * 0.1,
                  width: (MediaQuery.of(context).size.width) -
                      (MediaQuery.of(context).size.width) * 0.3,
                  child:Column(
                    children: <Widget>[
                      Text(
                        '당뇨 유형을 선택하세요.',
                        style: TextStyle(
                            fontSize:
                            ((MediaQuery.of(context).size.width) * 0.20) *
                                0.26,
                            color: Color(0xffCF2525)),
                      ),
                      SizedBox(height: (MediaQuery.of(context).size.height) * 0.03,
                      ),

                      SizedBox(
                        width: (MediaQuery.of(context).size.width) * 0.25,
                        height: (MediaQuery.of(context).size.height) * 0.16,
                        child: ElevatedButton(

                          onPressed: (){
                            setState(() {
                              diseasetype = "2";
                              if(diseasetype == "2") {
                                btnOneStyle = BorderSide(color: Colors.red);
                                btnTwoStyle = null;
                                btnThrStyle = null;
                              }
                            });
                            print("2");
                          },
                          child: Text(
                            '제2형',style: TextStyle(
                            color: Colors.grey,
                            fontSize: (MediaQuery.of(context).size.width)*0.06,
                            fontWeight: FontWeight.w300
                          ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shadowColor: Colors.red,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(600)
                              ),
                              side: btnOneStyle,

                          ),
                        ),
                      ),

                      SizedBox(
                        height: (MediaQuery.of(context).size.height) * 0.03,
                      ),

                      SizedBox(
                        width: (MediaQuery.of(context).size.width) * 0.25,
                        height: (MediaQuery.of(context).size.height) * 0.16,
                        child: ElevatedButton(

                          onPressed: (){
                            setState(() {
                              diseasetype = "1";
                              if(diseasetype == "1") {
                                btnOneStyle = null;
                                btnTwoStyle = BorderSide(color: Colors.red);
                                btnThrStyle = null;
                              }
                            });
                            print("1");
                          },
                          child: Text(
                            '제1형',style: TextStyle(
                              color: Colors.grey,
                              fontSize: (MediaQuery.of(context).size.width)*0.06,
                              fontWeight: FontWeight.w300
                          ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shadowColor: Colors.red,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500)
                              ),
                              side: btnTwoStyle),),
                      ),

                      SizedBox(
                        height: (MediaQuery.of(context).size.height) * 0.03,
                      ),

                      SizedBox(
                        width: (MediaQuery.of(context).size.width) * 0.25,
                        height: (MediaQuery.of(context).size.height) * 0.16,
                        child: ElevatedButton(

                          onPressed: (){
                            setState(() {
                              diseasetype = "3";
                              if(diseasetype == "3" ) {
                                btnOneStyle = null;
                                btnTwoStyle = null;
                                btnThrStyle = BorderSide(color: Colors.red);
                              }
                            });
                            print("3");
                          },
                          child: Text(
                            '임신성',style: TextStyle(
                              color: Colors.grey,
                              fontSize: (MediaQuery.of(context).size.width)*0.06,
                              fontWeight: FontWeight.w300
                          ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shadowColor: Colors.red,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500)
                              ),
                              side: btnThrStyle),),
                      ),
                      SizedBox(
                        height: (MediaQuery.of(context).size.height) * 0.025,
                      ),


                      SizedBox(
                        height: (MediaQuery.of(context).size.height) * 0.065,
                        width: (MediaQuery.of(context).size.width) -
                            (MediaQuery.of(context).size.width) * 0.4,
                        child: ElevatedButton(
                          onPressed: () {

                            widget.signUpList.add(diseasetype);
                            print(widget.signUpList);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => loginPage()),
                            );
                          },
                          child: Text('마치기', style: TextStyle(
                              fontSize: ((MediaQuery.of(context).size.width) * 0.16) *  0.26
                          ),),
                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                            primary : Color(0xffCF2525),),
                        ),
                      ),
                      SizedBox(
                        height: (MediaQuery.of(context).size.height) * 0.02,
                      ),

                      SizedBox(
                        height: (MediaQuery.of(context).size.height) * 0.065,
                        width: (MediaQuery.of(context).size.width) -
                            (MediaQuery.of(context).size.width) * 0.4,
                        child: ElevatedButton(
                          onPressed: () {
                            widget.signUpList.removeLast();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => weightpage(signUpList:widget.signUpList)),
                            );
                          },
                          child: Text('이전 단계로', style: TextStyle(
                            color: Color(0xffCF2525),
                            fontSize: ((MediaQuery.of(context).size.width) * 0.16) *  0.26,
                          ),),

                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  color: Color(0xffCF2525)
                              )),
                            primary : Colors.white,),
                        ),
                      ),
                    ],
                  )
              ),
            ],
          )
      ),
    );
  }
}