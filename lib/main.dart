import 'package:ai_dang/views/Statistics/statistics.dart';
import 'package:ai_dang/views/community/community.dart';
import 'package:flutter/material.dart';
import 'views/loginPage.dart';
import 'views/home.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ai_dang/views/setting/setting.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First App',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(builder: (context, child) {
        EasyLoading.instance.maskType = EasyLoadingMaskType.blur;
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      }),
      home: const loginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int index;
  const MyHomePage({
    Key? key,
    this.index = 0,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedIndex = widget.index;
    });
  }

  final List _pages = [
    const HomePage(),
    const statistics(),
    const community(),
    const setting()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xffCF2525),
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Statistics',
            icon: Icon(Icons.insert_chart),
          ),
          BottomNavigationBarItem(
            label: 'Community',
            icon: Icon(Icons.developer_board_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Setting',
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
