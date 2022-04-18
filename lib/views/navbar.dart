import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: BottomNavigationBar(
        selectedItemColor: Color(0xffCF2525),
        type: BottomNavigationBarType.fixed,
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
            label: 'My Page',
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: 'Setting',
            icon: Icon(Icons.settings ),
          ),
        ],
      ),
    );
  }
}