import 'package:flutter/material.dart';

class setting extends StatefulWidget {

  const setting({Key? key}) : super(key: key);

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(

          child: Column(
            children: <Widget>[
              SizedBox(
                height: (MediaQuery.of(context).size.height) * 0.08,
              ),

                Container(
                  // color: Colors.grey,
                  height: (MediaQuery.of(context).size.height) *0.27,
                  width: (MediaQuery.of(context).size.width)*0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '  계정 설정',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: (MediaQuery.of(context).size.width)*0.04
                      ),
                      ),
                      TextButton(
                        onPressed: () {},
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
                          onPressed: () {},
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

              Container(
                // color: Colors.grey,
                height: (MediaQuery.of(context).size.height) *0.22,
                width: (MediaQuery.of(context).size.width)*0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '  알림 설정',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: (MediaQuery.of(context).size.width)*0.04
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
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
              Container(
                // height: (MediaQuery.of(context).size.height) *0.25,
                width: (MediaQuery.of(context).size.width)*0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '  일반 설정',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: (MediaQuery.of(context).size.width)*0.04
                      ),
                    ),
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
        // bottomNavigationBar:  navbartest()

    );
  }
}