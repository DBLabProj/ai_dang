import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/dbHandler.dart';
import '../utils/session.dart';

var colorBlack = const Color(0xff535353);
var colorRed = const Color(0xffCF2525);
var colorLightGray = const Color(0xffF3F3F3);
var colorGray = const Color(0xffE0E0E0);
var colorDarkGray = const Color(0xffADADBE);
var colorOrange = const Color(0xffFBAA47);
var colorGreen = const Color(0xff8AD03C);

Future buildMealList(context, selectedDay) async {
  List<Widget> list = [const SizedBox(height: 20)];
  Map eatInfo = {
    'cal': 0,
    'protein': 0,
    'fat': 0,
    'cbHydra': 0,
    'cbHydra_per': 0.0,
    'protein_per': 0.0,
    'fat_per': 0.0,
    'total_sugar': 0.0
  };
  String userId = Session.instance.userInfo['email'].toString();
  var mealList = await selectDayMeal(selectedDay, userId);
  for (var meal in mealList) {
    String mealName = meal['foodList'][0]['name'];
    String datetime = DateFormat.jm('ko_KR').format(meal['datetime']);
    String desc = meal['description'];
    String imageName = meal['image_name'];

    for(var food in meal['foodList']) {
      var amount = food['amount'];
      eatInfo['cal'] += (food['nutrient']['energy'] * (amount / 2)).toInt();
      eatInfo['cbHydra'] += (food['nutrient']['carbohydrate'] * (amount / 2)).toInt();
      eatInfo['protein'] += (food['nutrient']['protein'] * (amount / 2)).toInt();
      eatInfo['fat'] += (food['nutrient']['fat'] * (amount / 2)).toInt();
      eatInfo['total_sugar'] += (food['nutrient']['total_sugar'] * (amount / 2)).toInt();
    }
    eatInfo['cbHydra_per'] =
    (eatInfo['cbHydra'] / Session.instance.dietInfo['recom_hydrate']);
    eatInfo['protein_per'] =
    (eatInfo['protein'] / Session.instance.dietInfo['recom_protein']);
    eatInfo['fat_per'] =
    (eatInfo['fat'] / Session.instance.dietInfo['recom_fat']);

    list.add(getMealComponent(context, mealName, datetime, '',
        desc, imageName, eatInfo['total_sugar']));
    list.add(const SizedBox(height: 20));
  }
  return {'meal_list': list, 'eat_info': eatInfo};
}

Future getSelectedDayMeal(context, selectedDay) async {

  var sqlResult = await buildMealList(context, selectedDay);
  List<Widget> mealList = await sqlResult['meal_list'];
  Map eatInfo = await sqlResult['eat_info'];
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
  String amountText = '';

  // 양 Text ------------------------------------------------
  if (amount == 1) {
    amountText = '1/2회 제공량';
  } else if(amount == 2) {
    amountText = '1회 제공량';
  } else if (amount == 3) {
    amountText = '1과 1/2회 제공량';
  } else {
    amountText = '2회 제공량';
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
              "http://203.252.240.74:5000/static/images/$imageName.jpg",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.width * 0.35,
            ),
          ),
          // 식단 정보
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 식단 이름
                Text(
                  mealName,
                  style: TextStyle(
                      color: colorBlack,
                      fontWeight: FontWeight.w600,
                  fontSize: 18),
                ),
                // 시간 및 식사종류
                const SizedBox(height: 7),
                Text(
                  "$datetime\n$amountText",
                  textScaleFactor: 1,
                  style: TextStyle(
                      color: colorDarkGray,
                      fontWeight: FontWeight.w400),
                ),
                // 식단 설명
                const SizedBox(height: 20),
                Text(
                  desc,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                      color: colorBlack,
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
