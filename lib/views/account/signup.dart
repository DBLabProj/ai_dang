import 'package:ai_dang/views/account/genderpage.dart';
import 'package:ai_dang/views/loginPage.dart';
import 'package:ai_dang/views/test.dart';
import 'package:flutter/material.dart';

import 'genderpage.dart';



class signup extends StatelessWidget {
  final _idTextEditController = TextEditingController();
  final _passwordTextEditController = TextEditingController();

  @override
  void dispose() {
    _idTextEditController.dispose();
    _passwordTextEditController.dispose();
  }

  signup({Key? key}) : super(key: key);


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

                    SizedBox(
                      width: (MediaQuery.of(context).size.width) -
                          (MediaQuery.of(context).size.width) * 0.35,
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


                        onChanged: (id) {
                          print('아이디 텍스트 필드 : $id');
                        },


                      ),
                    ),

                    SizedBox(height: (MediaQuery.of(context).size.height) * 0.01,
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width) -
                          (MediaQuery.of(context).size.width) * 0.35,
                      child: TextField(
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

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => genderpage()),
                          );
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
