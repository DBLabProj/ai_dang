import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

Widget nutInfoIndicator(List<int> values) {
  List<Widget> list = [];
  List<String> words = ['탄수화물', '단백질', '지방', '총당류'];
  for (int i = 0; i < 4; i ++) {
    Widget elm =
    SizedBox(
      width: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        color: red,
                        strokeWidth: 6,
                        backgroundColor: red.withOpacity(0.2),
                        value: 0.4,
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      '12g',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(width: 50,child: Center(child:Text(words[i], style: TextStyle(fontSize: 13),)))
          ],
        ));
    list.add(elm);
    list.add(const SizedBox(width: 10));
  }
  return Row(children: list);
}
