


// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:university_app/controllers/api_settings.dart';


// class PlayPoetAudio extends StatefulWidget {
//   const PlayPoetAudio({Key? key}) : super(key: key);

//   @override
//   _PlayPoetAudioState createState() => _PlayPoetAudioState();
// }

// class _PlayPoetAudioState extends State<PlayPoetAudio> {
//   final GeneralDataController _controller = GeneralDataController.to;

//   AudioPlayer audioPlayer = AudioPlayer();
//   PlayerState audioPlayerState = PlayerState.PAUSED;
//   // String url = '${ApiSetting.baseUrl + _controller.post.value.voice!}';
//   int timeProgress = 0;
//   int audioDuration = 0;

//   Widget slider() {
//     return Slider.adaptive(
//         activeColor: Colors.blue,
//         // thumbColor: m,
//         inactiveColor: Colors.grey,
//         min: 0.0,
//         max: audioDuration / 1000.floorToDouble(),
//         value: timeProgress / 1000.floorToDouble(),
//         onChanged: (value) {
//           seekToSec(value.toInt());
//         });
//   }

//   void seekToSec(int sec) {
//     Duration newPostion = Duration(seconds: sec);
//     audioPlayer.seek(newPostion);
//   }

//   playMusic() async {
//     await audioPlayer.play(ApiSettings.baseUrl + _controller.post.value.voice!);
//   }

//   pauseMusic() async {
//     await audioPlayer.pause();
//   }

//   String getTimeString(int milliseconds) {
//     String minutes = '${(milliseconds / 60000).floor() < 10 ? 0 : ''}${(milliseconds / 60000).floor()}';
//     String seconds = '${ (milliseconds / 1000).floor()%60 < 10 ? 0 : ''}${(milliseconds / 1000).floor() % 60 }';
//     return '$minutes:$seconds'; // Returns a string with the format mm:ss
//   }



//   @override
//   void initState() {
//     super.initState();
//     audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
//       setState(() {
//         audioPlayerState = s;
//       });
//     });
//     audioPlayer.setUrl(ApiSettings.apiUrl + _controller.post.value.voice!);

//     audioPlayer.onDurationChanged.listen((Duration duration) {
//       setState(() {
//         audioDuration = duration.inMilliseconds;
//       });
//     });

//     audioPlayer.onAudioPositionChanged.listen((Duration p) {
//       setState(() {
//         timeProgress = p.inMilliseconds;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     audioPlayer.release();
//     audioPlayer.dispose();
//     _controller.dispose();
//     super.dispose();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//         children: [
//           // Container(
//           //   child: Image.asset(
//           //     'asset/etabi.png',
//           //     fit: BoxFit.cover,
//           //     height: double.infinity,
//           //     width: double.infinity,
//           //   ),
//           // ),
//           Scaffold(
//             resizeToAvoidBottomInset: false,
//             backgroundColor: Colors.transparent,
//             extendBodyBehindAppBar: true,
//             appBar: AppBar(
//               toolbarHeight: 65.h,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.vertical(
//                   bottom: Radius.circular(25.r),
//                 ),
//               ),
//               title: Text(
//                 'صوتيــات',
//                 style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 24.sp),
//               ),
//               centerTitle: true,
//               backgroundColor: Colors.white,
//               elevation: 0.0,
//             ),
//             extendBody: true,
//             body: Container(
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Center(
//                     child: Padding(
//                       padding: EdgeInsets.only(top: 150.h),
//                       child: Container(
//                         height: 250.h,
//                         width: 200.w,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(25.r),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(25.r),
//                           child: _controller.post.value.image == null
//                               ? Image.asset(
//                             'asset/defultpic.jpg',
//                             height: 100.h,
//                             width: 80.w,
//                             fit: BoxFit.fill,
//                           )
//                               : Image.network(
//                             '${ApiSetting.baseUrl}${_controller.post.value.image}',
//                             height: 100.h,
//                             width: 80.w,
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   Center(
//                     child: AutoSizeText(
//                       '${_controller.post.value.name}',
//                       style: TextStyle(fontFamily: 'notobold', fontSize: 20.sp),
//                     ),
//                   ),
//                   // slider(),
//                   InkWell(
//                     onTap: () {
//                       // getAudio(ApiSetting.baseUrl + _controller.post.value.voice!);
//                       // getAudio();
//                       audioPlayerState == PlayerState.PLAYING ? pauseMusic() : playMusic();
//                     },
//                     child: Icon(
//                       audioPlayerState == PlayerState.PLAYING ? Icons.pause_circle_filled : Icons.play_circle_fill,
//                       // playing == false ? Icons.play_circle_fill : Icons.pause_circle_filled,
//                       size: 80.w,
//                       color: m,
//                     ),
//                   ),
                  
                    
                  
//                 ],
//               ),
//             ),
//           ),
//         ]
//     );
//   }
// }