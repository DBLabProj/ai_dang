import 'package:ai_dang/utils/request.dart';
import 'package:ai_dang/utils/session.dart';
import 'package:ai_dang/views/account/signup.dart';
import 'package:ai_dang/widgets/colors.dart';
import 'package:ai_dang/widgets/mealListBuilder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ai_dang/utils/dbHandler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../main.dart';
import '../widgets/myTextField.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  MyTextField emailField =
      MyTextField('email', Icons.email, '이메일', '이메일을 입력하세요.');
  MyTextField passwordField =
      MyTextField('password', Icons.vpn_key, '비밀번호', '비밀번호를 입력하세요.');

  void checkUser(email, password) async {
    EasyLoading.show(status: '로그인 중..');
    var result = await checkLogin(email, password);
    if (result['status'] == true) {
      login();
    } else {
      showErrorMessage();
    }
  }

  void login() async {
    await getUserInfo(emailField.getText());
    // 초깃값 식단 불러오기
    EasyLoading.dismiss();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage()),
    );
  }

  void showErrorMessage() {
    EasyLoading.dismiss();
    showDialog(
      context: context,
      barrierDismissible: true,
      // false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            //제목 정의
            '계정 정보가 다릅니다.',
          ),
          content: SingleChildScrollView(
            //내용 정의
            child: ListBody(
              children: const <Widget>[
                Text(
                  '이메일과 비밀번호를 확인 해주세요!',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 현재 화면을 종료하고 이전 화면으로 돌아가기
              },
              child: const Text(
                '닫기',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState()  {
    temp();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double areaWidth = (MediaQuery.of(context).size.width) * 0.75;
    if (areaWidth > 300) {
      areaWidth = 300;
    }

    emailField.setOnSubmitted((void val) {
        FocusScope.of(context).nextFocus();
    });
    // passwordfield에 엔터키 누르면 로그인기능
    passwordField.setOnSubmitted((void val) {
      checkUser(emailField.getText(),
          passwordField.getText());
    });

    return GestureDetector(
      onTap: () {
        //FocusManager.instance.primaryFocus?.unfocus();
        FocusScope.of(context).unfocus();
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          // logo ----------------------------------------------------
                          SizedBox(
                              height: 100,
                              child: Image.asset('assets/image/logo.png',
                                  fit: BoxFit.fitHeight)),
                          // title ---------------------------------------------------
                          Text(
                            'AI DANG',
                            style: TextStyle(
                              fontSize: 48,
                                fontWeight: FontWeight.w600, color: red),
                          ),
                          // desc ----------------------------------------------------
                          Text(
                            '나만의 스마트한 당뇨관리 영양사',
                            style: TextStyle(
                              fontSize: 18,
                                color: red),
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          // 입력 폼 ----------------------------------------------------
                          emailField.getWidget(),
                          const SizedBox(
                            height: 20,
                          ),
                          passwordField.getWidget(),
                          const SizedBox(
                            height: 100,
                          ),
                          // 지금 시작하기 버튼 -------------------------------------------
                          SizedBox(
                            width: areaWidth * 0.75,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                checkUser(emailField.getText(),
                                    passwordField.getText());
                              },
                              child:
                                  const Text('지금 시작하기', textScaleFactor: 1.4),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                primary: red,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          // 회원가입 버튼 -----------------------------------------------
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signup()),
                              );
                            },
                            child: Text(
                              '처음이신가요? 회원가입',
                              textScaleFactor: 1.2,
                              style: TextStyle(color: red),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
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
    );
  }
}
