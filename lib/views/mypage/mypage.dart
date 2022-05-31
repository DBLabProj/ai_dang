import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

var colorBlack = const Color(0xff535353);
var colorRed = const Color(0xffCF2525);
var colorLightGray = const Color(0xffF3F3F3);
var colorGray = const Color(0xffE0E0E0);
var colorDarkGray = const Color(0xffADADBE);
var colorOrange = const Color(0xffFBAA47);
var colorGreen = const Color(0xff8AD03C);

class mypage extends StatefulWidget {

  const mypage({Key? key}) : super(key: key);

  @override
  State<mypage> createState() => _mypageState();
}

class _mypageState extends State<mypage> {
  bool _isChecked = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {

    Widget _myInfo() {
      return Expanded(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    color: colorLightGray,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '내 정보',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: (MediaQuery.of(context).size.width)*0.04
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // const SizedBox(height: 40),
                  // 식단 컴포넌트
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      // 식단 컴포넌트 내용 시작
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 식단 이미지
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/image/male.png",
                              fit: BoxFit.fitHeight,
                              width: 50,
                              height: 50,
                            ),
                          ),
                          // 식단 정보
                          Expanded(
                              child: Padding(
                                // padding: const EdgeInsets.all(7.0),
                                padding: const EdgeInsets.fromLTRB(30, 7, 0, 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 식단 이름
                                    Text(
                                      "서시현",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    // 시간 및 식사종류
                                    Text(
                                      "남 / 만 24세 / 2형",
                                      style: TextStyle(
                                          color: colorDarkGray,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  // 구분선
                  const Divider(),


                ],
              ),
            ),
          ),
        ),
      );
    }

    return LoadingOverlay(
      isLoading: _isLoading,
      opacity: 0.7,
      color: Colors.black,
        child: Scaffold(
          body: Container(
            color: Colors.white,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(
                  children: [
                    _myInfo(),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
    // return Scaffold
  }
}