import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_picker/flutter_picker.dart';

import '../main.dart';
import 'Statistics/statistics.dart';

class bloodCheck extends StatefulWidget {
  const bloodCheck({Key? key}) : super(key: key);

  @override
  _bloodCheckState createState() => _bloodCheckState();
}

class _bloodCheckState extends State<bloodCheck> {

  DateTime _selectedDay = DateTime.now().toUtc().add(const Duration(hours: 9));
  var _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '혈당 기록하기',style: TextStyle(
              color: Colors.black
          ),
          ),
          elevation: 2,
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
            new TextButton(onPressed: (){

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
                    calendar(),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height) * 0.02,
                    ),
                    insert_blood_data(),


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget calendar() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: [
            // 캘린더
            TableCalendar(
              locale: 'ko_KR',
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              daysOfWeekHeight: 23,
              focusedDay: _selectedDay,
              calendarFormat: _calendarFormat,
              calendarStyle: const CalendarStyle(
                isTodayHighlighted: false,
              ),
              headerStyle: const HeaderStyle(
                  headerPadding: EdgeInsets.all(15),
                  formatButtonVisible: false,
                  rightChevronVisible: false,
                  leftChevronVisible: false),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  if(mounted) {
                    setState(() {
                      _selectedDay = selectedDay;
                    });
                  }
                }
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  var strDay = DateFormat.d().format(day);
                  return Center(
                      child: Text(
                        strDay,
                        textScaleFactor: 1.2,
                      ));
                },
                outsideBuilder: (context, day, focusedDay) {
                  var strDay = DateFormat.d().format(day);
                  return Center(
                      child: Text(
                        strDay,
                        textScaleFactor: 1.2,
                        style: TextStyle(color: Colors.grey.shade400),
                      ));
                },
                dowBuilder: (context, day) {
                  final text = DateFormat('E', 'ko_KR').format(day);
                  var style = const TextStyle();
                  if (day.weekday == DateTime.sunday) {
                    style = const TextStyle(color: Colors.red);
                  }
                  return Center(
                      child: Text(text, textScaleFactor: 1.2, style: style));
                },
                selectedBuilder: (context, day, focusedDay) {
                  var strDay = DateFormat.d().format(day);
                  return Center(
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: colorRed, shape: BoxShape.circle),
                        child: Center(
                            child: Text(
                              strDay,
                              textScaleFactor: 1.2,
                              style: const TextStyle(color: Colors.white),
                            ))),
                  );
                },
                headerTitleBuilder: (context, day) {
                  var strDay = DateFormat("yyyy년 M월").format(day);
                  var iconBtn;
                  if (_calendarFormat == CalendarFormat.week) {
                    iconBtn = IconButton(
                        onPressed: () {
                          setState(() {
                            _calendarFormat = CalendarFormat.month;
                          });
                        },
                        icon: const Icon(Icons.keyboard_arrow_down, size: 32));
                  } else {
                    iconBtn = IconButton(
                        onPressed: () {
                          setState(() {
                            _calendarFormat = CalendarFormat.week;
                          });
                        },
                        icon: const Icon(Icons.keyboard_arrow_up, size: 32));
                  }
                  return Row(
                    children: [
                      Text(strDay,
                          textScaleFactor: 1.6,
                          style: TextStyle(
                              color: colorRed, fontWeight: FontWeight.w600)),
                      Center(child: iconBtn)
                    ],
                  );
                },
              ),
            ),
            Divider(),

          ],
        ));
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
          mg_dl()


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
    return Column(
      children: [
        Container(
          // color: Colors.grey,
          width: (MediaQuery.of(context).size.width)*0.4,
          height: (MediaQuery.of(context).size.height)*0.10,
          // padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
              border: Border(
                  left:BorderSide(width: 1, color: Colors.grey),
                right: BorderSide(width: 1, color: Colors.grey),
              )
          ),
          child: CupertinoPicker.builder(

              itemExtent: 40,
              childCount: time.length,
              onSelectedItemChanged: (i) {
                setState(() {
                  time = time[i] as List<String>;
                });
              },
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    time[index],style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.red
                  ),
                  ),
                );
              }),
        ),
      ],
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
            TextField(
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


}
