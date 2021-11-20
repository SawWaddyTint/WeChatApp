import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final File videoFile;
  final String videoLink;
  VideoView(this.videoFile, this.videoLink);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    if (widget.videoLink == "") {
      flickManager = FlickManager(
          videoPlayerController: VideoPlayerController.file(widget.videoFile));
    } else {
      flickManager = FlickManager(
          videoPlayerController:
              VideoPlayerController.network(widget.videoLink),
          autoPlay: false);
    }
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlickVideoPlayer(flickManager: flickManager),
    );
  }
}
