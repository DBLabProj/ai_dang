import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dbHandler.dart';

var colorBlack = const Color(0xff535353);
var colorRed = const Color(0xffCF2525);
var colorLightGray = const Color(0xffF3F3F3);
var colorGray = const Color(0xffE0E0E0);
var colorDarkGray = const Color(0xffADADBE);
var colorOrange = const Color(0xffFBAA47);
var colorGreen = const Color(0xff8AD03C);

class MealList {
  List _list = [];

  MealList() {
     connect().then((conn) {
       selectTodayMeal(conn).then((sqlRs) {
         for(var row in sqlRs) {
           print(row);
         }
       });
     });
  }

  Widget getMealComponent(datetime, amount, desc) {
    return Container(
        height: 220,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
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
                  "assets/image/001.jpg",
                  fit: BoxFit.fitHeight,
                  width: 170,
                  height: 180,
                ),
              ),
              // 식단 정보
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 식단 이름
                        Text(
                          "돼지국밥",
                          style: TextStyle(
                              color: colorBlack,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        // 시간 및 식사종류
                        const SizedBox(height: 7),
                        Text(
                          "오전 10:24 · 아침",
                          style: TextStyle(
                              color: colorDarkGray,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                        // 식단 설명
                        const SizedBox(height: 20),
                        Text(
                          "시장 장터순대국밥\n꽤 맛있었는데 좀 짰음",
                          style: TextStyle(
                              color: colorDarkGray,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )),
              // 혈당 정보 간략하게 표시하는 도형
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: colorOrange),
                ),
              ),
            ],
          ),
        ),
      );
  }
}