import 'package:ai_dang/dbHandler.dart';
import 'package:ai_dang/views/account/heightpage.dart';
import 'package:ai_dang/views/loginPage.dart';
import 'package:ai_dang/views/setting/changeAge.dart';
import 'package:ai_dang/views/setting/changeHeight.dart';
import 'package:ai_dang/views/setting/changeWeight.dart';
import 'package:ai_dang/views/setting/changeDt.dart';
import 'package:ai_dang/views/setting/setting.dart';
import 'package:ai_dang/views/setting/test.dart';
import 'package:flutter/material.dart';
import 'package:ai_dang/session.dart';

import '../../main.dart';
import 'circular_border_avatar.dart';
import 'my_container.dart';
class bodyInfoUpdate extends StatefulWidget {
  bodyInfoUpdate({Key? key}) : super(key: key);

  @override
  State<bodyInfoUpdate> createState() => _bodyInfoUpdateState();
}

class _bodyInfoUpdateState extends State<bodyInfoUpdate> {
  @override

  // 회원 정보 가져오기
  Future get_userInfoList(id) async{
    List UserInfoList = [];
    await get_userInfo(id).then((sqlRs)
    {
      for (var row in sqlRs) {
        String name = row[1];
        UserInfoList.add(name);
      }
    });
    return UserInfoList;
  }


  var User_name = Session.instance.userInfo['name'];
  var User_age = Session.instance.userInfo['age'];
  var User_dt = Session.instance.userInfo['dt'];
  var User_sex = Session.instance.userInfo['sex'];
  var User_height = Session.instance.userInfo['height'];
  var User_weight = Session.instance.userInfo['weight'];

  var colorRed = const Color(0xffCF2525);
  var outPadding = 32.0;
  var seedColor = Color(0xff00ffff);

  Widget build(BuildContext context) {
    return Stack(
        children: [
    Container(color: Theme.of(context).colorScheme.primary),
    Container(
    decoration: const BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
    Colors.white10,
    Colors.white10,
    Colors.black12,
    Colors.black12,
    Colors.black12,
    Colors.black12,
    ],
    )),
    ),

      Scaffold(
    backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(
            '프로필 변경',style: TextStyle(
            color: colorRed
          ),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey[200],
          leading: IconButton(
            // padding: EdgeInsets.only(left:25),
            color: Colors.white,
            icon: Icon(Icons.chevron_left, color: colorRed,),
            iconSize: 45,
            onPressed: () =>
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(pageNum : 3))
            ),
          ),
        ),

          body: WillPopScope(
            onWillPop: () {
              return Future(() => false);
            },
            child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(outPadding,0,outPadding,outPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
      // SizedBox(
      //   height: (MediaQuery.of(context).size.height) * 0.005,
      // ),
      Row(
        children: [
            Text(
              '안녕하세요 $User_name님',
              // textScaleFactor: 1.8,
              style: TextStyle(
                fontSize: (MediaQuery.of(context).size.width) * 0.08,
              color: colorRed,
                  fontWeight: FontWeight.bold),
            ),

            SizedBox(
              width: (MediaQuery.of(context).size.width) * 0.03,
            ),
            const Icon(
              Icons.account_circle,
              color: Colors.grey,
              size: 64,
            ),
        ],
      ),

      Text(
        '수정을 원하시는 프로필을 선택해주세요.',
        // textScaleFactor: 1.2,
        style: TextStyle(
              fontSize: (MediaQuery.of(context).size.width) * 0.035,
              color: colorRed
        ),
      ),
      SizedBox(
        height: (MediaQuery.of(context).size.height) * 0.02,
      ),

       _TopCard(),
       SizedBox(
         height: (MediaQuery.of(context).size.height) * 0.02,
      ),
      Row(
        children: [
            Expanded(
              child: Text(
                'My Profile',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(
                    color:
                    colorRed,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // _ActionBtn()
        ],
      ),
      SizedBox(
        height: (MediaQuery.of(context).size.height) * 0.02,
      ),
      Expanded(
        child: Row(
            children: [
              Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        flex: 3,
                        child: MyContainer(
                          link: changeAge(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  '$User_age',
                                  style: TextStyle(
                                      fontSize: (MediaQuery.of(context).size.width) * 0.08,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                  )
                                // fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '나이 수정하기',
                                style: TextStyle(
                                    fontSize: (MediaQuery.of(context).size.width) * 0.03,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: outPadding,
                      ),
                      Flexible(
                        flex: 2,
                        child: MyContainer(
                          link: changeWeight(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  '$User_weight',
                                  style: TextStyle(
                                      fontSize: (MediaQuery.of(context).size.width) * 0.08,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                  )
                              ),
                              Text(
                                '체중 수정하기',
                                style: TextStyle(
                                    fontSize: (MediaQuery.of(context).size.width) * 0.03,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                width: outPadding,
              ),
              Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        flex: 2,
                        child: MyContainer(
                          link: changeheight(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  '$User_height',
                                  style: TextStyle(
                                      fontSize: (MediaQuery.of(context).size.width) * 0.08,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                  )
                              ),
                              Text(
                                '신장 수정하기',
                                style: TextStyle(
                                    fontSize: (MediaQuery.of(context).size.width) * 0.03,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: outPadding,
                      ),
                      Flexible(
                        flex: 3,
                        child: MyContainer(
                          link: changeDt(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  '$User_dt',
                                  style: TextStyle(
                                      fontSize: (MediaQuery.of(context).size.width) * 0.08,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                  )
                              ),
                              SizedBox(
                                height: (MediaQuery.of(context).size.height) * 0.01,
                              ),
                              Text(
                                '당뇨유형 수정하기',
                                style: TextStyle(
                                    fontSize: (MediaQuery.of(context).size.width) * 0.03,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
        ),
      ),
      const SizedBox(height: 16)
                ],
              ),
            ),
        ),
          ),
        )
        ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  _ActionBtn({
    Key? key,
  }) : super(key: key);

  var colorRed = const Color(0xffCF2525);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print('test');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => test(),
          )
        );
      },
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorRed,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(130),
                blurRadius: 8.0, // soften the shadow
                spreadRadius: 4.0, //extend the shadow
                offset: const Offset(
                  8.0, // Move to right 10  horizontally
                  8.0, // Move to bottom 10 Vertically
                ),
              ),
              BoxShadow(
                color: Colors.white.withAlpha(130),
                blurRadius: 8.0, // soften the shadow
                spreadRadius: 4.0, //extend the shadow
                offset: const Offset(
                  -8.0, // Move to right 10  horizontally
                  -8.0, // Move to bottom 10 Vertically
                ),
              ),
            ]),
        child: Icon(
          Icons.calendar_today_rounded,
          color: Theme.of(context).colorScheme.onSurface,
          size: 16,
        ),
      ),
    );
  }
}



class _TopCard extends StatelessWidget {
  _TopCard({
    Key? key,
  }) : super(key: key);
  var colorRed = const Color(0xffCF2525);

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '아이당 프로필 수정 화면 테스트',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: Colors.white),
          ),
          Text(
            '아이당 프로필 수정 화면 테스트',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 32,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  width: 32,
                  top: 0,
                  bottom: 0,
                  child: CircularBorderAvatar(
                    'https://randomuser.me/api/portraits/women/68.jpg',
                    borderColor:
                    colorRed,
                  ),
                ),
                Positioned(
                  left: 22,
                  width: 32,
                  top: 0,
                  bottom: 0,
                  child: CircularBorderAvatar(
                    'https://randomuser.me/api/portraits/women/90.jpg',
                    borderColor:
                    colorRed,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Text(
                    'now',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

