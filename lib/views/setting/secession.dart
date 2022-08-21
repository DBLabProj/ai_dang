import 'package:ai_dang/utils/dbHandler.dart';
import 'package:ai_dang/utils/session.dart';
import 'package:ai_dang/views/Statistics/statistics.dart';
import 'package:ai_dang/widgets/colors.dart';
import 'package:flutter/material.dart';

import '../loginPage.dart';

class secession extends StatefulWidget {
  const secession({Key? key}) : super(key: key);

  @override
  _secessionState createState() => _secessionState();
}

class _secessionState extends State<secession> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;

  var result_list = [];

  var User_password = Session.instance.userInfo['password'];
  var User_email = Session.instance.userInfo['email'];

  final secession_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double areaWidth = (MediaQuery.of(context).size.width) * 0.75;
    if (areaWidth > 300) {
      areaWidth = 300;
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            '서비스 탈퇴',style: TextStyle(
              color: Colors.black
          ),
          ),
          elevation: 1,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          leading: IconButton(
            // padding: EdgeInsets.only(left:25),
            color: Colors.white,
            icon: Icon(Icons.chevron_left, color: colorRed,),
            iconSize: 45,
            onPressed: () =>
                Navigator.pop(context)
          ),
        ),
        body: Container(
          // color: Colors.white,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Text('''정말 떠나시는 건가요?
한번 더 생각해 보지 않으시겠어요?''',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),),
                    SizedBox(height: 30,),
                    Text('''계정을 삭제하시려는 이유를 말씀해주세요.        
제품 개선에 중요 자료로 활용하겠습니다.'''),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: Checkbox(
                            // fillColor: MaterialStateProperty.resolveWith(getColor),
                            activeColor: Colors.white,
                            checkColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            value: isChecked1,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked1 = value!;
                              });
                            },
                          ),
                        ),
                        Text('기록 삭제 목적'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: Checkbox(
                            // fillColor: MaterialStateProperty.resolveWith(getColor),
                            activeColor: Colors.white,
                            checkColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            value: isChecked2,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked2 = value!;
                              });
                            },
                          ),
                        ),
                        Text('이용이 불편하고 장애가 많아서'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: Checkbox(
                            // fillColor: MaterialStateProperty.resolveWith(getColor),
                            activeColor: Colors.white,
                            checkColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            value: isChecked3,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked3 = value!;
                              });
                            },
                          ),
                        ),
                        Text('다른 제품이 더 좋아서'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: Checkbox(
                            // fillColor: MaterialStateProperty.resolveWith(getColor),
                            activeColor: Colors.white,
                            checkColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            value: isChecked4,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked4 = value!;
                              });
                            },
                          ),
                        ),
                        Text('사용빈도가 낮아서'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: Checkbox(
                            // fillColor: MaterialStateProperty.resolveWith(getColor),
                            activeColor: Colors.white,
                            checkColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            value: isChecked5,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked5 = value!;
                              });
                            },
                          ),
                        ),
                        Text('콘텐츠 불편'),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: colorRed,
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0) // POINT
                        ),
                      ),
                      child: Text(
                        '계정을 삭제하면 회원님의 모든 콘텐츠와 활동내역, 데이터가 삭제됩니다.'
                            '삭제된 정보는 복구할 수 없으니 신중하게 결정해주세요.'
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text('사용중인 비밀번호'),
                     TextFormField(
                       controller: secession_controller,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.blue
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: colorRed
                            )
                        ),
                        hintText: '비밀번호',
                      ),
                    ),
                    Container(
                      height: (MediaQuery.of(context).size.height) * 0.065,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              result_list[0] = isChecked1;
                              result_list[1] = isChecked2;
                              result_list[2] = isChecked3;
                              result_list[3] = isChecked4;
                              result_list[4] = isChecked5;



                              print(result_list);

                              if (User_password == secession_controller.text) {
                                deleteUser(User_email);
                                showDialogPop('서비스 탈퇴 성공', '정상적으로 서비스 탈퇴와 모든 데이터가 삭제되었습니다.');
                                print('일치합니다.');
                              } else {
                                showDialogPop('비밀번호 오류', '비밀번호가 일치하지 않습니다. 다시 확인해주세요.');
                              }
                            },
                            child: Text('탈퇴하기', style: TextStyle(
                                color: Colors.white,
                                fontSize: ((MediaQuery.of(context).size.width) * 0.16) *  0.26
                            ),),
                            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                    color: Color(0xffCF2525)
                                )),
                              primary : colorRed,),
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

    );

  }


  void showDialogPop(title, content) {
    showDialog(
        context: context,
        barrierDismissible: true,
        // false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text(
                '$title'
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      '$content'
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: (){

                  if ('$title' == '서비스 탈퇴 성공') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => loginPage()),
                    );
                  } else{
                    Navigator.pop(context);
                  }
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
