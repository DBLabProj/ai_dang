import 'package:flutter/material.dart';
import 'navbar.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

var colorGray = Color(0xff535353);
var colorRed = Color(0xffCF2525);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                calendarFormat: CalendarFormat.week,
                locale: 'ko_KR',
                headerStyle: HeaderStyle(
                    headerPadding: const EdgeInsets.all(20),
                    titleTextStyle: TextStyle(
                        color: colorRed, fontSize: 21,
                        fontWeight: FontWeight.w600),
                    titleTextFormatter: (date, locale) =>
                        DateFormat("yyyy년 M월").format(date),
                    formatButtonVisible: false,
                    rightChevronVisible: false,
                    leftChevronVisible: false),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _count++),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Navbar()
    );
  }
}
