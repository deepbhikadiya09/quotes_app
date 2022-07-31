import 'package:flutter/material.dart';
import 'package:quotes_app/shayari3.dart';
import 'package:quotes_app/shayariclass.dart';


class quot2 extends StatefulWidget {
  String name, img;
  int index;

  quot2({required this.name, required this.img, required this.index});

  @override
  State<quot2> createState() => _quot2State();
}

class _quot2State extends State<quot2> {
  List<String> l = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    if (widget.index == 0) {
      l = slist.love;
      //  we can define class as 2 types
      // 1.class name = slist.function name
      // 2.class object = slist().function name
      // if we define class name we must use static keyword
    } else if (widget.index == 1) {
      l = slist.friend;
    } else if (widget.index == 2) {
      l = slist.deshbhakti;
    } else if (widget.index == 3) {
      l = slist.inspirational;
    } else if (widget.index == 4) {
      l = slist.birthday;
    } else if (widget.index == 5) {
      l = slist.sad;
    } else if (widget.index == 6) {
      l = slist.bewafa;
    } else if (widget.index == 7) {
      l = slist.broken;
    } else if (widget.index == 8) {
      l = slist.sorry;
    } else if (widget.index == 9) {
      l = slist.funny;
    } else if (widget.index == 10) {
      l = slist.night;
    } else if (widget.index == 11) {
      l = slist.morning;
    } else if (widget.index == 12) {
      l = slist.maa;
    } else if (widget.index == 13) {
      l = slist.attitude;
    } else if (widget.index == 14) {
      l = slist.bollywood;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          slist.name[widget.index],//0//1
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black54,
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              height: 60,
              margin: EdgeInsets.all(5),
              child: ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return quot3(l, index);
                    },
                  ));
                },
                title: Text(
                  l[index],
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(slist.img[widget.index]),
                ),
                trailing: Text(
                  ">>",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(3)),
            );
          },
          itemCount: l.length),
      backgroundColor: Colors.grey,
    );
  }
}
