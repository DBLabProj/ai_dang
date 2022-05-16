import 'package:ai_dang/main.dart';
import 'package:ai_dang/views/age.dart';
import 'package:ai_dang/views/diseasetype.dart';
import 'package:ai_dang/views/setting.dart';
import 'package:flutter/material.dart';
import 'package:ai_dang/views/home.dart';

import 'genderpage.dart';

class navbartest extends StatefulWidget {
  const navbartest({Key? key}) : super(key: key);

  @override
  _navbartestState createState() => _navbartestState();
}

class _navbartestState extends State<navbartest> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _switchScreen(_selectedIndex);
    });
  }


  void _switchScreen(index){
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyStatefulWidget()
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyApp()
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyApp()
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => setting()
          ),
        );
        break;

    }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (MediaQuery.of(context).size.height) * 0.08,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xffCF2525),
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Statistics',
              icon: Icon(Icons.insert_chart),
            ),
            BottomNavigationBarItem(
              label: 'My Page',
              icon: Icon(Icons.person),
            ),
            BottomNavigationBarItem(
              label: 'Setting',
              icon: Icon(Icons.settings ),
            ),
          ],
        ),
      ),
    );
  }
}
