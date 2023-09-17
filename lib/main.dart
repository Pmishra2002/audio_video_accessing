import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late VideoPlayerController _videoPlayerController;
    File? _video;

  final picker = ImagePicker();

  Future<void> pickVideo() async {
    final video = await picker.pickVideo(source: ImageSource.gallery);
    _video = File(video!.path);
    _videoPlayerController = VideoPlayerController.file(_video!)
      ..initialize().then((_) {
        setState(() {

        });
        _videoPlayerController.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Video Player"),
        ),
        body: Column(
          children: [
            if(_video != null)
              _videoPlayerController.value.isInitialized ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              ) : Container()
            else
              const Text('Click on pick video to selected video'),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  pickVideo();
                },
                child: Text('Pick video from gallery'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

