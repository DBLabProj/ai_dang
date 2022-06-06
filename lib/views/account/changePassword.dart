import 'package:flutter/material.dart';
import 'package:ai_dang/session.dart';
import 'package:ai_dang/dbHandler.dart';

import '../loginPage.dart';

class changepass extends StatefulWidget {
  const changepass({Key? key}) : super(key: key);

  @override
  _changepassState createState() => _changepassState();
}

class _changepassState extends State<changepass> {

  final _nowpassword = TextEditingController();

  final _changepassword = TextEditingController();
  final _changepassword_check = TextEditingController();

  var User_pass = Session.instance.userInfo['password'];
  var User_id = Session.instance.userInfo['id'];



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //FocusManager.instance.primaryFocus?.unfocus();
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: (MediaQuery.of(context).size.height) * 0.08,
              ),
              Container(
                color: Colors.white,
                height: (MediaQuery.of(context).size.height) -
                    (MediaQuery.of(context).size.height) * 0.10,
                width: (MediaQuery.of(context).size.width) -
                    (MediaQuery.of(context).size.width) * 0.3,
                child: Column(
                  children: <Widget>[
                    Text(
                      '비밀번호 변경하기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:((MediaQuery.of(context).size.width) * 0.08),
                          color: Color(0xffCF2525)),
                    ),
                    Text(
                      '비밀번호를 변경하기 위해 아래 정보를 입력하세요.',
                      style: TextStyle(
                          fontSize:
                          ((MediaQuery.of(context).size.width) * 0.12) *
                              0.26,
                          color: Color(0xffCF2525)),
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height) * 0.1,
                    ),

                    Container(
                      width: (MediaQuery.of(context).size.width) -
                          (MediaQuery.of(context).size.width) * 0.35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      ],
                    ),
                    ),

                    SizedBox(height: (MediaQuery.of(context).size.height) * 0.01,
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width) -
                          (MediaQuery.of(context).size.width) * 0.35,
                      child: TextField(
                        controller: _nowpassword,
                        decoration: InputDecoration(
                          // filled: true,
                          labelText: '현재 비밀번호',
                          hintText: '현재 비밀번호를 입력하세요',
                          labelStyle: TextStyle(color: Color(0xffCF2525)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Color(0xffCF2525)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Color(0xffCF2525)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),


                    SizedBox(height: (MediaQuery.of(context).size.height) * 0.01,
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width) -
                          (MediaQuery.of(context).size.width) * 0.35,
                      child: TextField(
                        controller: _changepassword,
                        decoration: InputDecoration(
                          // filled: true,
                          labelText: '변경할 비밀번호',
                          hintText: '변경할 비밀번호를 입력하세요',
                          labelStyle: TextStyle(color: Color(0xffCF2525)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Color(0xffCF2525)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Color(0xffCF2525)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),


                    SizedBox(height: (MediaQuery.of(context).size.height) * 0.01,
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width) -
                          (MediaQuery.of(context).size.width) * 0.35,
                      child: TextField(
                        controller: _changepassword_check,
                        decoration: InputDecoration(
                          // filled: true,
                          labelText: '변경할 비밀번호 확인',
                          hintText: '변경할 비밀번호를 입력하세요',
                          labelStyle: TextStyle(color: Color(0xffCF2525)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Color(0xffCF2525)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(width: 1, color: Color(0xffCF2525)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),

                    SizedBox(height: (MediaQuery.of(context).size.height) * 0.060,
                    ),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height) * 0.065,
                      width: (MediaQuery.of(context).size.width) -
                          (MediaQuery.of(context).size.width) * 0.40,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_nowpassword.text!=User_pass) {
                            print('현재 비밀번호가 다릅니다');
                            showDialogPop_nowPass();
                          }
                          else if (_changepassword.text != _changepassword_check.text) {
                            print('변경할 비밀번호가 다릅니다.');
                            showDialogPop_changPass();
                          }
                          else {
                            showDialogPop_check();

                          }
                          //   showDialogPop();
                          // }
                          //
                          // if (Password_check == true && Email_check == true) {
                          //   signupList.add(_idTextEditController.text);
                          //   signupList.add(_passwordTextEditController.text);
                          //   // signupList.add(_passwordTextEditController_check.text);
                          //   signupList.add(_nameTextEditController.text);
                          //
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => genderpage(signUpList: signupList)),
                          //   );
                          // }

                        },
                        child: Text('변경하기', style: TextStyle(
                            fontSize: ((MediaQuery.of(context).size.width) * 0.16) *  0.26
                        ),),
                        style: ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
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

                          Navigator.pop(
                            context
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
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }

  void showDialogPop_login() {
    showDialog(
        context: context,
        barrierDismissible: true,
        // false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                '비밀번호를 변경하였습니다.'
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      '다시 로그인해주세요.'
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => loginPage()),
                  );
                },
                child: Text(
                  '닫기',
                ),
              )
            ],
          );
        }
    );
  }

  void showDialogPop_check() {
    showDialog(
        context: context,
        barrierDismissible: true,
        // false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                '비밀번호 변경'
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      '비밀번호를 변경하시겠습니까?'
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  change_pass(_changepassword.text,User_id);
                  showDialogPop_login();
                },
                child: Text(
                  '변경하기',
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text(
                  '취소',
                ),
              )
            ],
          );
        }
    );
  }

  void showDialogPop_nowPass() {
    showDialog(
      context: context,
      barrierDismissible: true,
      // false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '현재 비밀번호가 다릅니다.'
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '현재 비밀번호를 확인 해주세요'
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text(
                '닫기',
              ),
            )
          ],
        );
      }
    );
  }

  void showDialogPop_changPass() {
    showDialog(
        context: context,
        barrierDismissible: true,
        // false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                '변경할 비밀번호가 다릅니다.'
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      '변경할 비밀번호를 확인 해주세요'
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text(
                  '닫기',
                ),
              )
            ],
          );
        }
    );
  }
}
