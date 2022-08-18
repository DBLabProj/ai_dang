import 'package:ai_dang/utils/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

List<Widget> nutInfoIndicator(List<double> values, int servingSize) {
  List<Widget> list = [];
  List<String> words = ['탄수화물', '단백질', '지방', '총당류'];
  double _size = 48;
  List recommValues = [
    Session.instance.dietInfo['recom_hydrate'],
    Session.instance.dietInfo['recom_protein'],
    Session.instance.dietInfo['recom_fat'],
    Session.instance.dietInfo['recom_sugar'],
  ];

  for (int i = 0; i < 4; i ++) {
    int value = (values[i] * (0.5 + (servingSize * 0.5))).toInt();
    Widget elm =
    SizedBox(
      width: 52,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: _size,
              height: _size,
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: _size,
                      height: _size,
                      child: CircularProgressIndicator(
                        color: red,
                        
                        strokeWidth: 7,
                        backgroundColor: red.withOpacity(0.2),
                        value: ( value / recommValues[i]),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${ value.toInt().toString()}g',
                      textScaleFactor: 1.2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: red,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(words[i], textScaleFactor: 0.9,),
          ],
        ));
    list.add(elm);
  }
  return list;
}
