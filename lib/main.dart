import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:video_app/audio.dart';
import 'package:video_app/videos_list.dart';
import 'package:video_player/video_player.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

int status = 0;
AudioPlayer player = AudioPlayer();

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple[50],
        appBar: AppBar(
          leading: Icon(
            Icons.play_circle_filled,
            size: 45,
          ),
          backgroundColor: Colors.deepPurple,
          title: Text(
            "Music Player",
            style: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.next_week,
                  size: 20,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.new_releases,
                  size: 20,
                ),
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: "New features coming soon!",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.deepPurple,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }),
          ],
        ),
        body: Stack(children: <Widget>[
          ListView(
            children: <Widget>[
              VideosList(
                videoPlayerController: VideoPlayerController.asset(
                  'videos/Ansible.MP4',
                ),
                looping: true,
              ),
              VideosList(
                videoPlayerController: VideoPlayerController.asset(
                  'videos/Specialist_In_Python.MP4',
                ),
                looping: true,
              ),
              VideosList(
                videoPlayerController: VideoPlayerController.asset(
                  'videos/AnsiblePro.MP4',
                ),
                looping: true,
              ),
              VideosList(
                videoPlayerController: VideoPlayerController.network(
                  'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
                ),
                looping: true,
              ),
              VideosList(
                videoPlayerController: VideoPlayerController.asset(
                  'videos/OpenShift.MP4',
                ),
                looping: true,
              ),
              VideosList(
                videoPlayerController: VideoPlayerController.asset(
                  'videos/Flutter.MP4',
                ),
                looping: true,
              ),
            ],
          ),
        ]),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.audiotrack),
            elevation: 15,
            backgroundColor: Colors.deepPurple,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return myApp();
              }));
            }
            // () async {
            //   if (status == 1) {
            //     status = await player.stop();
            //     status = 0;
            //   } else {
            //     String filePath = await FilePicker.getFilePath();
            //     status = await player.play(filePath, isLocal: true);
            //     //also can be played from the assets...
            //     //but users must have choices so local file is used!!
            //   }
            // },
            ));
  }
}
