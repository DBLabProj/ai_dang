import 'package:ai_dang/main.dart';
import 'package:ai_dang/views/community/modifyPost.dart';
import 'package:ai_dang/views/predResult.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

import '../../dbHandler.dart';
import '../../session.dart';
import 'community.dart';

var colorBlack = const Color(0xff535353);
var colorRed = const Color(0xffCF2525);
var colorLightGray = const Color(0xffF3F3F3);
var colorGray = const Color(0xffE0E0E0);
var colorDarkGray = const Color(0xffADADBE);
var colorOrange = const Color(0xffFBAA47);
var colorGreen = const Color(0xff8AD03C);
const IconData subdirectory_arrow_right = IconData(0xe615, fontFamily: 'MaterialIcons');

var User_id = Session.instance.userInfo['email'];
var recommentNum = 0;

class communityDetail extends StatefulWidget {
  final context, boardUid, boardTitle, boardContent, boardAdd, boardWriter, boardImage;
  final commentUid, commentContent, commentReg, commentWriter;
  const communityDetail({Key? key,
  @required this.context, @required this.boardUid, @required this.boardTitle,
  @required this.boardContent, @required this.boardAdd, @required this.boardWriter,
  @required this.boardImage,
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
    var boardImage = widget.boardImage;
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '아이당 커뮤니티',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                  (MediaQuery.of(context).size.width) * 0.04),
                            ),
                            if(User_id == widget.boardWriter)...[
                              ElevatedButton(
                                onPressed: () {
                                  showAdaptiveActionSheet(
                                    context: context,
                                    actions: <BottomSheetAction>[
                                      BottomSheetAction(
                                        title: const Text(
                                          '수정',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const modifyPost(context: context, boardTitle: widget.boardTitle, boardContent: widget.boardContent, boardImage: widget.boardImage)));
                                        },
                                      ),
                                      BottomSheetAction(
                                        title: const Text(
                                            '삭제',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15)),
                                        onPressed: (BuildContext context) {
                                          deleteDialogCheck();
                                        },
                                      ),
                                    ],
                                    cancelAction: CancelAction(title: const Text(
                                        '취소',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15))),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                  elevation: MaterialStateProperty.all(0.0),
                                ),
                                child: const Icon(Icons.more_vert, color: Colors.white,),
                              ),]
                            ]
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
                      padding: const EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              if(boardImage != "default")...[
                                ClipRRect(
                                  child: Image.network(
                                    "http://203.252.240.74:5000/static/images/board/$boardImage.jpg",
                                    fit: BoxFit.fitHeight,
                                    width: MediaQuery.of(context).size.width * 0.75,
                                    height: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                const SizedBox(height: 20,),
                              ],

                              Text(widget.boardContent,
                                  textScaleFactor: 1.1,
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),

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
                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.5, color: colorGray),
                        ),
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
    List<Widget> list = [const SizedBox(height: 10)];

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

      list.add(getCommentComponent(
          commentUid, commentContent, commentReg, commentWriter, recommentContent, recommentReg, recommentWriter));
      list.add(const SizedBox(height: 20));

      var sqlRs2 = await reCommentList(commentUid);
      print("----");
      print(commentUid);
      print("----");
      print(sqlRs2);
      print("----");
      for (var row2 in sqlRs2) {
        String recommentUid = row2[0].toString();
        String recommentContent = row2[1];
        String recommentReg = DateFormat('MM-dd hh:mm').format(row2[2]);
        String recommentWriter = row2[3];

        list.add(getReCommentComponent(commentUid, recommentContent, recommentWriter, recommentReg));
        list.add(const SizedBox(height:20));
      }
    }
    return list;
  }

  Widget getCommentComponent(
      commentUid, commentContent, commentReg, commentWriter, recommentContent, recommentWriter, recommentReg) {
    final _recommentTextEditController = TextEditingController();
    String _recomment = '';
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
      decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.5, color: colorGray),
          ),
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
                        SizedBox(height: 20),
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
              const SizedBox(width: 165,),
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

  Widget getReCommentComponent(
      commentUid, recommentContent, recommentWriter, recommentReg) {
    return Container(
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
      decoration: BoxDecoration(
          color: lightGray,
          borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: getIconButtonGroup(Icons.subdirectory_arrow_right,
                            Colors.black, '', '')),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget getIconButtonGroup(icons, color, label, settingText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icons,
              color: color,
            ),
            const SizedBox(width: 20),
            Text(
              label,
              textScaleFactor: 1.1,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }

  void deleteDialogCheck() {
    showDialog(
        context: context,
        barrierDismissible: true,
        // false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
                '게시글 삭제'
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                      '게시글을 삭제하시겠습니까?'
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  deleteBoard(widget.boardUid);
                  Navigator.of(context).pop();
                  deleteDialogConfirm();
                },
                child: const Text(
                  '삭제',
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: const Text(
                  '취소',
                ),
              )
            ],
          );
        }
    );
  }

  void deleteDialogConfirm() {
    showDialog(
        context: context,
        barrierDismissible: true,
        // false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
                '게시글 삭제'
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                      '삭제가 완료되었습니다.'
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
                },
                child: const Text(
                  '확인',
                ),
              ),
            ],
          );
        }
    );
  }
}

