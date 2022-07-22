import 'package:ai_dang/dbHandler.dart';
import 'package:ai_dang/views/account/genderpage.dart';
import 'package:ai_dang/views/loginPage.dart';
import 'package:ai_dang/widgets/myTextField.dart';
import 'package:flutter/material.dart';

import 'genderpage.dart';

class signup extends StatefulWidget {
  signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  MyTextField nameField =
      MyTextField('email', Icons.account_circle, '닉네임', '닉네임을 입력하세요.');
  MyTextField passwordField =
      MyTextField('password', Icons.vpn_key, '비밀번호', '비밀번호를 입력하세요.');

  final _emailController = TextEditingController();
  final _pwCheckController = TextEditingController();

  var signupList = [];

  @override
  void dispose() {
    _emailController.dispose();
    _pwCheckController.dispose();
  }

  bool _emailChecked = false;
  bool _passwordChecked = false;
  Widget _emailLabel = const SizedBox();
  Widget _passwordLabel = const SizedBox();

  Future<bool> checkEmailDup(email) async {
    var conn = await ConnHandler.instance.conn;

    var result = await conn.query('select * from user where Email = "$email"');

    return result.isEmpty;
  }

  bool checkPassword() {
    if (passwordField.getText() == _pwCheckController.text) {
      return true;
    }
    return false;
  }

  void showDialogPop(title, desc) {
    showDialog(
      context: context,
      barrierDismissible: true,
      // false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            //내용 정의
            child: ListBody(
              children: <Widget>[
                Text(desc),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 현재 화면을 종료하고 이전 화면으로 돌아가기
              },
              child: const Text('닫기'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double areaWidth = (MediaQuery.of(context).size.width) * 0.75;
    if (areaWidth > 300) {
      areaWidth = 300;
    }

    return GestureDetector(
      onTap: () {
        //FocusManager.instance.primaryFocus?.unfocus();
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () {
          return Future(() => false);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
              child: SizedBox(
                width: areaWidth,
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            // title ---------------------------------------------------
                            Text(
                              '회원 가입하기',
                              style: TextStyle(
                                fontSize: 36,
                                  fontWeight: FontWeight.w600, color: red),
                            ),
                            // desc ----------------------------------------------------
                            Text(
                              '기본정보를 입력하세요.',
                              style: TextStyle(fontSize: 18, color: red),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            // 이메일 필드 -----------------------------------------
                            TextField(
                              controller: _emailController,
                              cursorColor: red,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              enableSuggestions: false,
                              autocorrect: false,
                              onChanged: (text) async {
                                _emailChecked = await checkEmailDup(text);
                                setState(() {
                                  if (text.isNotEmpty) {
                                    if (_emailChecked) {
                                      _emailLabel = const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('사용가능한 이메일입니다'),
                                      );
                                    } else {
                                      _emailLabel = Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '중복된 이메일입니다',
                                          style: TextStyle(color: red),
                                        ),
                                      );
                                    }
                                  } else {
                                    _emailLabel = SizedBox(height: 0);
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                labelText: '이메일',
                                hintText: '이메일을 입력하세요.',
                                labelStyle: TextStyle(color: darKGray),
                                prefixIcon: Icon(Icons.email, color: darKGray),
                                focusColor: red,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: gray),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: red),
                                ),
                              ),
                            ),
                            // 이메일 필드 라벨 -------------------------------------
                            Container(
                              width: areaWidth,
                              constraints: const BoxConstraints(minHeight: 10),
                              child: _emailLabel,
                            ),
                            nameField.getWidget(),
                            // 공백 -----------------------------------------------
                            const SizedBox(height: 10),
                            passwordField.getWidget(),
                            // 공백 -----------------------------------------------
                            const SizedBox(height: 10),
                            // 비밀번호 확인 필드 -----------------------------------
                            TextField(
                              controller: _pwCheckController,
                              cursorColor: red,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              onChanged: (text) {
                                _passwordChecked = checkPassword();
                                setState(() {
                                  if (text.isNotEmpty) {
                                    if (_passwordChecked) {
                                      _passwordLabel = const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('사용가능한 비밀번호 입니다.'),
                                      );
                                    } else {
                                      _passwordLabel = Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '두 비밀번호가 같지 않습니다.',
                                          style: TextStyle(color: red),
                                        ),
                                      );
                                    }
                                  } else {
                                    _passwordLabel = const SizedBox(height: 0);
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                labelText: '비밀번호 확인',
                                hintText: '비밀번호를 다시 입력하세요.',
                                labelStyle: TextStyle(color: darKGray),
                                prefixIcon: Icon(Icons.vpn_key, color: darKGray),
                                focusColor: red,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: gray),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: red),
                                ),
                              ),
                            ),
                            // 비밀번호 필드 라벨 -----------------------------------
                            Container(
                              width: areaWidth,
                              constraints: const BoxConstraints(minHeight: 10),
                              child: _passwordLabel,
                            ),
                            const SizedBox(height: 80),
                            SizedBox(
                              width: areaWidth * 0.75,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_emailController.text.isEmpty ||
                                      _pwCheckController.text.isEmpty ||
                                      nameField.getText().isEmpty ||
                                      passwordField.getText().isEmpty) {
                                    showDialogPop('유효하지 않은 값', '모든 내용을 입력해주세요.');
                                  } else {
                                    if (!_emailChecked) {
                                      showDialogPop(
                                          '이메일 중복', '중복된 이메일입니다. 다시 시도해주세요.');
                                    } else if (!_passwordChecked) {
                                      showDialogPop(
                                          '비밀번호 다름', '두 비밀번호가 같지 않습니다.');
                                    } else {
                                      signupList.add(_emailController.text);
                                      signupList.add(passwordField.getText());
                                      signupList.add(nameField.getText());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => genderpage(
                                                signUpList: signupList)),
                                      );
                                    }
                                  }
                                },
                                child:
                                    const Text('신체정보 입력하기', textScaleFactor: 1.4),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  primary: const Color(0xffCF2525),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => loginPage()),
                                );
                              },
                              child: Text(
                                '이미 계정이 있으신가요? 로그인',
                                textScaleFactor: 1.2,
                                style: TextStyle(color: red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
