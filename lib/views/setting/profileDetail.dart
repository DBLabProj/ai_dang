import 'package:ai_dang/views/setting/test.dart';
import 'package:flutter/material.dart';
import 'package:ai_dang/session.dart';

import 'circular_border_avatar.dart';
import 'my_container.dart';
class bodyInfoUpdate extends StatelessWidget {
  bodyInfoUpdate({Key? key}) : super(key: key);

  @override
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(outPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SizedBox(
              //         height: 100,
              //         child: Image.asset('assets/image/logo.png',
              //             fit: BoxFit.fitHeight)),
              //     // Expanded(child: Container()),
              //     // CircularBorderAvatar(
              //     //   'https://randomuser.me/api/portraits/women/26.jpg',
              //     //   borderColor: colorRed,
              //     // )
              //   ],
              // ),
              SizedBox(
                height: outPadding,
              ),
              Row(
                children: [

                  Text(
                    '안녕하세요 $User_name님',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: colorRed,
                        fontWeight: FontWeight.bold),
                  ),

                  SizedBox(
                    width: outPadding,
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
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: colorRed),
              ),
              SizedBox(
                height: outPadding,
              ),

               _TopCard(),
               SizedBox(
                height: outPadding,
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
                  _ActionBtn()
                ],
              ),
              SizedBox(
                height: outPadding,
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '$User_age',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '나이 수정하기',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                          color: Colors.white),
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '$User_weight',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '체중 수정하기',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                          color: Colors.white),
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '$User_height',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '신장 수정하기',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                          color: Colors.white),
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '$User_dt',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '당뇨유형 수정하기',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                          color: Colors.white),
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