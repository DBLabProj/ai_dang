import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../dbHandler.dart';
import '../../session.dart';

var colorBlack = const Color(0xff535353);
var colorRed = const Color(0xffCF2525);
var colorLightGray = const Color(0xffF3F3F3);
var colorGray = const Color(0xffE0E0E0);
var colorDarkGray = const Color(0xffADADBE);
var colorOrange = const Color(0xffFBAA47);
var colorGreen = const Color(0xff8AD03C);

var User_id = Session.instance.userInfo['email'];
var recommentNum = 0;

class communityDetail extends StatefulWidget {
  final context, boardUid, boardTitle, boardContent, boardAdd, boardWriter;
  final commentUid, commentContent, commentReg, commentWriter;
  const communityDetail({Key? key,
  @required this.context, @required this.boardUid, @required this.boardTitle,
  @required this.boardContent, @required this.boardAdd, @required this.boardWriter,
  @required this.commentUid, @required this.commentContent, @required this.commentReg,
  @required this.commentWriter})
      : super(key: key);

  @override
  State<communityDetail> createState() => _communityDetailState();
}

class _communityDetailState extends State<communityDetail>{
  List<Widget> _commentList = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getComment(widget.boardUid),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          _commentList = snapshot.data;
        }
        final _commentTextEditController = TextEditingController();
        String _comment = '';
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //header section
                    //아이당 커뮤니티
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
                                  fontSize:
                                  (MediaQuery.of(context).size.width) * 0.04),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //info section
                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                      padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.boardTitle,
                              textScaleFactor: 1.1,
                              style: const TextStyle(color: Colors.black)),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.5, color: colorGray),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                          padding:
                          const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.boardAdd,
                                  textScaleFactor: 1.1,
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                          padding:
                          const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.boardWriter,
                                  textScaleFactor: 1.1,
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                      padding: const EdgeInsets.fromLTRB(15.0, 170.0, 15.0, 170.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.boardContent,
                              textScaleFactor: 1.1,
                              style: const TextStyle(color: Colors.black)),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.5, color: colorGray),
                          bottom: BorderSide(width: 1.5, color: colorGray),
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("댓글",
                              textScaleFactor: 1.1,
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    //댓글 리스트
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _commentList,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                          padding:
                          const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                          child: TextField(
                            controller: _commentTextEditController,
                            onChanged: (text) {
                              _comment = text;
                            },
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                  color: Color(0xffCF2525),
                                  fontSize: 15,
                                  height: 1),
                              labelText: "댓글을 입력해 주세요.",
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              insertComment(_comment, widget.boardUid, User_id);
                              setState(() {});
                              print(User_id);
                            },
                            child: Text(
                              '작성',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize:
                                  (MediaQuery.of(context).size.width) * 0.04),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: colorRed,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );

      },

    );
  }

  Future getComment(boardUid) async {
    List<Widget> list = [const SizedBox(height: 20)];

    String recommentContent='';
    String recommentReg='';
    String recommentWriter = '';
    var sqlRs = await commentList(boardUid);

    print('3');
    for (var row in sqlRs) {
      String commentUid = row[0].toString();
      String commentContent = row[1];
      String commentReg = DateFormat('MM-dd hh:mm').format(row[2]);
      String commentWriter = row[3];

      var sqlRs2 = await reCommentList(commentUid);
      print(sqlRs2);
      for (var row2 in sqlRs2) {
        String recommentUid = row[0].toString();
        String recommentContent = row[1];
        String recommentReg = DateFormat('MM-dd hh:mm').format(row[2]);
        String recommentWriter = row[3];

        list.add(getCommentComponent(
            commentUid, commentContent, commentReg, commentWriter, recommentContent, recommentReg, recommentWriter));
        list.add(const SizedBox(height: 20));
      }
      list.add(getCommentComponent(
          commentUid, commentContent, commentReg, commentWriter, recommentContent, recommentReg, recommentWriter));
      list.add(const SizedBox(height: 20));

    }
    return list;
  }

  // Future getReComment(commentUid) async {
  //   List<Widget> list = [const SizedBox(height: 20)];
  //
  //   var sqlRs = await reCommentList(commentUid);
  //   print('4');
  //
  //   for(var row in sqlRs) {
  //     String recommentUid = row[0].toString();
  //     String recommentContent = row[1];
  //     String recommentReg = DateFormat('MM-dd hh:mm').format(row[2]);
  //     String recommentWriter = row[3];
  //
  //   }
  // }

  Widget getCommentComponent(
      commentUid, commentContent, commentReg, commentWriter, recommentContent, recommentWriter, recommentReg) {
    final _recommentTextEditController = TextEditingController();
    String _recomment = '';
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.5, color: colorGray),
          )
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          commentWriter,
                          style: TextStyle(
                              color: colorBlack,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                        // const SizedBox(width: 40),
                        Text(
                          commentContent,
                          style: TextStyle(
                              color: colorDarkGray,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          commentReg,
                          style: TextStyle(
                              color: colorDarkGray,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 165,),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: (){
                              setState(() {
                                recommentNum = int.parse(commentUid);
                                print(recommentNum);
                              });
                            },
                            child: const Center(
                              child: Text("답글",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10
                                ),),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recommentWriter,
                      style: TextStyle(
                          color: colorBlack,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    // const SizedBox(width: 40),
                    Text(
                      recommentContent,
                      style: TextStyle(
                          color: colorDarkGray,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      recommentReg,
                      style: TextStyle(
                          color: colorDarkGray,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              if(recommentNum == int.parse(commentUid))...[
                Container(
                  width: 230,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  padding:
                  const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                  child: TextField(
                      controller: _recommentTextEditController,
                      onChanged: (text) {
                        _recomment = text;
                      },
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                            color: Color(0xffCF2525),
                            fontSize: 10,
                            height: 3),
                        labelText: "대댓글을 입력해 주세요.",
                      )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      insertReComment(_recomment, commentUid, User_id);
                      recommentNum = 0;
                      setState(() {});
                    },
                    child: const Text(
                      '작성',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,),),
                    style: ElevatedButton.styleFrom(
                      primary: colorRed,
                    ),
                  ),
                ),
              ]
            ],
          )
        ],
      ),
    );
  }
}