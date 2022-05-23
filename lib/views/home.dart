import 'package:ai_dang/views/navbartest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'navbar.dart';
import 'package:ai_dang/dbHandler.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';


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
  var rmicons = false;
  var _selectedDay = DateTime.now();
  var _calendarFormat = CalendarFormat.week;
  final picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {

    });
  }

  void printData() {
    var db = DbHandler();
    db.connect().then((conn) {
      db.printData(conn).then((results) {
        print(results);
      });
      conn.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                      backgroundColor: colorGray,
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
                                      backgroundColor: colorGray,
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
                                      backgroundColor: colorGray,
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
                // 식단 정보
                Expanded(
                  child: Container(
                    color: colorLightGray,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child:  SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            // 식단 컴포넌트
                            Container(
                              height: 220,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                // 식단 컴포넌트 내용 시작
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 식단 이미지
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset("assets/image/001.jpg",
                                        fit: BoxFit.fitHeight,
                                        width: 170, height: 180,),
                                    ),
                                    // 식단 정보
                                    Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // 식단 이름
                                              Text("돼지국밥",
                                                style: TextStyle(
                                                    color: colorBlack, fontSize: 18,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              // 시간 및 식사종류
                                              const SizedBox(height: 7),
                                              Text("오전 10:24 · 아침",
                                                style: TextStyle(
                                                    color: colorDarkGray, fontSize: 13,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                              // 식단 설명
                                              const SizedBox(height: 20),
                                              Text("시장 장터순대국밥\n꽤 맛있었는데 좀 짰음",
                                                style: TextStyle(
                                                    color: colorDarkGray, fontSize: 13,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                    // 혈당 정보 간략하게 표시하는 도형
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                                      child: Container(
                                        width: 20, height: 20,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: colorOrange
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // 식단 컴포넌트
                            Container(
                              height: 220,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                // 식단 컴포넌트 내용 시작
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 식단 이미지
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset("assets/image/002.jpg",
                                        fit: BoxFit.fitHeight,
                                        width: 170, height: 180,),
                                    ),
                                    // 식단 정보
                                    Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // 식단 이름
                                              Text("치즈버거",
                                                style: TextStyle(
                                                    color: colorBlack, fontSize: 18,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              // 시간 및 식사종류
                                              const SizedBox(height: 7),
                                              Text("오후 01:13 · 점심",
                                                style: TextStyle(
                                                    color: colorDarkGray, fontSize: 13,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                              // 식단 설명
                                              const SizedBox(height: 20),
                                              Text("맥도날드 치즈버거\n혈관이 텁텁하게 막히는 느낌",
                                                style: TextStyle(
                                                    color: colorDarkGray, fontSize: 13,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                    // 혈당 정보 간략하게 표시하는 도형
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                                      child: Container(
                                        width: 20, height: 20,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: colorRed
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // 식단 컴포넌트
                            Container(
                              height: 220,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                // 식단 컴포넌트 내용 시작
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 식단 이미지
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset("assets/image/003.jpg",
                                        fit: BoxFit.fitHeight,
                                        width: 170, height: 180,),
                                    ),
                                    // 식단 정보
                                    Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // 식단 이름
                                              Text("된장찌개",
                                                style: TextStyle(
                                                    color: colorBlack, fontSize: 18,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              // 시간 및 식사종류
                                              const SizedBox(height: 7),
                                              Text("오후 06:33 · 저녁",
                                                style: TextStyle(
                                                    color: colorDarkGray, fontSize: 13,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                              // 식단 설명
                                              const SizedBox(height: 20),
                                              Text("집밥 된장찌개\n간도 알맞고 꽤 맛있었음",
                                                style: TextStyle(
                                                    color: colorDarkGray, fontSize: 13,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                                      child: Container(
                                        width: 20, height: 20,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: colorGreen
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        tooltip: 'Increment Counter',
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
              getImage(ImageSource.camera);
              printData();},
          ),
          SpeedDialChild(
            child: const Icon(Icons.photo),
            backgroundColor: Colors.white,
            foregroundColor: colorBlack,
            label: '앨범에서 추가하기',

            onTap: () {
              getImage(ImageSource.gallery);
            },
          ),
        ],
      ),
      // bottomNavigationBar: const Navbar()
      // bottomNavigationBar: navbartest(),
    );
  }
}