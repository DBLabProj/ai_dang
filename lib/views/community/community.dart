
import 'package:ai_dang/views/predResult.dart';
import 'package:ai_dang/widgets/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:ai_dang/utils/dbHandler.dart';

import '../../utils/request.dart';
import '../../utils/session.dart';
import 'WritePost.dart';
import 'communityBuilder.dart';

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
                color: red,
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
        color: lightGrey,
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
                    style: const TextStyle(
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
                  primary: red,
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
          color: lightGrey,
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
        backgroundColor: red,
        onPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WritePost()),
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