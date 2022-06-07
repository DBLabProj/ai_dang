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

Future getBoardList(pageStart, loadCommand, reloadCommand, text) async {

  List<Widget> list = [const SizedBox(height: 20)];

  if(loadCommand == true && reloadCommand == false) {
    print("lalalalalalalala" + text);
    await boardList(pageStart).then((sqlRs) {
      for (var row in sqlRs) {
        String boardUid = row[0].toString();
        String boardTitle = row[1];
        String boardAdd = DateFormat.jm('ko-KR').format(row[3]);
        String boardWriter = row[4];

        list.add(
            getBoardComponent(boardUid, boardTitle, boardWriter));
        list.add(const SizedBox(height: 20));
      }
    });
  } else if (loadCommand == true && reloadCommand == true) {
    print("lalalalalalalala" + text);
    await getBoard(text).then((sqlRs) {
      for (var row in sqlRs) {
        String boardUid = row[0].toString();
        String boardTitle = row[1];
        String boardAdd = DateFormat.jm('ko-KR').format(row[3]);
        String boardWriter = row[4];

        list.add(
            getBoardComponent(boardUid, boardTitle, boardWriter));
        list.add(const SizedBox(height: 20));
      }
    });
  }

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

Widget getBoardComponent(boardUid, boardTitle, boardWriter) {
  getTotalCnt();
  return Container(
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
  );
}