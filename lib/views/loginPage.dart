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

  Future conn = DbHandler().connect();
  Future select = DbHandler().printData(DbHandler().connect());

  // @override
  // void dispose() {
  //   _idTextEditController.dispose();
  //   _passwordTextEditController.dispose();
  // }

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

                    SizedBox(height: (MediaQuery.of(context).size.height) * 0.01,
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

                    SizedBox(height: (MediaQuery.of(context).size.height) * 0.125,
                    ),

                    SizedBox(
                      height: (MediaQuery.of(context).size.height) * 0.065,
                      width: (MediaQuery.of(context).size.width) -
                          (MediaQuery.of(context).size.width) * 0.40,
                      child: ElevatedButton(
                        onPressed: () {

                          if (kDebugMode) {
                            print(_idTextEditController.text);
                            print( _passwordTextEditController.text);
                            print(select);
                          }


                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                          );
                        },
                          child: Text('지금 시작하기', style: TextStyle(
                            fontSize: ((MediaQuery.of(context).size.width) * 0.16) *  0.26
                          ),),
                          style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
                            borderRadius:  BorderRadius.circular(10.0)),
                            primary : Color(0xffCF2525),),
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
                          }, child: Text('처음이신가요? 회원가입',style: TextStyle(
                            fontSize:
                            ((MediaQuery.of(context).size.width) * 0.16) * 0.26,
                            color: Color(0xffCF2525)),
                        ),),
                        ),
                  ],
                ),
              )
            ],
          ),
        ),),);
  }
}
