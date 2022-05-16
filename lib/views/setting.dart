import 'package:flutter/material.dart';
import 'navbar.dart';
import 'navbartest.dart';


class setting extends StatelessWidget {
  const setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Container(
            color: Colors.grey,
            child: SizedBox(
              height: (MediaQuery.of(context).size.height) *0.8,
              width: (MediaQuery.of(context).size.width)*0.8,
              child: Text(
                'test'
              ),
            ),
          )
        ],

      ),
        bottomNavigationBar:  navbartest()

    );
  }
}
