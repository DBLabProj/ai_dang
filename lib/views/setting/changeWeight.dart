import 'package:flutter/material.dart';

class changeWeight extends StatefulWidget {
  const changeWeight({Key? key}) : super(key: key);

  @override
  _changeWeightState createState() => _changeWeightState();
}

class _changeWeightState extends State<changeWeight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Text(
          'changeWeight 페이지'
        ),
      ),
    );
  }
}
