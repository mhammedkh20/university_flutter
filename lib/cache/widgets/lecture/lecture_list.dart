import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:university_app/cache/widgets/fab.dart';

import '../../../models/cache/lecture/lecture.dart';
import '../../../widgets/no_cache.dart';
import '../../cache_file/lecture_cache.dart';
import '../../controller/hive_provider.dart';
import '../future_pdf_card.dart';
import 'package:path/path.dart'as p;

class LectureList extends StatefulWidget {
  const LectureList({Key? key}) : super(key: key);

  @override
  State<LectureList> createState() => _LectureListState();
}

class _LectureListState extends State<LectureList> {
  @override
  Widget build(BuildContext context) {
    final hiveProvider = Provider.of<HiveProvider>(context);
    return FutureBuilder<Box<LectureModel>?>(
        future: hiveProvider.openLectureBox(),
        builder: (context, snapshot) {
          Box<LectureModel>? temp = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ValueListenableBuilder<Box<LectureModel>>(
              valueListenable: temp!.listenable(),
              builder: (context, box, _) {
                List<LectureModel> lectures = box.values.toList();
                return Padding(
                  padding: const EdgeInsets.all(20),
                  // child: context.watch<CacheModel>().cached.isEmpty
                  child: lectures.isEmpty
                      ? const NoCacheFound(resType: 'ملفات')
                      : Scaffold(
                    body: ListView.separated(
                      itemCount: lectures.length,
                      itemBuilder: (BuildContext context, int index) {
                        String url = lectures[index].res;
                        String pdfName = lectures[index].name;
                        return FuturePDFCard(
                          isPdf: lectures[index].isPdf,
                          filePath:
                          CacheLectures().getFilePath(lectures[index].id,p.extension(url).toLowerCase()),
                          onTapDelete: () async {
                            await CacheLectures()
                                .deleteLecturesModel(lectures[index]);
                          },
                          url: url,
                          pdfName: pdfName,
                          imgPath: 'images/pdf.png',
                          size: lectures[index].size,
                        );
                      },
                      separatorBuilder: (_, _i) => const SizedBox(
                        height: 15,
                      ),
                    ),
                    floatingActionButton: DeleteAllButton(
                      onTapDeleteAll: () async {
                        final Box<LectureModel>? box =
                        await hiveProvider.openLectureBox();
                        CacheLectures().removeAllCached(box!);
                      },
                    ),
                  ),
                );
              },
            );
          }
        });
  }
}
