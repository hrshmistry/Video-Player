import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

myApp() {
  return MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  String currentTime = "0:00:00";
  String completeTime = "0:00:00";

  @override
  void initState() {
    super.initState();

    player.onAudioPositionChanged.listen((Duration duration) {
      setState(() {
        currentTime = duration.toString().split(".")[0];
      });
    });

    player.onDurationChanged.listen((Duration duration) {
      setState(() {
        completeTime = duration.toString().split(".")[0];
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blueGrey[200],
        child: Column(
          children: <Widget>[
            Card(
              shadowColor: Colors.deepPurple[900],
              elevation: 20,
              margin: EdgeInsets.only(top: 40, left: 30, right: 30),
              child: Image.asset("images/wallhaven.jpg"),
            ),
            Container(
                margin: EdgeInsets.only(top: 50),
                width: 240,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () {
                          if (isPlaying) {
                            player.pause();

                            setState(() {
                              isPlaying = false;
                            });
                          } else {
                            player.resume();
                            setState(() {
                              isPlaying = true;
                            });
                          }
                        }),
                    IconButton(
                      icon: Icon(
                        Icons.stop,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {
                        player.stop();

                        setState(() {
                          isPlaying = false;
                        });
                      },
                    ),
                    Text(
                      "   " + currentTime,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(" | "),
                    Text(
                      completeTime,
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.audiotrack),
        elevation: 10,
        backgroundColor: Colors.deepPurple,
        onPressed: () async {
          String filePath = await FilePicker.getFilePath();

          int status = await player.play(filePath, isLocal: true);

          if (status == 1) {
            setState(() {
              isPlaying = true;
            });
          }
        },
      ),
    );
  }
}
