import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:university_app/cache/widgets/download_button.dart';
import 'package:university_app/cache/widgets/file_size.dart';
import 'package:university_app/models/cache/sound/sound.dart';


class CacheVoiceWidget extends StatefulWidget {
  final SoundModel model;
  final VoidCallback onTapDelete;


  const CacheVoiceWidget({Key? key, required this.model, required this.onTapDelete})
      : super(key: key);

  @override
  State<CacheVoiceWidget> createState() => _CacheVoiceWidgetState();
}

class _CacheVoiceWidgetState extends State<CacheVoiceWidget> {
  late Future<String?> fileFuture;
  @override
  void initState() {
    // TODO: implement initState
    // fileFuture = CacheSound().getFilePath(widget.model.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          PhysicalModel(
            color: Colors.white,
            elevation: 6,
            shadowColor: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(15),
            child: ListTile(
              leading:  IconButton(
                  onPressed: () {
                    widget.onTapDelete();
                    setState(() {

                    });
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
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

        ],
      ),
    );

  }
}
