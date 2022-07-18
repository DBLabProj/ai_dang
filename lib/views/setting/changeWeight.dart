import 'package:ai_dang/session.dart';
import 'package:ai_dang/views/setting/profileDetail.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../dbHandler.dart';
import '../home.dart';

class changeWeight extends StatefulWidget {
  const changeWeight({Key? key}) : super(key: key);

  @override
  _changeWeightState createState() => _changeWeightState();
}

class _changeWeightState extends State<changeWeight> {



  var User_weight = Session.instance.userInfo['weight'];
  var User_id = Session.instance.userInfo['id'];
  var User_email = Session.instance.userInfo['email'];




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
              child: Column(
                children: <Widget>[
                  Text(
                    '수정할 체중을 선택하세요.',
                    style: TextStyle(
                        fontSize:
                        ((MediaQuery.of(context).size.width) * 0.20) *
                            0.26,
                        color: Color(0xffCF2525)),
                  ),
                  SizedBox(height: (MediaQuery.of(context).size.height) * 0.05,
                  ),
                  SizedBox(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: (MediaQuery.of(context).size.height)*0.1),
                        // Text('Default', style: Theme.of(context).textTheme.headline6),

                        Stack(
                          children: [
                            Container(
                              child: NumberPicker(
                                  itemHeight: (MediaQuery.of(context).size.height)*0.10,
                                  itemWidth: (MediaQuery.of(context).size.width)*0.6,
                                  value: User_weight,
                                  minValue: 30,
                                  maxValue: 150,
                                  step: 1,
                                  haptics: true,
                                  decoration: BoxDecoration(
                                      border: Border(
                                        top:BorderSide(width: 1, color: Colors.grey),
                                        bottom: BorderSide(width: 1, color: Colors.grey),
                                      )
                                  ),
                                  selectedTextStyle: TextStyle(
                                      fontSize: (MediaQuery.of(context).size.height)*0.065,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffCF2525)),
                                  textStyle: TextStyle(
                                      fontSize: (MediaQuery.of(context).size.height)*0.05,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xff9E9E9E)),

                                  onChanged: (value) => setState(() => User_weight = value)
                              ),
                            ),
                            Container(
                              child: Positioned(
                                bottom: (MediaQuery.of(context).size.height)*0.13,
                                right: (MediaQuery.of(context).size.width)*0.1,
                                child: Container(
                                  child: Text('kg',style: TextStyle(
                                      fontSize: (MediaQuery.of(context).size.height)*0.030,
                                      color: Color(0xffCF2525)
                                  ),),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: (MediaQuery.of(context).size.height) * 0.14,
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
                                fontSize: ((MediaQuery.of(context).size.width) * 0.16) *  0.26
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
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
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
                      '체중을 수정하시겠습니까?'
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  change_weight(User_weight, User_id);
                  change_User_info_Weight(User_email);
                  showDialogPop_done();
                },
                child: Text(
                  '수정하기',
                  style: TextStyle(
                      color: colorRed
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
                      color: colorRed
                  ),
                ),
              )
            ],
          );
        }
    );
  }

  // UserInfo update
  void change_User_info_Weight(User_email) async{
    await getUserInfo(User_email);
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
                      color: colorRed
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}
