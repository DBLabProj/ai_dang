import 'package:ai_dang/utils/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

Widget nutInfoIndicator(List<double> values) {
  List<Widget> list = [];
  List<String> words = ['탄수화물', '단백질', '지방', '총당류'];
  double _size = 40;
  List recommValues = [
    Session.instance.dietInfo['recom_hydrate'],
    Session.instance.dietInfo['recom_protein'],
    Session.instance.dietInfo['recom_fat'],
    Session.instance.dietInfo['recom_sugar'],
  ];

  for (int i = 0; i < 4; i ++) {
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
                        value: (values[i] / recommValues[i]),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${values[i].toInt().toString()}g',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(width: 50,child: Center(child:Text(words[i], style: TextStyle(fontSize: 12),)))
          ],
        ));
    list.add(elm);
    list.add(const SizedBox(width: 10.5));
  }
  return Row(children: list);
}
