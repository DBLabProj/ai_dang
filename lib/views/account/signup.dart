import 'package:ai_dang/views/account/genderpage.dart';
import 'package:ai_dang/views/loginPage.dart';
import 'package:ai_dang/views/test.dart';
import 'package:flutter/material.dart';

import 'genderpage.dart';



class signup extends StatefulWidget {
  signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final _idTextEditController = TextEditingController();

  final _passwordTextEditController = TextEditingController();

  final _passwordTextEditController_check = TextEditingController();

  var signupList = [];

  @override
  void dispose() {
    _idTextEditController.dispose();
    _passwordTextEditController.dispose();
    _passwordTextEditController_check.dispose();
  }

  void showDialogPop() {
    showDialog(
      context: context,
      barrierDismissible: true,
      // false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            //제목 정의
            '비밀번호가 다릅니다!',
          ),
          content: SingleChildScrollView(
            //내용 정의
            child: ListBody(
              children: <Widget>[
                Text(
                  '비밀번호를 다시 확인해주세요!',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            //버튼 정의
            // TextButton(
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            //   child: Text(
            //     '확인',
            //   ),
            // ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 현재 화면을 종료하고 이전 화면으로 돌아가기
              },
              child: Text(
                '닫기',
              ),
            ),
          ],
        );
      },
    );
  }

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
                    (MediaQuery.of(context).size.height) * 0.18,
                width: (MediaQuery.of(context).size.width) -
                    (MediaQuery.of(context).size.width) * 0.3,
                child: Column(
                  children: <Widget>[
                    Text(
                      '계정 생성하기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:((MediaQuery.of(context).size.width) * 0.1),
                          color: Color(0xffCF2525)),
                    ),
                    Text(
                      '계정을 생성하기 위해 아래 정보를 입력하세요.',
                      style: TextStyle(
                          fontSize:
                          ((MediaQuery.of(context).size.width) * 0.14) *
                              0.26,
                          color: Color(0xffCF2525)),
                    ),
                    SizedBox(height: (MediaQuery.of(context).size.height) * 0.16,
                    ),

                    Container(

                      width: (MediaQuery.of(context).size.width) -
                          (MediaQuery.of(context).size.width) * 0.35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: (MediaQuery.of(context).size.width) -
                                (MediaQuery.of(context).size.width) * 0.52,
                            child: TextField(
                              controller: _idTextEditController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
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
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),

                          // SizedBox(
                          //   width: (MediaQuery.of(context).size.width)*0.01,
                          // ),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width) -
                                (MediaQuery.of(context).size.width) * 0.85,
                              height: (MediaQuery.of(context).size.height) * 0.065,
                            child: ElevatedButton(
                              onPressed: () {

                              },
                              child: Text('중복 확인', style: TextStyle(
                                  fontSize: ((MediaQuery.of(context).size.width) * 0.16) *  0.15
                              ),),
                              style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
                                  borderRadius:  BorderRadius.circular(10.0)),
                                primary : Color(0xffCF2525),),
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: (MediaQuery.of(context).size.height) * 0.01,
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width) -
                          (MediaQuery.of(context).size.width) * 0.35,
                      child: TextField(
                        controller: _passwordTextEditController,
                        decoration: InputDecoration(
                          // filled: true,
                          labelText: 'Password',
                          hintText: 'Enter your password',
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
                        controller: _passwordTextEditController_check,
                        decoration: InputDecoration(
                          // filled: true,
                          labelText: 'Password check',
                          hintText: 'Enter your password',
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

                    SizedBox(height: (MediaQuery.of(context).size.height) * 0.10,
                    ),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height) * 0.065,
                      width: (MediaQuery.of(context).size.width) -
                          (MediaQuery.of(context).size.width) * 0.40,
                      child: ElevatedButton(
                        onPressed: () {

                          if (_passwordTextEditController.text == _passwordTextEditController_check.text) {
                            signupList.add(_idTextEditController.text);
                            signupList.add(_passwordTextEditController.text);
                            signupList.add(_passwordTextEditController_check.text);

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => genderpage(signUpList: signupList)),
                            );
                          } else {
                            showDialogPop();
                          }
                          print(signupList);

                        },
                        child: Text('가입하기', style: TextStyle(
                            fontSize: ((MediaQuery.of(context).size.width) * 0.16) *  0.26
                        ),),
                        style: ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                          primary : Color(0xffCF2525),),
                      ),
                    ),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height) * 0.085,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => loginPage()),
                          );
                        }, child: Text('이미 계정이 있으신가요? 로그인',style: TextStyle(
                          fontSize:
                          ((MediaQuery.of(context).size.width) * 0.16) * 0.26,
                          color: Color(0xffCF2525)),
                      ),),
                    ),
                  ],
                ),
              ),
            ],

          ),
        ),),);
  }
}
