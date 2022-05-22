import 'package:ai_dang/views/account/age.dart';
import 'package:ai_dang/views/test.dart';
import 'package:ai_dang/views/account/weightpage.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class heightpage extends StatefulWidget {
  const heightpage({Key? key}) : super(key: key);

  @override
  _heightpageState createState() => _heightpageState();
}

class _heightpageState extends State<heightpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: (MediaQuery.of(context).size.height) * 0.10,
            ),
            Container(
              color: Colors.white,
              height: (MediaQuery.of(context).size.height) -
                  (MediaQuery.of(context).size.height) * 0.1,
              width: (MediaQuery.of(context).size.width) -
                  (MediaQuery.of(context).size.width) * 0.3,
              child: Column(
                children: <Widget>[
                  Text(
                    '신장을 선택하세요.',
                    style: TextStyle(
                        fontSize:
                        ((MediaQuery.of(context).size.width) * 0.20) *
                            0.26,
                        color: Color(0xffCF2525)),
                  ),
                  SizedBox(height: (MediaQuery.of(context).size.height) * 0.05,
                  ),
                  SizedBox(
                    child: _IntegerExample(
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class _IntegerExample extends StatefulWidget {
  @override
  __IntegerExampleState createState() => __IntegerExampleState();
}

class __IntegerExampleState extends State<_IntegerExample> {
  int _currentIntValue = 100;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: (MediaQuery.of(context).size.height)*0.1),
        // Text('Default', style: Theme.of(context).textTheme.headline6),

        Stack(
          children: [
            Container(
              child: NumberPicker(
                  itemHeight: (MediaQuery.of(context).size.height)*0.10,
                  itemWidth: (MediaQuery.of(context).size.width)*0.6,
                  value: _currentIntValue,
                  minValue: 100,
                  maxValue: 200,
                  step: 1,
                  haptics: true,
                  decoration: BoxDecoration(
                      border: Border(
                        top:BorderSide(width: 1, color: Colors.grey),
                        bottom: BorderSide(width: 1, color: Colors.grey),
                      )
                  ),
                  selectedTextStyle: TextStyle(
                      fontSize: (MediaQuery.of(context).size.height)*0.065,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffCF2525)),
                  textStyle: TextStyle(
                      fontSize: (MediaQuery.of(context).size.height)*0.05,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff9E9E9E)),

                  onChanged: (value) => setState(() => _currentIntValue = value)
              ),
            ),
            Container(
              child: Positioned(
                bottom: (MediaQuery.of(context).size.height)*0.13,
                right: (MediaQuery.of(context).size.width)*0.1,
                child: Container(
                  child: Text('cm',style: TextStyle(
                      fontSize: (MediaQuery.of(context).size.height)*0.030,
                      color: Color(0xffCF2525)
                  ),),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: (MediaQuery.of(context).size.height) * 0.14,
        ),
        SizedBox(
          height: (MediaQuery.of(context).size.height) * 0.065,
          width: (MediaQuery.of(context).size.width) -
              (MediaQuery.of(context).size.width) * 0.4,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => weightpage()),
              );
            },
            child: Text('다음 단계로', style: TextStyle(
                fontSize: ((MediaQuery.of(context).size.width) * 0.16) *  0.26
            ),),
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
              primary : Color(0xffCF2525),),
          ),
        ),
        SizedBox(
          height: (MediaQuery.of(context).size.height) * 0.02,
        ),

        SizedBox(
          height: (MediaQuery.of(context).size.height) * 0.065,
          width: (MediaQuery.of(context).size.width) -
              (MediaQuery.of(context).size.width) * 0.4,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => agepage()),
              );
            },
            child: Text('이전 단계로', style: TextStyle(
                color: Color(0xffCF2525),
                fontSize: ((MediaQuery.of(context).size.width) * 0.16) *  0.26
            ),),
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                    color: Color(0xffCF2525)
                )),
              primary : Colors.white,),
          ),
        ),
      ],
    );
  }
}
