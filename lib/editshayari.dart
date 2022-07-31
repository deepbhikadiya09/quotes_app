import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quotes_app/shayariclass.dart';
import 'package:share_plus/share_plus.dart';

class quotedit extends StatefulWidget {
  List<String> l;
  int pos;
  String type;

  quotedit(this.l, this.pos, this.type);

  @override
  State<quotedit> createState() => _quoteditState();
}

class _quoteditState extends State<quotedit> {
  PermissionStatus? status ;
  GlobalKey _globalKey = GlobalKey();
  final folderpath = "storage/emulated/0/Download/shayari image";

  permission() async {
    //status = await Permission.storage.status;
    print(status);
    if (status!.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
    }
    if( await status!.isGranted) {
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
    check();
  }


  check()
  async {
    status= await Permission.storage.status;
  }


  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);
      setState(() {});
      return pngBytes;
    } catch (e) {
      print(e);
    }
    return Future.value();
  }



  Color bg = Colors.grey;
  Color txt = Colors.black;
  String temp = slist().emoji[0];
  String f = "family d";
  String tmp = "🥀🌻😍🥰🌻🥀";
  double val = 15;

  List grad = [
    [Colors.red, Colors.blue, Colors.pink],
    [Colors.pink, Colors.purple, Colors.blue],
    [Colors.green, Colors.yellow, Colors.red],
    [Colors.orange, Colors.red, Colors.pink],
    [Colors.black87, Colors.grey, Colors.black87],
    [Colors.yellow, Colors.green, Colors.orange],
    [Colors.red, Colors.orange, Colors.blue],
    [Colors.orange, Colors.yellow],
    [Colors.indigo, Colors.lightBlueAccent],
    [Colors.orange, Colors.purple],
    [Colors.pink, Colors.yellow],
    [Colors.red, Colors.deepPurple],
    [Colors.pinkAccent, Colors.orange],
    [Colors.lime, Colors.deepOrangeAccent],
    [Colors.pink, Colors.indigo],
    [Colors.red, Colors.yellow],
    [Colors.lightBlue, Colors.purple],
    [Colors.white, Colors.grey, Colors.black],
  ];

  List<Color> grd = [Colors.black87, Colors.grey, Colors.black87];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: RepaintBoundary(
                key: _globalKey,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text(
                    "$temp \n ${widget.l[widget.pos]}\n $temp",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: txt, fontSize: val, fontFamily: f),
                  ),
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //     image: AssetImage("qimage/black.jpg"), fit: BoxFit.cover),
                      border: Border.all(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                      color: widget.type == "single" ? bg : null,
                      gradient: widget.type == "gradient"
                          ? LinearGradient(
                              colors: grd,
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)
                          : null),
                ),
              ),
            ),
          ),
          //Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  int i = Random().nextInt(grad.length);
                  grd = grad[i];
                  setState(() {
                    widget.type = "gradient";
                  });
                },
                icon: Icon(Icons.sync_outlined),
                color: Colors.black,
                iconSize: 30,
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      barrierColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) {
                        return Container(
                          height: 700,
                          child: GridView.builder(
                              itemCount: grad.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    grd = grad[index];
                                    setState(() {
                                      widget.type = "gradient";
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      " $tmp \n Types of Shayari \n $tmp",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "family d",
                                          fontSize: 15),
                                    ),
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: grad[index],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                );
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2)),
                        );
                      },
                      context: context);
                },
                icon: Icon(Icons.shuffle),
                color: Colors.black,
                iconSize: 30,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 30,
                width: 105,
                margin: EdgeInsets.all(7),
                child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          barrierColor: Colors.transparent,
                          builder: (context) {
                            return Container(
                              height: 100,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GridView.builder(
                                        itemCount: slist().bgcolor.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                bg = slist().bgcolor[index];
                                                widget.type = "single";
                                                //Navigator.pop(context);
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(10),
                                              color: slist().bgcolor[index],
                                            ),
                                          );
                                        },
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 8)),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                    icon: Icon(Icons.close_rounded),
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            );
                          },
                          context: context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    child: Text(
                      "Background",
                      style: TextStyle(color: Colors.white, fontSize: 13.5),
                    )),
              ),
              Container(
                height: 30,
                width: 105,
                margin: EdgeInsets.all(7),
                child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          barrierColor: Colors.transparent,
                          builder: (context) {
                            return Container(
                              height: 100,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GridView.builder(
                                        itemCount: slist().bgcolor.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                txt = slist().bgcolor[index];
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(10),
                                              color: slist().bgcolor[index],
                                            ),
                                          );
                                        },
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 8)),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                    icon: Icon(Icons.close_rounded),
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            );
                          },
                          context: context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    child: Text(
                      "Text Color",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Container(
                height: 30,
                width: 105,
                margin: EdgeInsets.all(7),
                child: ElevatedButton(
                    onPressed: () {


                      if (status!.isGranted) {
                        //_createFolder();
                        _capturePng().then((value)  {
                          print(value);

                          DateTime d = DateTime.now();

                          /* Imgname generate using random number
                                  Random r = Random();
                                  String imagename = "${r.nextInt(10000)}${r.nextInt(10000)}${r.nextInt(10000)}";
                                  */

                          String imagename =
                              "${d.year}${d.month}${d.day}${d.hour}${d.minute}${d.second}";

                          String imagepath = "$folderpath/Shayari$imagename.png";

                          File file = File(imagepath);

                           file.writeAsBytes(value).then((value) {
                            Share.shareFiles([file.path],text: "Shayari App");
                          });
                        });
                      }
                      else if (status!.isDenied) {
                        permission();
                      }


                      setState(() {

                      });
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    child: Text(
                      "Share",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 30,
                width: 105,
                margin: EdgeInsets.all(7),
                child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          barrierColor: Colors.transparent,
                          builder: (context) {
                            return Container(
                              height: 100,
                              child: ListView.builder(
                                itemCount: slist().f.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        f = slist().f[index];
                                      });
                                    },
                                    child: Container(
                                      width: 100,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 20),
                                      alignment: Alignment.center,
                                      //color: Colors.black,
                                      child: Text(
                                        "shayari",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: slist().f[index]),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          border: Border.all(
                                              width: 2, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          context: context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    child: Text(
                      "Font",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Container(
                height: 30,
                width: 105,
                margin: EdgeInsets.all(7),
                child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          barrierColor: Colors.transparent,
                          builder: (context) {
                            return Container(
                              height: 150,
                              child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return Container(
                                      height: 2,
                                      color: Colors.white,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          temp = slist().emoji[index];
                                        });
                                      },
                                      child: Container(
                                        height: 50,
                                        color: Colors.black,
                                        alignment: Alignment.center,
                                        child: Text(
                                          slist().emoji[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: slist().emoji.length),
                            );
                          },
                          context: context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    child: Text(
                      "Emoji",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Container(
                height: 30,
                width: 105,
                margin: EdgeInsets.all(7),
                child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          barrierColor: Colors.transparent,
                          builder: (context) {
                            return Container(
                              height: 100,
                              child: StatefulBuilder(
                                builder: (context, setState1) {
                                  return Slider(
                                    onChanged: (value) {
                                      setState(() {
                                        setState1(() {
                                          val = value;
                                        });
                                      });
                                    },
                                    activeColor: Colors.black,
                                    inactiveColor: Colors.grey,
                                    thumbColor: Colors.black54,
                                    divisions: 8,
                                    label: "$val",
                                    value: val,
                                    min: 10,
                                    max: 50,
                                  );
                                },
                              ),
                            );
                          },
                          context: context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    child: Text(
                      "Text size",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
