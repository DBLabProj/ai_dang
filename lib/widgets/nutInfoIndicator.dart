import 'package:ai_dang/utils/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

Widget nutInfoIndicator(List<double> values, int servingSize) {
  List<Widget> list = [];
  List<String> words = ['탄수화물', '단백질', '지방', '총당류'];
  double _size = 38;
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
      width: 46,
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
                        strokeWidth: 6,
                        backgroundColor: red.withOpacity(0.2),
                        value: ( value / recommValues[i]),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${ value.toInt().toString()}g',
                      style: TextStyle(fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(width: 46,child: Center(child:Text(words[i], style: const TextStyle(fontSize: 12),)))
          ],
        ));
    list.add(elm);
    list.add(const SizedBox(width: 3));
  }
  return Row(children: list, mainAxisAlignment: MainAxisAlignment.center,);
}
