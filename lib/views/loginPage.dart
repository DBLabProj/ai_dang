import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class loginPage extends StatelessWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
      //FocusManager.instance.primaryFocus?.unfocus();
      FocusScope.of(context).unfocus();
    },
    child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue,
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: (MediaQuery.of(context).size.height) * 0.15,
              ),
              Container(
                color: Colors.white,
                height: (MediaQuery.of(context).size.height) -
                    (MediaQuery.of(context).size.height) * 0.3,
                width: (MediaQuery.of(context).size.width) -
                    (MediaQuery.of(context).size.width) * 0.3,
                child: Column(
                  children: <Widget>[
                    Text(
                      'AI Dang',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: (MediaQuery.of(context).size.width) * 0.16,
                          color: Color(0xffCF2525)),
                    ),
                    Text(
                      '나만의 스마트한 당뇨관리 비서',
                      style: TextStyle(
                          fontSize:
                          ((MediaQuery.of(context).size.width) * 0.16) *
                              0.26,
                          color: Color(0xffCF2525)),
                    ),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height) * 0.15,
                    ),

                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Username',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Password',
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),),);
  }
}
