import 'package:ai_dang/session.dart';
import 'package:ai_dang/views/predResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ai_dang/request.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../widgets/mealListBuilder.dart';

var colorBlack = const Color(0xff535353);
var colorRed = const Color(0xffCF2525);
var colorLightGray = const Color(0xffF3F3F3);
var colorGray = const Color(0xffE0E0E0);
var colorDarkGray = const Color(0xffADADBE);
var colorOrange = const Color(0xffFBAA47);
var colorGreen = const Color(0xff8AD03C);

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MyStatefulWidget();
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  var rmicons = false;
  DateTime _selectedDay = DateTime.now().toUtc().add(const Duration(hours: 9));
  var _calendarFormat = CalendarFormat.week;
  final _picker = ImagePicker();

  Map _eatInfo = {};
  List<Widget> _mealList = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSelectedDayMeal(context, _selectedDay),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(!snapshot.hasData) {
          EasyLoading.show(status: '로딩 중..');
        } else {
          _eatInfo = snapshot.data[1];
          _mealList = snapshot.data[0];
          EasyLoading.dismiss();
        }
        return WillPopScope(
          onWillPop: () {
            return Future(() => false);
          },
          child: Scaffold(
            body: Container(
              color: Colors.white,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(
                    children: [
                      calendar(),
                      // 구분선, 영양분 섭취정보
                      takeNutInfo(),
                      // 식단 정보
                      mealInfo(),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: addImageDIal(),
          ),
        );
      },
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
          ],
        ));
  }

  Widget takeNutInfo() {

    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
      child: Column(
        children: [
          // 구분선
          const Divider(),
          // 총 칼로리 섭취량
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('하루 섭취량', textScaleFactor: 1.2),
                Text(
                    '${_eatInfo['cal']} / ${Session.instance.dietInfo['recom_cal']} kcal',
                    textScaleFactor: 1.3)
              ],
            ),
          ),
          // 일간 영양정보
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 탄수화물 섭취정보
                Column(
                  children: [
                    const Text('탄수화물', textScaleFactor: 1.2),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 13, 0, 13),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            backgroundColor: colorGray,
                            valueColor: AlwaysStoppedAnimation(colorRed),
                            value: _eatInfo['cbHydra_per'],
                          ),
                        ),
                      ),
                    ),
                    Text(
                        '${_eatInfo['cbHydra']} / ${Session.instance.dietInfo['recom_hydrate']} g',
                        textScaleFactor: 1.2),
                  ],
                ),
                // 단백질 섭취정보
                Column(
                  children: [
                    const Text('단백질', textScaleFactor: 1.2),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 13, 0, 13),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            backgroundColor: colorGray,
                            valueColor: AlwaysStoppedAnimation(colorRed),
                            value: _eatInfo['protein_per'],
                          ),
                        ),
                      ),
                    ),
                    Text(
                        '${_eatInfo['protein']} / ${Session.instance.dietInfo['recom_protein']} g',
                        textScaleFactor: 1.2),
                  ],
                ),
                // 지방 섭취정보
                Column(
                  children: [
                    const Text('지방', textScaleFactor: 1.2),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 13, 0, 13),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: 10,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            backgroundColor: colorGray,
                            valueColor: AlwaysStoppedAnimation(colorRed),
                            value: _eatInfo['fat_per'],
                          ),
                        ),
                      ),
                    ),
                    Text(
                        '${_eatInfo['fat']} / ${Session.instance.dietInfo['recom_fat']} g',
                        textScaleFactor: 1.2),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget mealInfo() {
    return Expanded(
      child: Container(
        color: colorLightGray,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 2, 20, 0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: _mealList,
            ),
          ),
        ),
      ),
    );
  }

  Widget addImageDIal() {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      iconTheme: const IconThemeData(size: 32),
      spacing: 10,
      spaceBetweenChildren: 4,
      backgroundColor: colorRed,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.camera_alt),
          backgroundColor: Colors.white,
          foregroundColor: colorBlack,
          label: '카메라로 추가하기',
          onTap: () {
            predict(context, ImageSource.camera, _picker);
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.photo),
          backgroundColor: Colors.white,
          foregroundColor: colorBlack,
          label: '앨범에서 추가하기',
          onTap: () {
            predict(context, ImageSource.gallery, _picker);
          },
        ),
      ],
    );
  }
}
