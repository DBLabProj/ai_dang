
import 'package:ai_dang/views/predResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:ai_dang/dbHandler.dart';

import '../../session.dart';
import 'communityBuilder.dart';

var colorBlack = const Color(0xff535353);
var colorRed = const Color(0xffCF2525);
var colorLightGray = const Color(0xffF3F3F3);
var colorGray = const Color(0xffE0E0E0);
var colorDarkGray = const Color(0xffADADBE);
var colorOrange = const Color(0xffFBAA47);
var colorGreen = const Color(0xff8AD03C);

var User_id = Session.instance.userInfo['email'];

class community extends StatefulWidget {

  const community({Key? key}) : super(key: key);

  @override
  State<community> createState() => _communityState();
}

class _communityState extends State<community> {

  final _searchTextEditController = TextEditingController();

  String _search ='';
  String _boardUid = '';

  bool _isLoading = false;
  bool reloadCommandSearch = false;
  bool loadCommand = true;

  List<Widget> _boardList = [];

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      var pageStart = 0;
      if (loadCommand == true) {
        if(reloadCommandSearch == false) {
          getBoardList(context, pageStart, loadCommand, reloadCommandSearch, _search).then((boardList) {
            if(mounted) {
              setState(() {
                _boardList = boardList;
              });
            }
          });
        }
      }
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
                color: colorRed,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '아이당 커뮤니티',
                        style: TextStyle(
                            color: Colors.white,
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

    //검색창
   Widget searchBoard() {
      return Container(
        color: lightGray,
        padding: const EdgeInsets.fromLTRB(20, 2, 20 ,2),
        child: Column(
        children: [
          SizedBox(height: 20,),
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                    controller: _searchTextEditController,
                    onChanged: (text) {
                      _search = text;
                    },
                    style: TextStyle(
                      fontSize: 15
                    ),
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          height: 1
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: "검색",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Color(0xffCF2525)),
                      ),
                    ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  var pageStart = 0;
                  reloadCommandSearch = true;
                  getBoardList(context, pageStart, loadCommand, reloadCommandSearch, _search).then((boardList) {
                    setState(() {
                      _boardList = boardList;
                    });
                  });
                },
                child: Text(
                  '검색',
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
          ),
          SizedBox(height: 20,),
        ],
        ),
      );
    }

    Widget boardInfo() {
      return Expanded(
        child: Container(
          color: lightGray,
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

    //글쓰기
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
        child: GestureDetector(
          onTap: () {
            //FocusManager.instance.primaryFocus?.unfocus();
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  _myInfo(),
                  searchBoard(),
                  boardInfo(),
                ],
              ),
            ),
            floatingActionButton: addBoard(),
          ),
        ),
    );
    // return Scaffold
  }
}

//글쓰기 위젯
class Write extends StatelessWidget {
  var writeBoardList = [];

  final _titleTextEditController = TextEditingController();

  final _contentTextEditController = TextEditingController();

  String _title = '';
  String _content = '';

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
                    insertBoard(_title, _content, User_id);
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
              color: Colors.white,
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
                  ButtonTheme(
                    minWidth: (MediaQuery.of(context).size.width),
                      height: (MediaQuery.of(context).size.height) * 0.02,
                      child: OutlinedButton(
                        onPressed: () {

                        },
                        child: Text(
                          '이미지 첨부하기',
                          style: TextStyle(
                            color: colorRed,
                            fontWeight: FontWeight.w500,
                            fontSize: (MediaQuery.of(context).size.width)*0.04
                          ),
                        ),
                        )
                      ),
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
                            insertBoard(_title, _content, User_id);
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