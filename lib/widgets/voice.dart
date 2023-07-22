import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:university_app/cache/widgets/download_button.dart';
import 'package:university_app/cache/widgets/file_size.dart';
import 'package:university_app/models/sound.dart';
import 'package:university_app/models/cache/sound/sound.dart'as cs;

import '../cache/cache_file/sound_cache.dart';
import '../cache/controller/hive_provider.dart';
import '../controllers/mode.dart';
import '../theme/my_colors.dart';
import 'package:path/path.dart'as p;

class VoiceWidget extends StatefulWidget {
  final SoundModel model;

  const VoiceWidget({Key? key, required this.model})
      : super(key: key);

  @override
  State<VoiceWidget> createState() => _VoiceWidgetState();
}

class _VoiceWidgetState extends State<VoiceWidget> {
  late Future<String?> fileFuture;
  @override
  void initState() {
    // TODO: implement initState
    fileFuture = CacheSound().getFilePath(widget.model.id,p.extension(widget.model.res).toLowerCase());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Color color =context.watch<SettingsModel>().isDark?colorPrimaryD:Colors.white;

    return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          PhysicalModel(
            color: color,
            elevation: 6,
            shadowColor: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(15),
            child: ListTile(
              leading: DownloadButton(
                  fileFuture:fileFuture,
                  onTapDownload: ()async{
                    final Box<cs.SoundModel>? box =
                    await context.read<HiveProvider>().openSoundBox();
                    fileFuture = CacheSound().addSoundModel(widget.model, box!);
                    await context.read<HiveProvider>().closeSoundBox();
                    setState(() {});
                  }
              ),
              trailing: SvgPicture.asset('images/play.svg'),
              title: Text(
                widget.model.name,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 14.spMin,
                  fontFamily: 'Droid',
                  color: Colors.blueAccent,
                ),
              ),
              subtitle: FixedFileSize(size: widget.model.size),
            ),
          ),
          // Visibility(
          //   visible: false,
          //   child: ListTile(
          //     title: Text(
          //       link,
          //       textDirection: TextDirection.rtl,
          //       style: TextStyle(
          //         fontSize: 14.sp,
          //         fontFamily: 'Droid',
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
    // return Material(
    //   elevation: 21,
    //   shadowColor: Colors.grey.shade100,
    //   child: ListTile(
    //    shape: RoundedRectangleBorder(
    //      borderRadius: BorderRadius.circular(15)
    //    ),
    //     title: Text(link ,style: TextStyle(fontSize: 14,fontFamily: 'Droid' ),),
    //   ),
    // );
  }
}
