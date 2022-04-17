import 'package:flutter/material.dart';
import 'navbar.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

var colorGray = Color(0xff535353);
var colorRed = Color(0xffCF2525);
var colorLightGray = Color(0xffF3F3F3);
var colorDarkGray = Color(0xffE0E0E0);
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        fontFamily: 'Noto_Sans_KR',
      ),
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _count = 0;
  var _selectedDay = DateTime.now();
  var _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              children: [
                // 캘린더
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      // 캘린더
                      TableCalendar(
                        locale: 'ko_KR',
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        daysOfWeekHeight: 20,
                        focusedDay: _selectedDay,
                        calendarFormat: _calendarFormat,
                        availableCalendarFormats: const {
                          CalendarFormat.month: 'Month',
                          CalendarFormat.week: 'Week',
                        },
                        calendarStyle: const CalendarStyle(
                          isTodayHighlighted: false,
                        ),
                        headerStyle: const HeaderStyle(
                            headerPadding: EdgeInsets.all(20),
                            formatButtonVisible: false,
                            rightChevronVisible: false,
                            leftChevronVisible: false),
                        selectedDayPredicate: (day) {return isSameDay(_selectedDay, day);},
                        onDaySelected: (selectedDay, focusedDay) {
                          if (!isSameDay(_selectedDay, selectedDay)) {
                            // Call `setState()` when updating the selected day
                            setState(() {
                              _selectedDay = selectedDay;
                            });
                          }
                        },
                        calendarBuilders: CalendarBuilders(
                            selectedBuilder: (context, day, focusedDay) {
                              var strDay = DateFormat.d().format(day);
                              return Center(
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: colorRed,
                                        shape: BoxShape.circle
                                    ),
                                    child: Center(
                                        child: Text(strDay,
                                          style: TextStyle(color: Colors.white),
                                        ))
                                ),
                              );
                            },

                            headerTitleBuilder: (context, day) {
                              var strDay = DateFormat("yyyy년 M월").format(day);
                              var iconBtn;
                              if(_calendarFormat == CalendarFormat.week) {
                                iconBtn = IconButton(
                                    onPressed: (){
                                      setState((){
                                        _calendarFormat = CalendarFormat.month;
                                      });},
                                    icon: const Icon(Icons.keyboard_arrow_down)
                                );
                              } else {
                                iconBtn = IconButton(
                                    onPressed: (){
                                      setState((){
                                        _calendarFormat = CalendarFormat.week;
                                      });},
                                    icon: const Icon(Icons.keyboard_arrow_up)
                                );
                              }
                              return Row(
                                children: [
                                  Text(strDay,
                                      style: TextStyle(color: colorRed, fontSize: 21,fontWeight: FontWeight.w600)
                                  ),
                                  Center(child: iconBtn)
                                ],
                              );
                            }
                        ),
                      ),
                    ],
                  )
                ),
                // 구분선, 영양분 섭취정보
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                  child: Column(
                    children: [
                      // 구분선
                      const Divider(),
                      // 총 칼로리 섭취량
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('하루 섭취량',),
                            Text('694 / 1,428 kcal', style: TextStyle(fontSize: 17),)
                          ],
                        ),
                      ),
                      // 일간 영양정보
                      Padding(padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 탄수화물 섭취정보
                            Column(
                              children: [
                                const Text('탄수화물'),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 13, 0, 13),
                                  child: SizedBox(
                                    width: 110,
                                    height: 5,
                                    child: LinearProgressIndicator(
                                      backgroundColor: colorDarkGray,
                                      valueColor: AlwaysStoppedAnimation(colorRed),
                                      value: 0.40,
                                    ),
                                  ),
                                ),
                                const Text('78 / 196 g'),
                              ],
                            ),
                            // 단백질 섭취정보
                            Column(
                              children: [
                                const Text('단백질'),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 13, 5, 13),
                                  child: SizedBox(
                                    width: 110,
                                    height: 5,
                                    child: LinearProgressIndicator(
                                      backgroundColor: colorDarkGray,
                                      valueColor: AlwaysStoppedAnimation(colorRed),
                                      value: 0.50,
                                    ),
                                  ),
                                ),
                                const Text('39 / 71 g'),
                              ],
                            ),
                            // 지방 섭취정보
                            Column(
                              children: [
                                const Text('지방'),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 13, 5, 13),
                                  child: SizedBox(
                                    width: 110,
                                    height: 5,
                                    child: LinearProgressIndicator(
                                      backgroundColor: colorDarkGray,
                                      valueColor: AlwaysStoppedAnimation(colorRed),
                                      value: 0.35,
                                    ),
                                  ),
                                ),
                                const Text('15 / 40 g'),
                              ],
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),

                Expanded(
                  flex: 7,
                  child: Container(
                    color: colorLightGray,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _count++),
        tooltip: 'Increment Counter',
        backgroundColor: colorRed,
        child: const Icon(Icons.add, size: 42),
      ),
      bottomNavigationBar: Navbar()
    );
  }
}
