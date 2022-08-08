import 'package:ai_dang/views/community/communityDetail.dart';
import 'package:ai_dang/views/predResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/dbHandler.dart';
import '../../utils/session.dart';

var colorBlack = const Color(0xff535353);
var colorRed = const Color(0xffCF2525);
var colorLightGray = const Color(0xffF3F3F3);
var colorGray = const Color(0xffE0E0E0);
var colorDarkGray = const Color(0xffADADBE);
var colorOrange = const Color(0xffFBAA47);
var colorGreen = const Color(0xff8AD03C);

var User_id = Session.instance.userInfo['email'];
var recommentNum = 0;

Future getBoardList(
    context, pageStart, loadCommand, reloadCommand, text) async {
  List<Widget> list = [const SizedBox(height: 20)];

  int cnt = 0;

  await cntBoardList().then((sqlRs) {
    for (var row in sqlRs) {
      int totalCnt = row[0];
      cnt = totalCnt;
    }
  });

  if (loadCommand == true && reloadCommand == false) {
    await boardList(pageStart).then((sqlRs) {
      for (var row in sqlRs) {
        String boardUid = row[0].toString();
        String boardNum = cnt.toString();
        String boardTitle = row[1];
        String boardContent = row[2];
        String boardAdd = DateFormat.jm('ko-KR').format(row[3]);
        String boardWriter = row[4];
        if(row[5] == null) {
          String boardImage = "default";

          list.add(getBoardComponent(context, boardUid, boardTitle, boardContent,
              boardAdd, boardWriter, boardImage, boardNum));
        } else {
          String boardImage = row[5];

          list.add(getBoardComponent(context, boardUid, boardTitle, boardContent,
              boardAdd, boardWriter, boardImage, boardNum));
        }


        list.add(const SizedBox(height: 20));

        cnt -= 1;
      }
    });
  } else if (loadCommand == true && reloadCommand == true) {
    await getBoard(text).then((sqlRs) {
      for (var row in sqlRs) {
        String boardUid = row[0].toString();
        String boardNum = cnt.toString();
        String boardTitle = row[1];
        String boardContent = row[2];
        String boardAdd = DateFormat.jm('ko-KR').format(row[3]);
        String boardWriter = row[4];
        if(row[5] == null) {
          String boardImage = "default";

          list.add(getBoardComponent(context, boardUid, boardTitle, boardContent,
              boardAdd, boardWriter, boardImage, boardNum));
        } else {
          String boardImage = row[5];

          list.add(getBoardComponent(context, boardUid, boardTitle, boardContent,
              boardAdd, boardWriter, boardImage, boardNum));
        }
        list.add(const SizedBox(height: 20));

        cnt -= 1;
      }
    });
  }

  return list;
}

Future getTotalCnt() async {
  int cnt = 0;

  await cntBoardList().then((sqlRs) {
    for (var row in sqlRs) {
      int totalCnt = row[0];
      cnt = totalCnt;
    }
  });

  return cnt;
}

Widget getBoardComponent(
    context, boardUid, boardTitle, boardContent, boardAdd, boardWriter, boardImage, boardNum) {
  return GestureDetector(
    onTap: () {
      print('1');
      Navigator.push(context, MaterialPageRoute(builder: (context) => communityDetail(context: context, boardUid: boardUid, boardTitle: boardTitle, boardContent: boardContent, boardAdd: boardAdd, boardWriter: boardWriter, boardImage: boardImage)));
      // detailInfo(context, boardUid, boardTitle, boardContent, boardAdd,
      //     boardWriter)
      //     .then((widget) {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => widget));
      // });
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
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            boardNum,
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
                          if(boardImage != "default")...[
                            const SizedBox(width: 40),
                            ClipRRect(
                              child: Image.network(
                                "http://203.252.240.74:5000/static/images/$boardImage.jpg",
                                fit: BoxFit.fitHeight,
                                width: MediaQuery.of(context).size.width * 0.05,
                                height: MediaQuery.of(context).size.width * 0.1,
                              ),
                            ),
                          ],
                        ],
                      ),
                      //board_uid
                      const SizedBox(height: 10),
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
