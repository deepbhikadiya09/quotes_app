import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quotes_app/editshayari.dart';
import 'package:quotes_app/shayariclass.dart';
import 'package:share_plus/share_plus.dart';

class quot3 extends StatefulWidget {
  List<String> l;
  int pos;

  quot3(this.l, this.pos);

  @override
  State<quot3> createState() => _quot3State();
}

class _quot3State extends State<quot3> {
  List<String> l = [];
  int pos = 0;

  PageController? pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    l = widget.l;
    pos = widget.pos;
    pageController = PageController(initialPage: pos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shayari",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),

      body: Column(
        children: [
          Expanded(
              child: PageView.builder(
            onPageChanged: (value) {
              pos = value;
              setState(() {});
            },
            controller: pageController,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(
                  "${slist().emoji[0]} \n ${l[pos]} \n ${slist().emoji[0]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("qimage/black.jpg"),
                        fit: BoxFit.cover),
                    border: Border.all(width: 3, color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
              );
            },
            itemCount: l.length,
          )),
          Container(
            width: double.infinity,
            height: 30,
            margin: EdgeInsets.all(8),
            //color: Colors.black,
            child: Text(
              "${pos + 1}/${l.length}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                //borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(colors: [
                  Colors.white,
                  Colors.grey,
                  Colors.black,
                  Colors.grey,
                  Colors.white
                ])),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    FlutterClipboard.copy("${l[pos]}").then((value) {
                      Fluttertoast.showToast(
                          msg: "Copied",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          backgroundColor: Colors.white60,
                          textColor: Colors.black,
                          fontSize: 16.0
                      );
                    });
                  },
                  icon: Icon(Icons.copy),
                  color: Colors.black),
              IconButton(
                onPressed: () {
                  if (pos > 0) {
                    pos--;
                    pageController!.jumpToPage(pos);
                    setState(() {});
                  }
                },
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.black,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return quotedit(l, pos,"gradient");
                    },
                  ));
                },
                icon: Icon(Icons.edit_off),
                color: Colors.black,
              ),
              IconButton(
                onPressed: () {
                  if (pos < l.length - 1) {
                    pos++;
                    pageController!.jumpToPage(pos);
                    setState(() {});
                  }
                },
                icon: Icon(Icons.arrow_forward_ios),
                color: Colors.black,
              ),
              IconButton(
                onPressed: () {
                  Share.share("${l[pos]}");
                },
                icon: Icon(Icons.share),
                color: Colors.black,
              )
            ],
          )
        ],
      ),
      // backgroundColor: Colors.grey,
    );
  }


}
