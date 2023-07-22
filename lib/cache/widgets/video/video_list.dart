import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:university_app/cache/cache_settIngs.dart';
import 'package:university_app/cache/widgets/fab.dart';

import '../../../models/cache/video/video.dart';
import '../../../widgets/no_cache.dart';
import '../../cache_file/video_cache.dart';
import '../../controller/hive_provider.dart';
import '../future_pdf_card.dart';
import 'package:path/path.dart'as p;

class VideoList extends StatefulWidget {
  const VideoList({Key? key}) : super(key: key);

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  Widget build(BuildContext context) {
    final hiveProvider = Provider.of<HiveProvider>(context);
    return FutureBuilder<Box<VideoModel>?>(
        future: hiveProvider.openVideoBox(),
        builder: (context, snapshot) {
          Box<VideoModel>? temp = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ValueListenableBuilder<Box<VideoModel>>(
              valueListenable: temp!.listenable(),
              builder: (context, box, _) {
                List<VideoModel> books = box.values.toList();
                return Padding(
                  padding: const EdgeInsets.all(20),
                  // child: context.watch<CacheModel>().cached.isEmpty
                  child: books.isEmpty
                      ? const NoCacheFound(resType: 'فيديوهات')
                      : Scaffold(
                          body: ListView.separated(
                            itemCount: books.length,
                            itemBuilder: (BuildContext context, int index) {
                              String url = books[index].res;
                              String pdfName = books[index].name;
                              return FutureVideoCard(
                                filePath:
                                    CacheVideo().getFilePath(books[index].id,p.extension(url).toLowerCase()),
                                onTapDelete: () async {
                                  await CacheVideo()
                                      .deleteVideoModel(books[index]);
                                },
                                url: url,
                                pdfName: pdfName,
                                imgPath: 'images/pdf.png',
                                size: books[index].size,
                              );
                            },
                            separatorBuilder: (_, _i) => const SizedBox(
                              height: 15,
                            ),
                          ),
                          floatingActionButton: DeleteAllButton(
                            onTapDeleteAll: () async {
                              final Box<VideoModel>? box =
                                  await hiveProvider.openVideoBox();
                              CacheVideo().removeAllCached(box!);
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
