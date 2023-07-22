import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:university_app/cache/cache_file/summary_cache.dart';
import 'package:university_app/cache/controller/hive_provider.dart';
import 'package:university_app/cache/widgets/download_button.dart';
import 'package:university_app/models/summary.dart';
import 'package:university_app/models/cache/summary/summary.dart'as cs;
import 'package:university_app/widgets/downloading_widget.dart';

import '../cache/widgets/file_size.dart';
import '../controllers/functions.dart';
import '../controllers/home_api_controller.dart';
import '../controllers/mode.dart';
import '../screens/SummaryPDF.dart';
import 'package:provider/provider.dart';

import '../theme/my_colors.dart';
import 'package:path/path.dart'as p;

class SummaryWidget extends StatefulWidget {
  final SummaryModel summaryModel;
  final String imagepath;

  const SummaryWidget({Key? key, required this.imagepath, required this.summaryModel})
      : super(key: key);

  @override
  State<SummaryWidget> createState() => _SummaryWidgetState();
}

class _SummaryWidgetState extends State<SummaryWidget> {
  late Future<String?> fileFuture;
  late Future<String?> fileSize;
  bool _isFutureExecuting = false;

  @override
  void initState() {
    // TODO: implement initState
    fileFuture=CacheSummary().getFilePath(widget.summaryModel.id,p.extension(widget.summaryModel.res).toLowerCase());
    fileSize=HomeApiController().getFileSize(widget.summaryModel.res);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color color =context.watch<SettingsModel>().isDark?colorPrimaryD:Colors.white;

    return InkWell(
      onTap: ()async{
        if(widget.summaryModel.isPdf){
          String? path=await fileFuture;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SummaryPDF(
                    res: widget.summaryModel.res,
                    name: widget.summaryModel.name,
                    path: path,
                  )));
        }else{
          showDialog(
              context: context,
              builder: (_) => WillPopScope(
                onWillPop: () async {
                  if (_isFutureExecuting) {
                    return false;
                  }
                  return true;
                },
                child:DownloadingWidget(),
              ));
          setState(() {
            _isFutureExecuting = true;
          });
          await viewFile(widget.summaryModel.res,widget.summaryModel.id ,context);
          _isFutureExecuting = false;
          Navigator.pop(context);
        }

      },
      child: Container(
        padding: EdgeInsets.only(top: 10.h),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: color,
          ),
          borderRadius: BorderRadius.circular(15),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
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
                      onTapDownload: ()async{
                        final Box<cs.SummaryModel>? box= await context.read<HiveProvider>().openSummaryBox();
                        fileFuture= CacheSummary().addSummaryModel(widget.summaryModel,box!);
                        await  context.read<HiveProvider>().closeSummaryBox();
                        setState(() {

                        });

                      }
                  ),
                   FileSize(size: widget.summaryModel.size),

                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Image.asset(widget.imagepath),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: Text(
                widget.summaryModel.name,
                style: TextStyle(
                  color: const Color(0xff377198),
                  fontSize: 14.spMin,
                  fontFamily: 'Droid',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );

    // return  GestureDetector(
//   onTap: () {
//     // Handle item tap
//   },
//   child: Card(
//     elevation: 2,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Expanded(
//           flex: 2,
//           child: Image.asset(
//             widget.imagepath,
//             fit: BoxFit.cover,
//           ),
//         ),
//         Expanded(
//           flex: 1,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.summaryModel.name,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   widget.summaryModel.size,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//           child: IconButton(
//             onPressed: () {
//               // Handle download button press
//             },
//             icon: Icon(Icons.download),
//           ),
//         ),
//       ],
//     ),
//   ),
// );

  }
}
