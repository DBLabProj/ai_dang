import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../dbHandler.dart';
import '../session.dart';

var colorBlack = const Color(0xff535353);
var colorRed = const Color(0xffCF2525);
var colorLightGray = const Color(0xffF3F3F3);
var colorGray = const Color(0xffE0E0E0);
var colorDarkGray = const Color(0xffADADBE);
var colorOrange = const Color(0xffFBAA47);
var colorGreen = const Color(0xff8AD03C);

Future getMealList(context, selectedDay) async {
  List<Widget> list = [const SizedBox(height: 20)];
  Map eatInfo = {
    'cal': 0,
    'protein': 0,
    'fat': 0,
    'cbHydra': 0,
    'cbHydra_per': 0.0,
    'protein_per': 0.0,
    'fat_per': 0.0
  };
  String userId = Session.instance.userInfo['email'].toString();
  var sqlRs = await selectDayMeal(selectedDay, userId);
  for (var row in sqlRs) {
    String mealName = row[0];
    String datetime = DateFormat.jm('ko_KR').format(row[1]);
    int amount = row[2];
    String desc = row[3];
    String imageName = row[4];

    double totalSugar = row[5];
    double cal = row[6];
    double protein = row[7];
    double fat = row[8];
    double cbHydra = row[9];

    eatInfo['cal'] += (cal * (amount / 2)).toInt();
    eatInfo['cbHydra'] += (cbHydra * (amount / 2)).toInt();
    eatInfo['protein'] += (protein * (amount / 2)).toInt();
    eatInfo['fat'] += (fat * (amount / 2)).toInt();

    eatInfo['cbHydra_per'] =
    (eatInfo['cbHydra'] / Session.instance.dietInfo['recom_hydrate']);
    eatInfo['protein_per'] =
    (eatInfo['protein'] / Session.instance.dietInfo['recom_protein']);
    eatInfo['fat_per'] =
    (eatInfo['fat'] / Session.instance.dietInfo['recom_fat']);

    list.add(getMealComponent(context, mealName, datetime, amount.toString(),
        desc, imageName, totalSugar));
    list.add(const SizedBox(height: 20));
  }
  return {'meal_list': list, 'eat_info': eatInfo};
}

Future getTodayMeal(context) async {
  var today = DateTime.now().toUtc().add(const Duration(hours: 9));
  var sqlResult = await getMealList(context, today);
  List<Widget> mealList = sqlResult['meal_list'];
  Map eatInfo = sqlResult['eat_info'];
  return [mealList, eatInfo];
}


Future getSelectedDayMeal(context, selectedDay) async {
  var sqlResult = await getMealList(context, selectedDay);
  List<Widget> mealList = sqlResult['meal_list'];
  Map eatInfo = sqlResult['eat_info'];
  return [mealList, eatInfo];
}

Widget getMealComponent(
    context, mealName, datetime, amount, desc, imageName, totalSugar) {
  Color dangerColor;
  // 당류 먹은 비율 (0 ~ 1) ------------------------------------
  double eatSugarPercent =
      (totalSugar / Session.instance.dietInfo['recom_sugar']);

  // 위험도 컴포넌트 -------------------------------------------
  if (eatSugarPercent < 0.1) {
    dangerColor = const Color(0xff8AD03C);
  } else if (eatSugarPercent < 0.3) {
    dangerColor = const Color(0xffFCE403);
  } else if (eatSugarPercent < 0.5) {
    dangerColor = const Color(0xffFBAA47);
  } else {
    dangerColor = colorRed;
  }

  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.white),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      // 식단 컴포넌트 내용 시작
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 식단 이미지
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "http://203.252.240.74:5000/static/images/$imageName",
              fit: BoxFit.fitHeight,
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.width * 0.35,
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
                  mealName,
                  style: TextStyle(
                      color: colorBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                // 시간 및 식사종류
                const SizedBox(height: 7),
                Text(
                  "$datetime · $amount",
                  style: TextStyle(
                      color: colorDarkGray,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
                // 식단 설명
                const SizedBox(height: 20),
                Text(
                  desc,
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
                  borderRadius: BorderRadius.circular(4), color: dangerColor),
            ),
          ),
        ],
      ),
    ),
  );
}
