import 'package:ai_dang/views/setting/changePassword.dart';
import 'package:flutter/material.dart';

import '../../session.dart';
import '../loginPage.dart';

class setting extends StatefulWidget {

  const setting({Key? key}) : super(key: key);

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  bool _isChecked = false;

  var User_name = Session.instance.userInfo['name'];
  var User_age = Session.instance.userInfo['age'];
  var User_dt = Session.instance.userInfo['dt'];
  var User_sex = Session.instance.userInfo['sex'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: (MediaQuery.of(context).size.height),
          color: Colors.grey[200],
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: (MediaQuery.of(context).size.height) * 0.03,
                  ),
                    Container(
                      width: (MediaQuery.of(context).size.width)*0.8,
                      height: (MediaQuery.of(context).size.height) * 0.12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              child: Icon(Icons.account_circle,color: Colors.grey,
                              size: (MediaQuery.of(context).size.width)*0.15,),
                            ),
                          Container(
                            margin: EdgeInsets.only(top:17),
                            height: (MediaQuery.of(context).size.height) * 0.12,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                            height: (MediaQuery.of(context).size.height) * 0.04,
                                  child: Text(
                                    " $User_name님",style: TextStyle(
                                      fontSize: (MediaQuery.of(context).size.width)*0.05,
                                    fontWeight: FontWeight.w800
                                  ),
                                  ),
                                ),
                                Container(
                                    height: (MediaQuery.of(context).size.height) * 0.05,
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => loginPage()),
                                        );
                                      },
                                      child: Text('프로필 변경하기', style: TextStyle(
                                        // fontWeight: FontWeight.w500,
                                          fontSize: (MediaQuery.of(context).size.width)*0.025,
                                          color: Colors.black
                                      ),),
                                    ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height) * 0.02,
                  ),

                  Container(
                    width: (MediaQuery.of(context).size.width)*0.8,
                    height: ((MediaQuery.of(context).size.height) * 0.11),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '성별',style: TextStyle(
                                  fontSize: (MediaQuery.of(context).size.width)*0.03,
                                  color: Colors.black
                              ),
                              ),
                              SizedBox(
                                height: (MediaQuery.of(context).size.height)*0.01,
                              ),
                              Text(
                                '$User_sex', style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: (MediaQuery.of(context).size.width)*0.045,
                                  color: Color(0xffCF2525)
                              ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: (MediaQuery.of(context).size.height)*0.05,
                          child: VerticalDivider(
                            width: (MediaQuery.of(context).size.width)*0.16,
                            color: Colors.grey[200],thickness: 1.0,),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '나이',style: TextStyle(
                                  fontSize: (MediaQuery.of(context).size.width)*0.03,
                                  color: Colors.black
                              ),
                              ),
                              SizedBox(
                                height: (MediaQuery.of(context).size.height)*0.01,
                              ),
                              Text(
                                '$User_age세', style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: (MediaQuery.of(context).size.width)*0.045,
                                  color: Color(0xffCF2525)
                              ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: (MediaQuery.of(context).size.height)*0.05,
                          child: VerticalDivider(
                            width: (MediaQuery.of(context).size.width)*0.16,
                            color: Colors.grey[200],thickness: 1.0,),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '당뇨유형',style: TextStyle(
                                  fontSize: (MediaQuery.of(context).size.width)*0.03,
                                  color: Colors.black
                              ),
                              ),
                              SizedBox(
                                height: (MediaQuery.of(context).size.height)*0.01,
                              ),
                              Text(
                                '$User_dt', style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: (MediaQuery.of(context).size.width)*0.045,
                                  color: Color(0xffCF2525)
                              ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),


                  SizedBox(
                    height: (MediaQuery.of(context).size.height) * 0.03,
                  ),

                  Container(
                    width: (MediaQuery.of(context).size.width)*0.8,
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '  계정 설정',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: (MediaQuery.of(context).size.width)*0.04,
                            color: Color(0xffCF2525)
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height) * 0.01,
                  ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),

                      width: (MediaQuery.of(context).size.width)*0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => changepass())
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.password,color: Colors.red[300],),
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width)*0.05,
                                      ),
                                      Text('비밀번호 변경', style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: (MediaQuery.of(context).size.width)*0.035,
                                          color: Colors.black
                                      ),),
                                    ],
                                  ),
                                ),
                                Icon(Icons.chevron_right_outlined, color: Colors.black,),
                              ],
                            )
                          ),

                          TextButton(
                              onPressed: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => loginPage()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(Icons.logout,color: Colors.deepPurple,),
                                        SizedBox(
                                          width: (MediaQuery.of(context).size.width)*0.05,
                                        ),
                                        Text('로그아웃', style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: (MediaQuery.of(context).size.width)*0.035,
                                            color: Colors.black
                                        ),),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.chevron_right_outlined, color: Colors.black,),
                                ],
                              )
                          ),

                          TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(Icons.person_off,color: Colors.red[300],),
                                        SizedBox(
                                          width: (MediaQuery.of(context).size.width)*0.05,
                                        ),
                                        Text('서비스 탈퇴', style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: (MediaQuery.of(context).size.width)*0.035,
                                            color: Colors.black
                                        ),),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.chevron_right_outlined, color: Colors.black,),
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height) * 0.03,
                  ),

                  Container(
                    width: (MediaQuery.of(context).size.width)*0.8,
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '  알림 설정',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: (MediaQuery.of(context).size.width)*0.04,
                              color: Color(0xffCF2525)
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height) * 0.01,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),

                    width: (MediaQuery.of(context).size.width)*0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            // onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width)*0.015,
                                      ),
                                      Icon(Icons.notifications,color: Colors.yellowAccent[700],),
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width)*0.05,
                                      ),
                                      Text('푸쉬알림 사용', style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: (MediaQuery.of(context).size.width)*0.035,
                                          color: Colors.black
                                      ),),

                                    ],
                                  ),
                                ),
                                Switch(
                                  value: _isChecked,
                                  onChanged: (value){
                                    setState(() {
                                      _isChecked = value;
                                    });
                                  },
                                )
                              ],
                            )
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.brightness_4,color: Colors.lightBlueAccent,),
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width)*0.05,
                                      ),
                                      Text('방해금지 모드', style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: (MediaQuery.of(context).size.width)*0.035,
                                          color: Colors.black
                                      ),),
                                    ],
                                  ),
                                ),
                                Container(
                                    child: Row(
                                      children: [
                                        Text('23:00 ~ 07:00', style: TextStyle(
                                          color: Colors.grey
                                        ),),
                                        Icon(Icons.chevron_right_outlined, color: Colors.black,)
                                      ],
                                    )),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height) * 0.03,
                  ),

                  Container(
                    width: (MediaQuery.of(context).size.width)*0.8,
                    child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '  일반 설정',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: (MediaQuery.of(context).size.width)*0.04,
                              color: Color(0xffCF2525)
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height) * 0.01,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),

                    width: (MediaQuery.of(context).size.width)*0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.article,color: Colors.deepPurple,),
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width)*0.05,
                                      ),
                                      Text('마케팅 동의 설정', style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: (MediaQuery.of(context).size.width)*0.035,
                                          color: Colors.black
                                      ),),
                                    ],
                                  ),
                                ),
                                Container(
                                    child: Row(
                                      children: [
                                        Text('미동의', style: TextStyle(
                                            color: Colors.grey
                                        ),),
                                        Icon(Icons.chevron_right_outlined, color: Colors.black,)
                                      ],
                                    )),
                              ],
                            )
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.phone_android,color: Colors.lightBlueAccent,),
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width)*0.05,
                                      ),
                                      Text('버전 정보', style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: (MediaQuery.of(context).size.width)*0.035,
                                          color: Colors.black
                                      ),),
                                    ],
                                  ),
                                ),
                                Container(
                                    child: Row(
                                      children: [
                                        Text('alpha-1.0.0.1', style: TextStyle(
                                            color: Colors.grey
                                        ),),
                                      ],
                                    )),
                              ],
                            )
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.update,color: Colors.redAccent,),
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width)*0.05,
                                      ),
                                      Text('업데이트 확인', style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: (MediaQuery.of(context).size.width)*0.035,
                                          color: Colors.black
                                      ),),
                                    ],
                                  ),
                                ),
                                        Icon(Icons.chevron_right_outlined, color: Colors.black,)


                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // bottomNavigationBar:  navbartest()

    );
  }
}