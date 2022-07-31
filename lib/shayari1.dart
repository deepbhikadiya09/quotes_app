import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quotes_app/shayari2.dart';
import 'package:quotes_app/shayariclass.dart';

class quot1 extends StatefulWidget {
  @override
  State<quot1> createState() => _quot1State();
}

class _quot1State extends State<quot1> {
  String folderpath = "";

  permission() async {
    var status = await Permission.storage.status;

    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
    } else if (status.isGranted) {
      _createFolder();
    }
  }

  _createFolder() async {
    final folderName = "shayari image";
    final path = Directory("storage/emulated/0/Download/$folderName");
    if ((await path.exists())) {
      // TODO:
      print("exist");
    } else {
      // TODO:
      print("not exist");
      path.create();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    permission();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.top]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Types of Shayari",
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
              alignment: Alignment.center,
              child: ListTile(
                title: Text(
                  slist.name[index],
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                leading: CircleAvatar(
                    backgroundImage: AssetImage("${slist.img[index]}")),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return quot2(name: slist.name[index], img: slist.img[index], index: index);
                    },
                  ));
                },
              ),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.white)),
            );
          },
          itemCount: slist.name.length),
      backgroundColor: Colors.grey,
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
