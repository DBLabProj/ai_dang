
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

    Widget boardInfo() {
      return Expanded(
        child: Container(
          color: colorLightGray,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 2, 40, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: _boardList,
              ),
            ),
          ),
        ),
      );
    }

    Widget addBoard() {
      return SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        iconTheme: const IconThemeData(size: 32),
        spacing: 10,
        spaceBetweenChildren: 4,
        backgroundColor: colorRed,
        onPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Write()),
          );
        },
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
                boardInfo(),
              ],
            ),
          ),
          floatingActionButton: addBoard(),
        ),
    );
    // return Scaffold
  }
}

class Write extends StatelessWidget {
  var writeBoardList = [];

  final _titleTextEditController = TextEditingController();

  final _contentTextEditController = TextEditingController();

  String _title = '';
  String _content = '';
  
  String checkConfirmDialog(_title, _content) {
    String title = _title;
    String content = _content;

    if(title.isEmpty == true) {
      String message = "제목을 입력해주세요.";

      return message;
    } else if (title.isNotEmpty && content.isEmpty) {

      String message = "내용을 입력해주세요.";
      return message;
    } else {
      String message = "등록이 완료되었습니다.";
      return message;
    }
  }



  @override
  Widget build(BuildContext context) {

    void showConfirmDialog(message) {
      showDialog(
        context: context,
        barrierDismissible: true,
        // false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
        builder: (BuildContext context) {
          return
            AlertDialog(
              title: Text(
                //제목 정의
                message,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 현재 화면을 종료하고 이전 화면으로 돌아가기
                    insertBoard(_title, _content);
                  },
                  child: Text(
                    '확인',
                  ),
                ),
              ],
            );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '아이당 커뮤니티',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: (MediaQuery.of(context).size.width)*0.04
          ),
        ),
        backgroundColor: colorRed,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 2, 20, 0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _titleTextEditController,
                    onChanged: (text) {
                      _title = text;
                    },
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Color(0xffCF2525)),
                      border: OutlineInputBorder(),
                      labelText: "제목",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Color(0xffCF2525)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    controller: _contentTextEditController,
                    onChanged: (text) {
                      _content = text;
                    },
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Color(0xffCF2525)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 200.0, horizontal: 10),
                      border: OutlineInputBorder(),
                      labelText: "내용",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Color(0xffCF2525)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                              '뒤 로 가 기',
                              style: TextStyle(
                                  color: colorRed,
                                  fontWeight: FontWeight.w500,
                                  fontSize: (MediaQuery.of(context).size.width)*0.04
                              ),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            showConfirmDialog(checkConfirmDialog(_title, _content));

                            Navigator.pop(context);
                        },
                          child: Text(
                              '작 성 하 기',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: (MediaQuery.of(context).size.width)*0.04
                              ),
                          ),
                        style: ElevatedButton.styleFrom(
                          primary: colorRed,
                        ),

                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        // child: RaisedButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   child: Text('Go back!'),
        // ),
      ),
    );
  }
}