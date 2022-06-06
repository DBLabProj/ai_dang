import 'package:ai_dang/session.dart';
import 'package:ai_dang/views/account/signup.dart';
import 'package:ai_dang/views/test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ai_dang/dbHandler.dart';

import '../main.dart';
import 'home.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _idTextEditController = TextEditingController();
  final _passwordTextEditController = TextEditingController();

  bool Login_check = false;

  void user_check(Email, Password) async {
    var conn = await ConnHandler.instance.conn;

    var result = await conn.query(
        'select * from user where Email = "$Email" and Password = "$Password"');
    // 비어있으면 true
    if (result.isEmpty == false) {
      Login_check = true;
      return login_button();
    } else {
      Login_check = false;
      return showDialogPop_Login();
    }
    return print(Login_check);
  }

  void user_info(Email) async {
    var conn = await ConnHandler.instance.conn;

    var User_info_list = [];
    var result = await conn.query(
      'select name, email, age, sex, height, weight, dt, password from user where email = "$Email"');
    for (var row in result) {
      Session.instance.setInfo({
        'name': row[0],
        'email' : row[1],
        'age' : row[2],
        'sex' : row[3],
        'height' : row[4],
        'weight' : row[5],
        'dt' : row[6],
        'password' : row[7],
      });
    }
    return print(Session.instance.userInfo);
  }

  void login_button() async {
    user_info(_idTextEditController.text);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

  void showDialogPop_Login() {
    showDialog(
      context: context,
      barrierDismissible: true,
      // false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            //제목 정의
            '계정 정보가 다릅니다.',
          ),
          content: SingleChildScrollView(
            //내용 정의
            child: ListBody(
              children: <Widget>[
                Text(
                  'Email과 Password를 확인 해주세요!',
                ),
              ],
            ),
          ),
          actions: <Widget>[
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
                      'AI Dang',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: (MediaQuery.of(context).size.width) * 0.16,
                          color: Color(0xffCF2525)),
                    ),
                    Text(
                      '나만의 스마트한 당뇨관리 비서',
                      style: TextStyle(
                          fontSize:
                              ((MediaQuery.of(context).size.width) * 0.16) *
                                  0.26,
                          color: Color(0xffCF2525)),
                    ),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height) * 0.20,
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width) -
                          (MediaQuery.of(context).size.width) * 0.35,
                      child: TextField(
                        controller: _idTextEditController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          labelStyle: TextStyle(color: Color(0xffCF2525)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffCF2525)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffCF2525)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height) * 0.01,
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width) -
                          (MediaQuery.of(context).size.width) * 0.35,
                      child: TextField(
                        controller: _passwordTextEditController,
                        decoration: const InputDecoration(
                          // filled: true,
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          labelStyle: TextStyle(color: Color(0xffcf2525)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffCF2525)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(width: 1, color: Color(0xffCF2525)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height) * 0.125,
                    ),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height) * 0.065,
                      width: (MediaQuery.of(context).size.width) -
                          (MediaQuery.of(context).size.width) * 0.40,
                      child: ElevatedButton(
                        onPressed: () {
                          user_check(_idTextEditController.text,
                              _passwordTextEditController.text);
                        },
                        child: Text(
                          '지금 시작하기',
                          style: TextStyle(
                              fontSize:
                                  ((MediaQuery.of(context).size.width) * 0.16) *
                                      0.26),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          primary: Color(0xffCF2525),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height) * 0.085,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => signup()),
                          );
                        },
                        child: Text(
                          '처음이신가요? 회원가입',
                          style: TextStyle(
                              fontSize:
                                  ((MediaQuery.of(context).size.width) * 0.16) *
                                      0.26,
                              color: Color(0xffCF2525)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
