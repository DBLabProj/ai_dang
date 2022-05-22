import 'package:ai_dang/views/account/genderpage.dart';
import 'package:ai_dang/views/account/heightpage.dart';
import 'package:ai_dang/views/test.dart';
import 'package:ai_dang/dbHandler.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';


class testpage extends StatefulWidget {
  const testpage({Key? key}) : super(key: key);


  @override
  _testpageState createState() => _testpageState();
}
class _testpageState extends State<testpage> {

  final idTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  FocusNode idFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  // final _navService = GetIt.I<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: <Widget>[
            id(),
            password(),
            SizedBox(
              height: 50,
            ),
            button(),
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();

    idFocus.requestFocus();
  }


  Widget id() => Container(
    margin: EdgeInsets.only(top: 70),
    height: 53,
    child: TextField(
      controller: idTextController,
      onSubmitted: (_) {
        passwordFocus.requestFocus();
      },
      focusNode: idFocus,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        labelText: '아이디',
      ),
    ),
  );

  Widget password() => Container(
    margin: EdgeInsets.only(top: 15),
    height: 53,
    child: TextField(
      controller: passwordTextController,
      focusNode: passwordFocus,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        labelText: '비밀번호',
      ),
    ),
  );

  Widget button() => Container(
    margin: EdgeInsets.only(top: 15),
    height: 53,
    child: ElevatedButton(
      onPressed: () {
        print(idTextController.text);

      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Color(0xFF2C75F5),
        ),
      ),
      child: Text(
        "로그인",
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  @override
  void dispose() {
    idTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }
}
