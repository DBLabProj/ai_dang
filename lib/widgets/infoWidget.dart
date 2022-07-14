import 'package:ai_dang/views/predResult.dart';
import 'package:flutter/material.dart';

Widget infoWidget(label, value, {var labelColor = const Color(0xff535353)}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            textScaleFactor: 1,
            style: TextStyle(color: labelColor, fontWeight: FontWeight.w500)),
        Text(value,
            textScaleFactor: 1.1,
            style: TextStyle(color: black, fontWeight: FontWeight.w700))
      ],
    ),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 1.5, color: gray),
      ),
    ),
  );
}