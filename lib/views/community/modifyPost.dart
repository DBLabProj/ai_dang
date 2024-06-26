import 'package:ai_dang/utils/dbHandler.dart';
import 'package:ai_dang/utils/request.dart';
import 'package:ai_dang/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import '../../main.dart';
import 'community.dart';

var colorBlack = const Color(0xff535353);
var colorRed = const Color(0xffCF2525);
var colorLightGray = const Color(0xffF3F3F3);
var colorGray = const Color(0xffE0E0E0);
var colorDarkGray = const Color(0xffADADBE);
var colorOrange = const Color(0xffFBAA47);
var colorGreen = const Color(0xff8AD03C);

class modifyPost extends StatefulWidget {
  final boardTitle, boardImage, boardContent, context, boardUid;

  const modifyPost({
    Key? key,
    @required this.boardTitle, @required this.boardContent,
    @required this.boardImage, @required this.boardUid,
    @required this.context})
      : super(key: key);

  @override
  State<modifyPost> createState() => _modifyPostState();
}

class _modifyPostState extends State<modifyPost> {
  var writeBoardList = [];
  var imageText;
  final _picker = ImagePicker();



  var user_id = Session.instance.userInfo['email'];
  String _title = '';
  String _content = '';

  var boardTitle = '';
  var boardContent = '';
  var boardLoadImage = '';
  var boardUid = '';
  var _titleTextEditController;
  var _contentTextEditController;

  @override
  void initState() {
    super.initState();
    setState(() {
      boardTitle = widget.boardTitle;
      boardContent = widget.boardContent;
      boardLoadImage = widget.boardImage;
      boardUid = widget.boardUid;
      _titleTextEditController = TextEditingController(text: boardTitle);
      _contentTextEditController = TextEditingController(text: boardContent);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_title);
    print(_content);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
                      setState(() {
                        _title = text;
                      });
                    },
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Color(0xffCF2525)),
                      border: OutlineInputBorder(),
                      labelText: '제 목',
                     focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Color(0xffCF2525)),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      ButtonTheme(
                          minWidth: (MediaQuery.of(context).size.width),
                          height: (MediaQuery.of(context).size.height) * 0.02,
                          child: OutlinedButton(
                            onPressed: () async {
                              var imageName = await boardImage(context, ImageSource.gallery, _picker);
                              print("------");
                              print(imageName['img_name']);
                              print("------");
                              setState(() {
                                imageText = imageName['img_name'];
                              });
                              print(imageText);
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
                      const SizedBox(width: 20,),
                      if(boardLoadImage != null && imageText != null)...[
                        Text(imageText+".jpg"),
                      ] else if(boardLoadImage != 'default')...[
                        Text(boardLoadImage+".jpg"),
                      ]
                    ],
                  ),
                  TextFormField(
                    controller: _contentTextEditController,
                    onChanged: (text) {
                      setState(() {
                        _content = text;
                      });
                    },
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Color(0xffCF2525)),
                      contentPadding: EdgeInsets.symmetric(vertical: 200.0, horizontal: 10),
                      border: OutlineInputBorder(),
                      labelText: "내 용",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Color(0xffCF2525)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
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
                          print("-----------");
                          print(_title);
                          print(_content);
                          print(imageText);
                          print(boardUid);
                          print("-----------");
                          if(_content == "") {
                            _content = boardContent;
                          }
                          if(_title == "") {
                            _title = boardTitle;
                          }
                          print("_title : " + _title);
                          print("_content : " + _content);

                          if(imageText == null) {
                            modifyBoard(_title, _content, User_id, boardLoadImage, boardUid);
                          } else {
                            modifyBoard(_title, _content, User_id, imageText, boardUid);
                          }
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage(index: 2,)));
                        },
                        child: Text(
                          '수 정 하 기',
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
      ),
    );
  }
}