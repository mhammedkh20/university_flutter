import 'dart:io';

import 'package:flutter/material.dart';
import 'package:university_app/widgets/video/video_player_widget.dart';
import 'package:video_player/video_player.dart';



class PlayerWidget extends StatefulWidget {
  const PlayerWidget({Key? key, required this.url, required this.name, this.path}) : super(key: key);
  final String url;
  final String name;
  final String? path;

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {

  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    if(widget.path==null){
      controller = VideoPlayerController.network(widget.url);

    }else{
      controller = VideoPlayerController.file(File(widget.path??""));
    }
    controller
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
    alignment: Alignment.center,
    child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title:  Text(
          widget.name,
          style: TextStyle(fontFamily: 'Droid'),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xff2D475F), Color(0xff3AA8F2)],
            ),
          ),
        ),
      ),
     body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          VideoPlayerWidget(controller: controller),
        ],
      ),
    ),
  );


}
