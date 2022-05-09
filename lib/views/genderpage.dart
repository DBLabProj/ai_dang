import 'package:flutter/material.dart';

class genderPage extends StatefulWidget {
  const genderPage({Key? key}) : super(key: key);

  @override
  _genderPageState createState() => _genderPageState();
}

class _genderPageState extends State<genderPage> {
  int _male = 5;
  var sex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[

            SizedBox(
              width: 100,
              height: 100,
              child: ElevatedButton(

                onPressed: (){
                  setState(() {
                    sex = "male";
                  });
                  print("male");
                },
                child: Image(
                  image: AssetImage("assets/image/male.png"),
                ),
                style: ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50)
                )),),
            ),

            SizedBox(
              width: 100,
              height: 100,
              child: ElevatedButton(

                  onPressed: (){
                    setState(() {
                      sex = "female";
                    });
                    print("female");
                  },
                  child: Image(
                    image: AssetImage("assets/image/female.png"),
                  ),
              style: ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50)
              )),),
            )


          ],
        )
      ),
    );
  }
}

