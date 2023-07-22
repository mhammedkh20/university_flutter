import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:university_app/cache/cache_file/book_cache.dart';
import 'package:university_app/cache/cache_file/form_cache.dart';
import 'package:university_app/cache/cache_file/lecture_cache.dart';
import 'package:university_app/cache/cache_file/sound_cache.dart';
import 'package:university_app/cache/cache_file/summary_cache.dart';
import 'package:university_app/cache/cache_file/video_cache.dart';

import '../../models/cache/book/book.dart';
import '../../models/cache/form/form.dart';
import '../../models/cache/lecture/lecture.dart';
import '../../models/cache/sound/sound.dart';
import '../../models/cache/summary/summary.dart';
import '../../models/cache/video/video.dart';
import '../cache_settIngs.dart';
import '../controller/hive_provider.dart';

Future<void> boxesInit()async{
  await Hive.initFlutter();

  Hive.registerAdapter(BookModelAdapter());
  await createBoxDir(CacheSettings.bookPath);

  Hive.registerAdapter(SummaryModelAdapter());
  await createBoxDir(CacheSettings.summaryPath);

  Hive.registerAdapter(FormModelAdapter());
  await createBoxDir(CacheSettings.formPath);

  Hive.registerAdapter(SoundModelAdapter());
  await createBoxDir(CacheSettings.soundPath);

  Hive.registerAdapter(VideoModelAdapter());
  await createBoxDir(CacheSettings.videoPath);

  Hive.registerAdapter(LectureModelAdapter());
  await createBoxDir(CacheSettings.lecturePath);


}

Future<void> clearAllBoxes(BuildContext context)async{

  for(int i=0;i<=5;i++){
    switch (i){
      case 0:
        Box<BookModel>? box= await Provider.of<HiveProvider>(context,listen: false).openBookBox();
        CacheBook().removeAllCached(box!);
        break;
      case 1:
        Box<SummaryModel>? box= await Provider.of<HiveProvider>(context,listen: false).openSummaryBox();
        CacheSummary().removeAllCached(box!);
        break;
       case 2:
        Box<FormModel>? box= await Provider.of<HiveProvider>(context,listen: false).openFormBox();
        CacheForm().removeAllCached(box!);
        break;
       case 3:
        Box<VideoModel>? box= await Provider.of<HiveProvider>(context,listen: false).openVideoBox();
        CacheVideo().removeAllCached(box!);
        break;
       case 4:
        Box<SoundModel>? box= await Provider.of<HiveProvider>(context,listen: false).openSoundBox();
        CacheSound().removeAllCached(box!);
        break;
       case 5:
        Box<LectureModel>? box= await Provider.of<HiveProvider>(context,listen: false).openLectureBox();
        CacheLectures().removeAllCached(box!);
        break;
    }
  }


 // await Provider.of<HiveProvider>(context,listen: false).summary?.clear();
 // await Provider.of<HiveProvider>(context,listen: false).form?.clear();
 // await Provider.of<HiveProvider>(context,listen: false).video?.clear();
 // await Provider.of<HiveProvider>(context,listen: false).sound?.clear();
}

Future<void> createBoxDir(String folderName)async{
  Directory cacheDirectory = await getTemporaryDirectory();
  await Directory("${cacheDirectory.path}/$folderName").create(recursive: true);
}

String formatFileSize(int bytes) {
  if(bytes==-1){
    return "حجم الملف غير محدد";
  }else if (bytes < 1024) {
    return '$bytes B';
  } else if (bytes < 1024 * 1024) {
    final sizeInKB = bytes / 1024;
    return '${sizeInKB.toStringAsFixed(1)} KB';
  } else if (bytes < 1024 * 1024 * 1024) {
    final sizeInMB = bytes / (1024 * 1024);
    return '${sizeInMB.toStringAsFixed(1)} MB';
  } else if (bytes < 1024 * 1024 * 1024 * 1024) {
    final sizeInGB = bytes / (1024 * 1024 * 1024);
    return '${sizeInGB.toStringAsFixed(1)} GB';
  } else {
    final sizeInTB = bytes / (1024 * 1024 * 1024 * 1024);
    return '${sizeInTB.toStringAsFixed(1)} TB';
  }
}