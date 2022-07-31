import 'package:flutter/material.dart';
import 'package:quotes_app/shayari1.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    splash();
    setState(() {

    });
  }

  splash()
  async {
    await Future.delayed(Duration(seconds: 3));

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return quot1();
    },));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("qimage/penlogo2.jpg",fit: BoxFit.fill,width: 100,height: 100),
                Text("SHAYARI ",style: TextStyle(fontSize: 20,fontFamily: "family 13",color: Colors.white),)
              ],
            ),
          ),
    );
  }
}
