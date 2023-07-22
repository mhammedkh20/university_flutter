import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'basic_overlay_widget.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
       controller.value.isInitialized
          ? Expanded(
            child: Container(
             alignment: Alignment.center,
             color: Colors.black,
             child: buildVideo()
       ),
          )
          : Container(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );

  Widget buildVideo() => Stack(
        children: <Widget>[
          buildVideoPlayer(),
          Positioned.fill(child: BasicOverlayWidget(controller: controller)),
        ],
      );

  Widget buildVideoPlayer() => AspectRatio(
      aspectRatio: 16/9,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: VideoPlayer(controller),
      )
  );
}
