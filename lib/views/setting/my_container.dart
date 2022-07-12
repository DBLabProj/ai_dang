import 'package:ai_dang/views/setting/test.dart';
import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  MyContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  var colorRed = const Color(0xffCF2525);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => test())
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: child,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            color: colorRed,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 8.0, // soften the shadow
                spreadRadius: 4.0, //extend the shadow
                offset: Offset(
                  8.0, // Move to right 10  horizontally
                  8.0, // Move to bottom 10 Vertically
                ),
              ),
              BoxShadow(
                color: Colors.white.withAlpha(130),
                blurRadius: 8.0, // soften the shadow
                spreadRadius: 4.0, //extend the shadow
                offset: Offset(
                  -8.0, // Move to right 10  horizontally
                  -8.0, // Move to bottom 10 Vertically
                ),
              ),
            ]),
      ),
    );
  }
}