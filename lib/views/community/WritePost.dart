import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/dbHandler.dart';
import '../../utils/request.dart';
import '../../utils/session.dart';
import 'community.dart';

var colorBlack = const Color(0xff535353);
var colorRed = const Color(0xffCF2525);
var colorLightGray = const Color(0xffF3F3F3);
var colorGray = const Color(0xffE0E0E0);
var colorDarkGray = const Color(0xffADADBE);
var colorOrange = const Color(0xffFBAA47);
var colorGreen = const Color(0xff8AD03C);

class WritePost extends StatefulWidget {

  const WritePost({Key? key}) : super(key: key);

  @override
  State<WritePost> createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  var writeBoardList = [];
  var imageText;
  final _picker = ImagePicker();

  final _titleTextEditController = TextEditingController();
  final _contentTextEditController = TextEditingController();

  var user_id = Session.instance.userInfo['email'];
  String _title = '';
  String _content = '';


  @override
  Widget build(BuildContext context) {

    // void showConfirmDialog(message) {
    //   showDialog(
    //     context: context,
    //     barrierDismissible: true,
    //     // false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
    //     builder: (BuildContext context) {
    //       return
    //         AlertDialog(
    //           title: Text(
    //             //제목 정의
    //             message,
    //           ),
    //           actions: <Widget>[
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop(); // 현재 화면을 종료하고 이전 화면으로 돌아가기
    //                 insertBoard(_title, _content, user_id, imageText);
    //               },
    //               child: const Text(
    //                 '확인',
    //               ),
    //             ),
    //           ],
    //         );
    //     },
    //   );
    // }

    print(imageText);

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
                      if(imageText != null)...[
                        Text(imageText+".jpg"),
                      ],
                    ],
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
                          insertBoard(_title, _content, User_id, imageText);
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
      ),
    );
  }
}