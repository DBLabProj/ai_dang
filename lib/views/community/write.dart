import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:ai_dang/dbHandler.dart';

import 'communityBuilder.dart';


var colorBlack = const Color(0xff535353);
var colorRed = const Color(0xffCF2525);
var colorLightGray = const Color(0xffF3F3F3);
var colorGray = const Color(0xffE0E0E0);
var colorDarkGray = const Color(0xffADADBE);
var colorOrange = const Color(0xffFBAA47);
var colorGreen = const Color(0xff8AD03C);

class community extends StatefulWidget {

  const community({Key? key}) : super(key: key);

  @override
  State<community> createState() => _communityState();
}

class _communityState extends State<community> {
  bool _isLoading = false;
  int pageStart = 0;
  List<Widget> _boardList = [];

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      getBoardList(pageStart).then((boardList) {
        setState(() {
          _boardList = boardList;
        });
      });
    }

    Widget _myInfo() {
      return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '아이당 커뮤니티',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: (MediaQuery.of(context).size.width)*0.04
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return LoadingOverlay(
      isLoading: _isLoading,
      opacity: 0.7,
      color: Colors.black,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _myInfo(),
            ],
          ),
        ),
      ),
    );
    // return Scaffold
  }
}