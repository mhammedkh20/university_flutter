import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:university_app/cache/cache_file/video_cache.dart';
import 'package:university_app/models/video.dart';
import 'package:university_app/models/cache/video/video.dart'as cv;
import 'package:university_app/widgets/video/url_video_player.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cache/controller/hive_provider.dart';
import '../cache/widgets/download_button.dart';
import '../cache/widgets/file_size.dart';
import '../controllers/home_api_controller.dart';
import '../controllers/mode.dart';
import '../theme/my_colors.dart';
import 'package:path/path.dart'as p;

class VideosWidget extends StatefulWidget {
  final VideoModel model;
  final String imagepath;


  const VideosWidget(
      {Key? key,
      required this.imagepath,
      required this.model,
      })
      : super(key: key);

  @override
  State<VideosWidget> createState() => _VideosWidgetState();
}

class _VideosWidgetState extends State<VideosWidget> {

  late Future<String?> fileFuture;
  late Future<String?> fileSize;

  @override
  void initState() {
    // TODO: implement initState
    fileFuture = CacheVideo().getFilePath(widget.model.id,p.extension(widget.model.res).toLowerCase());
    fileSize=HomeApiController().getFileSize(widget.model.res);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color color =context.watch<SettingsModel>().isDark?colorPrimaryD:Colors.white;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: InkWell(
        onTap: () async{
          // _launchUrl();
          String? path=await fileFuture;

          Uri url = Uri.parse(widget.model.res);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => PlayerWidget(
                        url: url.toString(),
                        name:widget.model.name,
                        path: path,
                      )));
        },
        child: SizedBox(
          width: 170.w,
          height: 175.h,
          child: Container(
            decoration: BoxDecoration(
              color: color,
                border: Border.all(
                  width: 1,
                  color: color,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow:  [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),                ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Directionality(
            textDirection:TextDirection.rtl,
                  child: SizedBox(
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DownloadButton(
                          fileFuture: fileFuture,
                          onTapDownload: () async {
                            final Box<cv.VideoModel>? box =
                            await context.read<HiveProvider>().openVideoBox();
                            fileFuture = CacheVideo().addVideoModel(widget.model, box!);
                            await context.read<HiveProvider>().closeVideoBox();
                            setState(() {

                            });
                          },
                        ),


                        FileSize(size: widget.model.size,)
                      ],
                    ),
                  ),
                ),

                Center(
                  child: Image.asset(widget.imagepath,height:100.h),
                ),
                const SizedBox(height: 5,),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Image.asset(
                        'images/film.png',
                      ),
                      Expanded(
                        child: Text(
                          widget.model.name,
                          style: TextStyle(
                            color: const Color(0xff377198),
                            fontSize: 16.sp,
                            fontFamily: 'Droid',
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
