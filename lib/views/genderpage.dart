import 'package:ai_dang/views/age.dart';
import 'package:ai_dang/views/loginPage.dart';
import 'package:ai_dang/views/signup.dart';
import 'package:ai_dang/views/test.dart';
import 'package:flutter/material.dart';

class genderpage extends StatefulWidget {
  const genderpage({Key? key}) : super(key: key);

  @override
  _genderpageState createState() => _genderpageState();
}

class _genderpageState extends State<genderpage> {
  var sex;
  var btnOneStyle;
  var btnTwoStyle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: (MediaQuery.of(context).size.height) * 0.10,
            ),
            Container(
              color: Colors.white,
                height: (MediaQuery.of(context).size.height) -
                    (MediaQuery.of(context).size.height) * 0.1,
                width: (MediaQuery.of(context).size.width) -
                    (MediaQuery.of(context).size.width) * 0.3,
              child:Column(
            children: <Widget>[
              Text(
                '성별을 선택하세요.',
                style: TextStyle(
                    fontSize:
                    ((MediaQuery.of(context).size.width) * 0.20) *
                        0.26,
                    color: Color(0xffCF2525)),
              ),
              SizedBox(height: (MediaQuery.of(context).size.height) * 0.05,
              ),

              SizedBox(
                width: (MediaQuery.of(context).size.width) * 0.25,
                height: (MediaQuery.of(context).size.height) * 0.17,
                child: ElevatedButton(

                  onPressed: (){
                    setState(() {
                      sex = "male";
                      if(sex == "male") {
                        btnOneStyle = BorderSide(color: Colors.red);
                        btnTwoStyle = null;
                      } else {
                        btnOneStyle = null;
                        btnTwoStyle = BorderSide(color: Colors.red);
                      }

                    });
                    print("male");
                  },
                  child: Image(
                    image: AssetImage("assets/image/male.png"),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shadowColor: Colors.red,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(600)
                      ),
                      side: btnOneStyle
                  ),
                ),
              ),
              SizedBox(
                child: Text("남성", style: TextStyle(
                  fontSize: ((MediaQuery.of(context).size.width) * 0.16) * 0.26
                ),),
                height: (MediaQuery.of(context).size.height) * 0.05,
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height) * 0.05,
              ),

              SizedBox(
                width: (MediaQuery.of(context).size.width) * 0.25,
                height: (MediaQuery.of(context).size.height) * 0.17,
                child: ElevatedButton(

                  onPressed: (){
                    setState(() {
                      sex = "female";
                      if(sex == "male") {
                        btnOneStyle = BorderSide(color: Colors.red);
                        btnTwoStyle = null;
                      } else {
                        btnOneStyle = null;
                        btnTwoStyle = BorderSide(color: Colors.red);
                      }

                    });
                    print("female");
                  },
                  child: Image(
                    image: AssetImage("assets/image/female.png"),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shadowColor: Colors.red,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(500)
                      ),
                      side: btnTwoStyle),),
              ),

              SizedBox(
                child: Text("여성", style: TextStyle(
                    fontSize: ((MediaQuery.of(context).size.width) * 0.16) * 0.26
                ),),
                height: (MediaQuery.of(context).size.height) * 0.10,
              ),

              SizedBox(
                height: (MediaQuery.of(context).size.height) * 0.065,
                width: (MediaQuery.of(context).size.width) -
                    (MediaQuery.of(context).size.width) * 0.4,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => agepage()),
                    );
                  },
                  child: Text('다음 단계로', style: TextStyle(
                      fontSize: ((MediaQuery.of(context).size.width) * 0.16) *  0.26
                  ),),
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                    primary : Color(0xffCF2525),),
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height) * 0.02,
              ),

              SizedBox(
                height: (MediaQuery.of(context).size.height) * 0.065,
                width: (MediaQuery.of(context).size.width) -
                    (MediaQuery.of(context).size.width) * 0.4,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => signup()),
                    );
                  },
                  child: Text('이전 단계로', style: TextStyle(
                    color: Color(0xffCF2525),
                      fontSize: ((MediaQuery.of(context).size.width) * 0.16) *  0.26,
                  ),),

                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: Color(0xffCF2525)
                  )),
                    primary : Colors.white,),
                ),
              ),

            ],
            )



            ),


          ],
        )
      ),
    );
  }
}

