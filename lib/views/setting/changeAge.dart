import 'package:flutter/material.dart';

class changeAge extends StatefulWidget {
  const changeAge({Key? key}) : super(key: key);

  @override
  _changeAgeState createState() => _changeAgeState();
}

class _changeAgeState extends State<changeAge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body:
      Text(
        'chageAge페이지'
      ),
    );
  }
}
