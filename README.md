# Music(Video/Audio) Player

### How can play videos in Flutter? 

There is a library directly from the Flutter team simply called [video_player](https://pub.dev/packages/video_player). This library, however, is completely bare-bones. While it can play videos, it's up to you to add video playback controls and to style it. There is a better option which comes bundled with the UI as you'd expect both on Android and iOS - [Chewie.](https://pub.dev/packages/chewie) - Chewie uses the first-party video_player package behind the scenes. It only simplifies the process of video playback.

### Project setup

Importing packages,
```
dependencies:
  flutter:
    sdk: flutter
  chewie: ^0.9.7
```

### Playing videos
Chewie (and video_player for that matter) can play videos from 3 sources - assets, files and network. The beauty of it is that you don't need to write a lot of code to change the data source. Switching from an asset to a network video is a matter of just a few keystrokes. Let's first take a look at assets.

- Asset videos setup

Assets are simply files which are readily available for your app to use. They come bundled together with your app file after you build it for release, To set up assets, simply create a folder in the root of your project and call it, for example, videos. Then drag your desired video file in there.

<p float = "center"> 
  <img src="/ss/vss.png" height="300" width="200"  />
</p>


To let Flutter know about all the available assets, you have to specify them in the pubspec file. here i added all the dependencies needed in the project.

```
dependencies:
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^0.1.3
  chewie: ^0.9.10
  file_picker: ^1.13.0+1
  audioplayers: ^0.15.1
  fluttertoast: ^7.0.2
```

### Using the Chewie widget

Now comes the time to start playing videos. For that Chewie provides its own widget which is, as I've already mentioned, only a wrapper on top of the VideoPlayer which comes directly from the Flutter team.

Because we want to play multiple videos displayed in a ListView, it's going to be the best to put all of the video-playing related things into it's own widget. Also, because video player resources need to be released, you need to create a StatefulWidget to get hold of the dispose() method.

<p float = "center"> 
  <img src="/ss/mp2-Apple iPhone 7 Plus Gold [shadow].png" height="600" width="300"/>
  <img src="/ss/mp1-Apple iPhone 7 Plus Gold [shadow].png" height="600" width="300"/>
</p>

lets create videos_list.dart,
```
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideosList extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;

  const VideosList(
      {Key key, @required this.videoPlayerController, this.looping})
      : super(key: key);

  @override
  _VideosListState createState() => _VideosListState();
}

class _VideosListState extends State<VideosList> {
  ChewieController videosController;

  @override
  void initState() {
    super.initState();

    videosController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(child: progressBar()
            );
      },
    );
  }

  Widget progressBar() {
    return CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(
        controller: videosController,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    // widget.videoPlayerController.dispose();
    videosController.dispose();
  }
}
```

To play the videos inside a ListView, we don't need to do a lot of additional work. With all of the chewie stuff in its own separate widget, let's create a MyHomePage StatelessWidget.

in main.dart, added all the necessary components needed in the project

```
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
          title: Text("Music Player"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.next_week), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.new_releases),
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
          onPressed: () async {
            if (status == 1) {
              status = await player.stop();
              status = 0;
            } else {
              String filePath = await FilePicker.getFilePath();
              status = await player.play(filePath, isLocal: true);
              //also can be played from the assets...
              //but users must have choices so local file is used!!
            }
          },
        ));
  }
}
```

### here we added some video from assets and some from network

```
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
```

### for playing Audio

we use [audioplayers](https://pub.dev/packages/audioplayers) plugin.

it is easy to implement, but here in this project we used defferent approch to audioplayer. as i wanted to make this app a singal page app, i did not use intent foe switching between two activities, foe playing and stoping audio i used singal floating button with that level of capability, here is the code snippet for that,

```
floatingActionButton: FloatingActionButton(
          child: Icon(Icons.audiotrack),
          elevation: 15,
          backgroundColor: Colors.deepPurple,
          onPressed: () async {
            if (status == 1) {
              status = await player.stop();
              status = 0;
            } else {
              String filePath = await FilePicker.getFilePath();
              status = await player.play(filePath, isLocal: true);
              //also can be played from the assets...
              //but users must have choices so local file is used!!
            }
          },
        )
```

> Chewie is a Flutter package aimed at simplifying the process of playing videos. Instead of you having to deal with start, stop, and pause buttons, doing the overlay to display the progress of the video, Chewie does these things for you.

### here is the final output of our project

<p float = "center"> 
  <img src="/ss/LiveMock.gif" height="600" width="330"  />
</p>

- For the audio part we can also add more features like linear progress bar, stop and showing duration and all. below is a sneak pic of one of my projects,
<p float = "center"> 
  <img src="https://github.com/hrshmistry/Audio-Player/blob/Audio-Player/ss/iPhone%207%20Plus.png" height="600" width="300" />
</p>

#### we can also add this capabilities to our this project, but that is for next update!
## future features to added
- can add audio/video from network url(user input).
- add the play/pause and duration in minutes to audio part.
- share the screenshots of the app.
- notification of what you are currently playing.

A few resources to get you started:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# SUPPORT THE WORK

[![GitHub followers](https://img.shields.io/github/followers/hrshmistry?style=social)](https://github.com/hrshmistry?tab=followers)
[![GitHub forks](https://img.shields.io/github/forks/hrshmistry/Video-Player?style=social)](https://github.com/hrshmistry/Video-Player/network/members)
[![GitHub stars](https://img.shields.io/github/stars/hrshmistry/Video-Player?style=social)]((https://github.com/hrshmistry/Video-Player/stargazers))

