import 'package:ai_dang/views/account/age.dart';
import 'package:ai_dang/views/account/signup.dart';
import 'package:flutter/material.dart';

class genderpage extends StatefulWidget {
  final signUpList;
  const genderpage({Key? key, @required this.signUpList}) : super(key: key);

  @override
  _genderpageState createState() => _genderpageState();
}

class _genderpageState extends State<genderpage> {
  var sex;
  var btnOneStyle;
  var btnTwoStyle;

  void setBtnSide() {
    var redSide = const BorderSide(color: Colors.red, width: 3);
    var greySide = BorderSide(color: Colors.grey.shade300, width: 1.5);
    if(sex == "male") {
      btnOneStyle = redSide;
      btnTwoStyle = greySide;
    } else {
      btnOneStyle = greySide;
      btnTwoStyle = redSide;
    }
  }

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
              child:Column(
            children: <Widget>[
              const Text(
                '성별을 선택하세요.',
                textScaleFactor: 1.4,
                style: TextStyle(
                    color: Color(0xffCF2525)),
              ),

              SizedBox(
                width: 130,
                height: 130,
                child: ElevatedButton(

                  onPressed: (){
                    setState(() {
                      sex = "male";
                      setBtnSide();
                    });
                  },
                  child: const Image(
                    image: AssetImage("assets/image/male.png"),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,

                      shadowColor: Colors.red,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(600)
                      ),
                      side: btnOneStyle
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 40),
                child: Text("남성", textScaleFactor: 1.2,)
              ),
              SizedBox(
                width: 130,
                height: 130,
                child: ElevatedButton(

                  onPressed: (){
                    setState(() {
                      sex = "female";
                      setBtnSide();
                    });
                  },
                  child: const Image(
                    image: AssetImage("assets/image/female.png"),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shadowColor: Colors.red,
                      elevation: 0,
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


                    widget.signUpList.add(sex);
                    print(widget.signUpList);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => agepage(signUpList:widget.signUpList)),
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

                    print(widget.signUpList);


                    Navigator.pop(context);
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

