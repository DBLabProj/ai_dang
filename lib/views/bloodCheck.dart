import 'dart:convert';
import 'package:ai_dang/utils/dbHandler.dart';
import 'package:ai_dang/widgets/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:ai_dang/utils/session.dart';
import '../main.dart';
import 'Statistics/statistics.dart';

class bloodCheck extends StatefulWidget {
  const bloodCheck({Key? key}) : super(key: key);

  @override
  _bloodCheckState createState() => _bloodCheckState();
}

class _bloodCheckState extends State<bloodCheck> {

  final DateTime _selectedDay = DateTime.now().toUtc().add(const Duration(hours: 9));

  var timeString ;
  final bloodsugar_level = TextEditingController();
  final memo_controller = TextEditingController();


  var User_email = Session.instance.userInfo['email'];



  @override
  void dispose() {
    bloodsugar_level.dispose();
    memo_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double areaWidth = (MediaQuery.of(context).size.width) * 0.75;
    if (areaWidth > 300) {
      areaWidth = 300;
    }
    
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            '혈당 기록하기',style: TextStyle(
              color: Colors.black
          ),
          ),
          elevation: 1,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          leading: IconButton(
            // padding: EdgeInsets.only(left:25),
            color: Colors.white,
            icon: Icon(Icons.chevron_left, color: colorRed,),
            iconSize: 45,
            onPressed: () =>
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage())
                ),
          ),
          actions: <Widget>[
            TextButton(onPressed: (){
              if(timeString == null ){
                timeString = time[0];
              }

              if(bloodsugar_level.text == '') {
                showDialogPop();
              }else{
                insertBloodCheck(User_email, timeString, bloodsugar_level.text, memo_controller.text );
                showDialog_Done();
              }


            },
                child: Text(
                  '저장',

                  style: TextStyle(
                  color: colorRed,
                    fontSize: 18
                ),
                ))
          ],
        ),
        body: Container(
          // color: Colors.white,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    date_time(),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height) * 0.04,
                    ),
                    insert_blood_data(User_email),
                    SizedBox(
                      height: (MediaQuery.of(context).size.height) * 0.04,
                    ),
                    memo_board(),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget date_time(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 7),
      child: SizedBox(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$_selectedDay'.substring(0,4)+'년 '+'$_selectedDay'.substring(5,7)+'월 '+'$_selectedDay'.substring(8,10)+'일',
            textScaleFactor: 1.3,
              ),
            Text('$_selectedDay'.substring(11,13)+'시 '+'$_selectedDay'.substring(14,16)+'분 ',
            textScaleFactor: 1.3,
              ),
          ],
        ),
      ),
    );
  }


  // ignore: non_constant_identifier_names
  Widget insert_blood_data(userEmail){
    return Container(
      // color: Colors.blue,
      // width: (MediaQuery.of(context).size.width)*0.7,

      height: (MediaQuery.of(context).size.height)*0.1,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: [

          picker_time(),
          Number_box(),
          mg_dl(),

        ],
      ),
    );
  }

  List<String> time = [
    '공복',
    '아침 식전',
    '아침 식후',
    '점심 식전',
    '점심 식후',
    '저녁 식전',
    '저녁 식후',
    '자기 전',
    '기타',
  ];

  // ignore: non_constant_identifier_names
  Widget picker_time() {
    return Container(
      width: (MediaQuery.of(context).size.width)*0.4,
      height: (MediaQuery.of(context).size.height)*0.10,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    decoration: const BoxDecoration(
              border: Border(
                  left:BorderSide(width: 1, color: Colors.grey),
                right: BorderSide(width: 1, color: Colors.grey),
              )
          ),
      child: CupertinoPicker(
          itemExtent: 40,
          onSelectedItemChanged: (i) {
            setState(() {
              timeString = time[i];
            });
          },
          children: [
            ...time.map((e) => Center(
              child: Text(
                e,
                textScaleFactor: 1,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: colorRed
                ),
              ),
            ))
          ]),
    );
  }



  // ignore: non_constant_identifier_names
  Widget Number_box() {
    return Container(
        width: (MediaQuery.of(context).size.width)*0.35,
        height: (MediaQuery.of(context).size.height)*0.2,
        // padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            TextField(
              controller: bloodsugar_level,
              decoration: InputDecoration(
              hintText: '120',
              hintStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: (MediaQuery.of(context).size.height) * 0.07,
                color: Colors.grey[300]
              ),

              contentPadding: const EdgeInsets.only(left:30),
              border: InputBorder.none),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: (MediaQuery.of(context).size.height) * 0.07,
                color: colorRed
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
            ),
          ],
        ));
  }

  // ignore: non_constant_identifier_names
  Widget mg_dl() {
    return Text(
      'mg/dL',
      style: TextStyle(
        color: Colors.grey[400],
        fontSize: (MediaQuery.of(context).size.height) * 0.025
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget memo_board() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: TextFormField(
        controller: memo_controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          // hintText: '자세히 기록해 두세요!11',
          labelText: ' 자세히 기록해 두세요!',

          contentPadding: const EdgeInsets.symmetric(vertical: 50),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.blue
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: colorRed
            )
          )
        ),
      ),
    );
  }


  void showDialogPop() {
    showDialog(
        context: context,
        barrierDismissible: true,
        // false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: SingleChildScrollView(
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: '혈당', style: TextStyle(color: colorRed)),
                    TextSpan(text: ' 수치가 입력되지 않았어요..')
                  ]
                )
              )
            ),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text(
                  '닫기',
                  style: TextStyle(
                      color: red
                  ),
                ),
              )
            ],
          );
        }
    );
  }

  void showDialog_Done() {
    showDialog(
        context: context,
        barrierDismissible: true,
        // false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: SingleChildScrollView(
                child: Text(
                  '정상적으로 기록되었습니다.'
                )
            ),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text(
                  '닫기',
                  style: TextStyle(
                      color: red
                  ),
                ),
              )
            ],
          );
        }
    );
  }


}
