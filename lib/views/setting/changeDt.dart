import 'package:ai_dang/utils/session.dart';
import 'package:ai_dang/views/setting/profileDetail.dart';
import 'package:ai_dang/widgets/colors.dart';
import 'package:flutter/material.dart';

import '../../utils/dbHandler.dart';
import '../home.dart';

class changeDt extends StatefulWidget {
  const changeDt({Key? key}) : super(key: key);

  @override
  _changeDtState createState() => _changeDtState();
}

class _changeDtState extends State<changeDt> {
  var diseasetype;
  var btnOneStyle;
  var btnTwoStyle;
  var btnThrStyle;

  var User_id = Session.instance.userInfo['id'];
  var User_email = Session.instance.userInfo['email'];
  var User_dt = Session.instance.userInfo['dt'];

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
                        '수정할 당뇨유형을 선택하세요.',
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
                              diseasetype = "제2형";
                              if(diseasetype == "제2형") {
                                btnOneStyle = BorderSide(color: Colors.red);
                                btnTwoStyle = null;
                                btnThrStyle = null;
                              }
                            });
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
                              diseasetype = "제1형";
                              if(diseasetype == "제1형") {
                                btnOneStyle = null;
                                btnTwoStyle = BorderSide(color: Colors.red);
                                btnThrStyle = null;
                              }
                            });
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
                              diseasetype = "임신성";
                              if(diseasetype == "임신성" ) {
                                btnOneStyle = null;
                                btnTwoStyle = null;
                                btnThrStyle = BorderSide(color: Colors.red);
                              }
                            });
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
                            showDialogPop();
                          },
                          child: Text('변경하기', style: TextStyle(
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
                            Navigator.pop(context);
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

  // UserInfo update
  void change_User_info_Dt(User_email) async{
    await getUserInfo(User_email);
  }


  void showDialogPop() {
    showDialog(
        context: context,
        barrierDismissible: true,
        // false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text(
                '프로필 변경'
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      '당뇨유형을 수정하시겠습니까?'
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  change_dt(diseasetype, User_id);
                  change_User_info_Dt(User_email);
                  showDialogPop_done();
                },
                child: Text(
                  '수정하기',
                  style: TextStyle(
                      color: red
                  ),
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text(
                  '취소',
                  style: TextStyle(
                      color: red
                  ),
                ),
              )
            ],
          );
        }
    );
  }

  void showDialogPop_done() {
    showDialog(
        context: context,
        barrierDismissible: true,
        // false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text(
                '프로필 변경'
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      '정상적으로 변경되었습니다.'
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => bodyInfoUpdate())
                  // );
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => bodyInfoUpdate()));
                },
                child: Text(
                  '확인',
                  style: TextStyle(
                      color: red
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}
