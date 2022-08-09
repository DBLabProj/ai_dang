import 'dart:convert';

import 'package:ai_dang/widgets/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_picker/flutter_picker.dart';

import '../main.dart';
import 'Statistics/statistics.dart';
import 'loginPage.dart';

class bloodCheck extends StatefulWidget {
  const bloodCheck({Key? key}) : super(key: key);

  @override
  _bloodCheckState createState() => _bloodCheckState();
}

class _bloodCheckState extends State<bloodCheck> {

  DateTime _selectedDay = DateTime.now().toUtc().add(const Duration(hours: 9));
  var _calendarFormat = CalendarFormat.week;

  var timeString ;
  final controller = TextEditingController();


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double areaWidth = (MediaQuery.of(context).size.width) * 0.75;
    if (areaWidth > 300) {
      areaWidth = 300;
    }
    
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            '혈당 기록하기',style: TextStyle(
              color: Colors.black
          ),
          ),
          elevation: 1,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          leading: IconButton(
            // padding: EdgeInsets.only(left:25),
            color: Colors.white,
            icon: Icon(Icons.chevron_left, color: colorRed,),
            iconSize: 45,
            onPressed: () =>
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage())
                ),
          ),
          actions: <Widget>[
            TextButton(onPressed: (){

            },
                child: Text(
                  '저장'
                ))
          ],
        ),
        body: Container(
          // color: Colors.white,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    date_time(),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height) * 0.07,
                    ),
                    insert_blood_data(),
                    time_detail(),
                    test_button(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget date_time(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 7),
      child: Container(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${_selectedDay}'.substring(0,4)+'년 '+'${_selectedDay}'.substring(5,7)+'월 '+'${_selectedDay}'.substring(8,10)+'일',
            textScaleFactor: 1.3,
              style: TextStyle(
            ),),


            Text('${_selectedDay}'.substring(11,13)+'시 '+'${_selectedDay}'.substring(14,16)+'분 ',
            textScaleFactor: 1.3,
              style: TextStyle(
            ),),
          ],
        ),
      ),
    );
  }


  Widget insert_blood_data(){
    return Container(
      // color: Colors.blue,
      // width: (MediaQuery.of(context).size.width)*0.7,

      height: (MediaQuery.of(context).size.height)*0.1,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: [

          picker_time(),
          Number_box(),
          mg_dl(),

        ],
      ),
    );
  }

  List<String> time = [
    '공복',
    '아침 식전',
    '아침 식후',
    '점심 식전',
    '점심 식후',
    '저녁 식전',
    '저녁 식후',
    '자기 전',
    '기타',
  ];

  Widget picker_time() {
    return Container(
      width: (MediaQuery.of(context).size.width)*0.4,
      height: (MediaQuery.of(context).size.height)*0.10,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    decoration: const BoxDecoration(
              border: Border(
                  left:BorderSide(width: 1, color: Colors.grey),
                right: BorderSide(width: 1, color: Colors.grey),
              )
          ),
      child: CupertinoPicker(
          itemExtent: 40,
          onSelectedItemChanged: (i) {
            setState(() {
              timeString = time[i];
            });
          },
          children: [
            ...time.map((e) => Center(
              child: Text(
                e,
                textScaleFactor: 1,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: colorRed
                ),
              ),
            ))
          ]),
    );
  }



  Widget Number_box() {
    return Container(
        width: (MediaQuery.of(context).size.width)*0.35,
        height: (MediaQuery.of(context).size.height)*0.2,
        // padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // TextField(
            //   onChanged: (test) {
            //     print("첫 번째 텍스트 : $test");
            //   },
            // ),
            // TextField(
            //   controller: controller,
            //
            // )

            TextField(
              controller: controller,
              decoration: InputDecoration(
              hintText: '120',
              hintStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: (MediaQuery.of(context).size.height) * 0.07,
                color: Colors.grey[300]
              ),

              contentPadding: EdgeInsets.only(left:30),
              border: InputBorder.none),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: (MediaQuery.of(context).size.height) * 0.07,
                color: colorRed
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
            ),
          ],
        ));
  }

  Widget mg_dl() {
    return Text(
      'mg/dL',
      style: TextStyle(
        color: Colors.grey[400],
        fontSize: (MediaQuery.of(context).size.height) * 0.025
      ),
    );
  }

  Widget time_detail() {
    return Text(
      '${controller.text}'
    );
  }


  Widget test_button() {
    double areaWidth = (MediaQuery.of(context).size.width) * 0.75;
    if (areaWidth > 300) {
      areaWidth = 300;
    }
    return SizedBox(
      width: areaWidth * 0.75,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if(timeString == null ){
            timeString = time[0];
          }
          print(timeString);
          print(controller.text);
        },
        child:
        const Text('지금 시작하기', textScaleFactor: 1.4),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
          primary: red,
        ),
      ),
    );
  }


}
