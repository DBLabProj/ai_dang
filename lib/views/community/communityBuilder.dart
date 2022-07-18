import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../dbHandler.dart';

var colorBlack = const Color(0xff535353);
var colorRed = const Color(0xffCF2525);
var colorLightGray = const Color(0xffF3F3F3);
var colorGray = const Color(0xffE0E0E0);
var colorDarkGray = const Color(0xffADADBE);
var colorOrange = const Color(0xffFBAA47);
var colorGreen = const Color(0xff8AD03C);

Future getBoardList(context, pageStart, loadCommand, reloadCommand, text) async {

  List<Widget> list = [const SizedBox(height: 20)];

  if(loadCommand == true && reloadCommand == false) {
    await boardList(pageStart).then((sqlRs) {
      for (var row in sqlRs) {
        String boardUid = row[0].toString();
        String boardTitle = row[1];
        String boardContent = row[2];
        String boardAdd = DateFormat.jm('ko-KR').format(row[3]);
        String boardWriter = row[4];

        list.add(
            getBoardComponent(context, boardUid, boardTitle, boardContent, boardAdd, boardWriter));
        list.add(const SizedBox(height: 20));
      }
    });
  } else if (loadCommand == true && reloadCommand == true) {
    await getBoard(text).then((sqlRs) {
      for (var row in sqlRs) {
        String boardUid = row[0].toString();
        String boardTitle = row[1];
        String boardContent = row[2];
        String boardAdd = DateFormat.jm('ko-KR').format(row[3]);
        String boardWriter = row[4];

        list.add(
            getBoardComponent(context, boardUid, boardTitle, boardContent, boardAdd, boardWriter));
        list.add(const SizedBox(height: 20));
      }
    });
  }

  return list;
}

Future getComment(boardUid) async {

  List<Widget> list = [const SizedBox(height: 20)];

  await commentList(boardUid).then((sqlRs) {
    for (var row in sqlRs) {
      String commentUid = row[0].toString();
      String commentContent = row[1];
      String commentReg = DateFormat.jm('ko-KR').format(row[2]);
      String commentWriter = row[3];

      print("-----------");
      print(commentUid);
      print(commentContent);
      print(commentReg);
      print(commentWriter);
      print("-----------");

      list.add(getCommentComponent(commentUid, commentContent, commentReg, commentWriter));
      list.add(const SizedBox(height: 20));
    }
  });

  return list;
}



Future getTotalCnt() async {
  var cnt;
  List<Widget> list = [const SizedBox(height: 20)];

  await cntBoardList().then((sqlRs) {
    for (var row in sqlRs) {
      int totalCnt = row[0];
      cnt = totalCnt;
    }
  });

  for(int i = 1; i < (cnt/10)+1; i ++) {
    list.add(
      getPagingBtn()
    );
  }
  list.add(const SizedBox(height: 20));

  return list;
}

Widget getPagingBtn() {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.white),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      // 식단 컴포넌트 내용 시작
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  ],
                ),
              )),
        ],
      ),
    ),
  );
}

Widget getBoardComponent(context, boardUid, boardTitle, boardContent, boardAdd, boardWriter) {
  getTotalCnt();
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => detailInfo(context, boardUid, boardTitle, boardContent, boardAdd, boardWriter))
      );
    },
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          boardUid,
                          style: TextStyle(
                              color: colorBlack,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 40),
                        Text(
                          boardTitle,
                          style: TextStyle(
                              color: colorDarkGray,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    //board_uid
                    const SizedBox(height: 30),
                    Text(
                      boardWriter,
                      style: TextStyle(
                          color: colorDarkGray,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )),
          ],
        ),
      ),
    ),
  );
}

Widget getCommentComponent(commentUid, commentContent, commentReg, commentWriter) {
  return Scaffold(
    body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              commentWriter,
                              style: TextStyle(
                                  color: colorBlack,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 40),
                            Text(
                              commentContent,
                              style: TextStyle(
                                  color: colorDarkGray,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        //board_uid
                        const SizedBox(height: 30),
                        Text(
                          commentReg,
                          style: TextStyle(
                              color: colorDarkGray,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget detailInfo(context, boardUid, boardTitle, boardContent, boardAdd, boardWriter) {
  List<Widget> _commentList = [];
  _commentList = getComment(boardUid) as List<Widget>;
  _commentList[0];
  final _commentTextEditController = TextEditingController();
  String _comment = '';

  return Scaffold(
    body: SafeArea(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //header section
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

                //info section
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                  padding:
                  const EdgeInsets.fromLTRB(
                      15.0, 20.0, 15.0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Text(boardTitle,
                          textScaleFactor: 1.1,
                          style:
                          const TextStyle(
                              color: Colors.black)
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1.5, color: colorGray),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                      padding:
                      const EdgeInsets.fromLTRB(
                          15.0, 20.0, 15.0, 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Text(boardAdd,
                              textScaleFactor: 1.1,
                              style:
                              const TextStyle(
                                  color: Colors.black)
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                      padding:
                      const EdgeInsets.fromLTRB(
                          15.0, 20.0, 15.0, 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween,
                        children: [
                          Text(boardWriter,
                              textScaleFactor: 1.1,
                              style:
                              const TextStyle(
                                  color: Colors.black)
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                  padding:
                  const EdgeInsets.fromLTRB(
                      15.0, 170.0, 15.0, 170.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Text(boardContent,
                          textScaleFactor: 1.1,
                          style:
                          const TextStyle(
                              color: Colors.black)
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: 1.5, color: colorGray),
                      bottom: BorderSide(
                          width: 1.5, color: colorGray),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  padding:
                  const EdgeInsets.fromLTRB(
                      15.0, 0.0, 15.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween,
                    children: const [
                      Text("댓글",
                          textScaleFactor: 1.1,
                          style:
                          TextStyle(
                              color: Colors.black)
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      padding:
                      const EdgeInsets.fromLTRB(
                          10.0, 20.0, 10.0, 20.0),
                      child: TextField(
                        controller: _commentTextEditController,
                        onChanged: (text) {
                          _comment = text;
                        },
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(
                              color: Color(0xffCF2525),
                              fontSize: 15,
                              height: 1
                          ),
                          labelText: "댓글을 입력해 주세요.",
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          insertComment(_comment, boardUid);
                        },
                        child: Text(
                          '작성',
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
                    ),
                  ],
                ),

                // Container(
                //   color: Colors.blue,
                //   padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                //   child: Column(
                //     children: [
                //       Text(boardUid),
                //       Text(boardTitle),
                //       Text(boardWriter),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}