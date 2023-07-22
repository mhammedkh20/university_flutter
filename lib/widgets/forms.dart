import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:university_app/cache/cache_file/form_cache.dart';
import 'package:university_app/models/form.dart';
import 'package:university_app/models/cache/form/form.dart'as cf;

import '../cache/controller/hive_provider.dart';
import '../cache/widgets/download_button.dart';
import '../cache/widgets/file_size.dart';
import '../controllers/functions.dart';
import '../controllers/home_api_controller.dart';
import '../controllers/mode.dart';
import '../screens/SummaryPDF.dart';
import '../theme/my_colors.dart';
import 'package:path/path.dart'as p;

import 'downloading_widget.dart';

class FormsWidget extends StatefulWidget {
  final FormModel formModel;
  final String imagepath;

  const FormsWidget({Key? key, required this.formModel, required this.imagepath})
      : super(key: key);

  @override
  State<FormsWidget> createState() => _FormsWidgetState();
}

class _FormsWidgetState extends State<FormsWidget> {

  bool _isFutureExecuting = false;

  late Future<String?> fileFuture;

  @override
  void initState() {
    // TODO: implement initState
    fileFuture = CacheForm().getFilePath(widget.formModel.id,p.extension(widget.formModel.res).toLowerCase());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color color =context.watch<SettingsModel>().isDark?colorPrimaryD:Colors.white;

    return InkWell(
      onTap: ()async{
        if(!widget.formModel.isPdf){
          showDialog(
              context: context,
              builder: (_) => WillPopScope(
                onWillPop: () async {
                  if (_isFutureExecuting) {
                    return false;
                  }
                  return true;
                },
                child:  DownloadingWidget(),
              ));
          setState(() {
            _isFutureExecuting = true;
          });
          await viewFile(widget.formModel.res,widget.formModel.id, context);
          _isFutureExecuting = false;
          Navigator.pop(context);
        }else{
          String? path=await fileFuture;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SummaryPDF(
                    path:path,
                    res: widget.formModel.res,
                    name: widget.formModel.name,
                  )));
        }

      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            width: 1,
            color: color,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        // width: 170.w,
        // height: 174.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DownloadButton(
                    fileFuture: fileFuture,
                    onTapDownload: () async {
                      final Box<cf.FormModel>? box =
                      await context.read<HiveProvider>().openFormBox();
                      fileFuture = CacheForm().addFormModel(widget.formModel, box!);
                      await context.read<HiveProvider>().closeFormBox();
                      setState(() {

                      });
                    },
                  ),


                  FileSize(size: widget.formModel.size,)
                ],
              ),
            ),
            Expanded(
              child: Image.asset(widget.imagepath),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: Text(
                widget.formModel.name,
                style: TextStyle(
                  color: const Color(0xff377198),
                  fontSize: 12.spMin,
                  fontFamily: 'Droid',
                  fontWeight: FontWeight.bold,
                ),
                // overflow: TextOverflow.ellipsis,
                maxLines: 2,

                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

