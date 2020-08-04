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
  <img src="/ss/vss.gif" height="600" width="330"  />
</p?

A few resources to get you started:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
