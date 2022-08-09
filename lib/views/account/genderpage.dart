import 'package:ai_dang/views/account/age.dart';
import 'package:ai_dang/views/account/signup.dart';
import 'package:ai_dang/views/predResult_back2.dart';
import 'package:ai_dang/widgets/colors.dart';
import 'package:flutter/material.dart';

class genderpage extends StatefulWidget {
  final signUpList;
  const genderpage({Key? key, @required this.signUpList}) : super(key: key);

  @override
  _genderpageState createState() => _genderpageState();
}

class _genderpageState extends State<genderpage> {
  var sex;
  var redSide = const BorderSide(color: Colors.red, width: 3);
  var greySide = BorderSide(color: Colors.grey.shade300, width: 1.5);

  @override
  Widget build(BuildContext context) {
    double areaWidth = (MediaQuery.of(context).size.width) * 0.75;
    if (areaWidth > 300) {
      areaWidth = 300;
    }
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
              child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: areaWidth,
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              const Text(
                                '성별을 선택하세요.',
                                style: TextStyle(
                                    fontSize: 24, color: Color(0xffCF2525)),
                              ),
                              const SizedBox(height: 50),
                              SizedBox(
                                width: 130,
                                height: 130,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      sex = "male";
                                    });
                                  },
                                  child: const Image(
                                    image: AssetImage("assets/image/male.png"),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      splashFactory: NoSplash.splashFactory,
                                      primary: Colors.white,
                                      shadowColor: Colors.transparent,
                                      elevation: 0.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(600)),
                                      side:
                                          (sex == "male" ? redSide : greySide)),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 30),
                                child: Text("남성", textScaleFactor: 1.2),
                              ),
                              SizedBox(
                                width: 130,
                                height: 130,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      sex = "female";
                                    });
                                  },
                                  child: const Image(
                                    image:
                                        AssetImage("assets/image/female.png"),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      shadowColor: Colors.transparent,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(500)),
                                      side: (sex == "female"
                                          ? redSide
                                          : greySide)),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 60),
                                child: Text("여성", textScaleFactor: 1.2),
                              ),
                              // 다음 단계로 버튼 -------------------------------------------
                              SizedBox(
                                width: areaWidth * 0.75,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    widget.signUpList.add(sex);
                                    print(widget.signUpList);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => agepage(
                                              signUpList: widget.signUpList)),
                                    );
                                  },
                                  child: const Text('다음 단계로',
                                      textScaleFactor: 1.4),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    primary: const Color(0xffCF2525),
                                  ),
                                ),
                              ),
                              // 다음 단계로 버튼 -------------------------------------------
                              const SizedBox(height: 20),
                              SizedBox(
                                width: areaWidth * 0.75,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    widget.signUpList.removeLast();
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    '이전 단계로',
                                    textScaleFactor: 1.4,
                                    style: TextStyle(color: red),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: const BorderSide(
                                            color: Color(0xffCF2525))),
                                    primary: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
