import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:university_app/models/cache/book/book.dart';
import 'package:university_app/models/cache/sound/sound.dart';
import 'package:university_app/models/cache/summary/summary.dart';

import '../../models/cache/form/form.dart';
import '../../models/cache/lecture/lecture.dart';
import '../../models/cache/video/video.dart';
import '../cache_settIngs.dart';

class HiveProvider extends ChangeNotifier {
  Box<BookModel>? book;

  Future<Box<BookModel>?> openBookBox() async {
    if (book == null|| !book!.isOpen) {
      book = await Hive.openBox(CacheSettings.bookPath);
      notifyListeners();
    }
    return book;
  }

  Future<void> closeBookBox() async{
    if (book != null && book!.isOpen) {
      await book?.close();
      book = null;
      notifyListeners();
    }

  }
 Box<LectureModel>? lecture;

  Future<Box<LectureModel>?> openLectureBox() async {
    if (lecture == null|| !lecture!.isOpen) {
      lecture = await Hive.openBox(CacheSettings.lecturePath);
      notifyListeners();
    }
    return lecture;
  }

  Future<void> closeLectureBox() async{
    if (lecture != null && lecture!.isOpen) {
      await lecture?.close();
      lecture = null;
      notifyListeners();
    }

  }

  Box<SummaryModel>? summary;

  Future<Box<SummaryModel>?> openSummaryBox() async {
    if (summary == null|| !summary!.isOpen) {
      summary = await Hive.openBox(CacheSettings.summaryPath);
      notifyListeners();
    }
    return summary;
  }

  Future<void> closeSummaryBox() async{
    if (summary != null && summary!.isOpen) {
      await summary?.close();
      summary = null;
      notifyListeners();
    }
  }


  Box<FormModel>? form;

  Future<Box<FormModel>?> openFormBox() async {
    if (form == null|| !form!.isOpen) {
      form = await Hive.openBox(CacheSettings.formPath);
      notifyListeners();
    }
    return form;
  }

  Future<void> closeFormBox() async{
    if (form != null && form!.isOpen) {
      await form?.close();
      form = null;
      notifyListeners();
    }
  }

  Box<SoundModel>? sound;

  Future<Box<SoundModel>?> openSoundBox() async {
    if (sound == null|| !sound!.isOpen) {
      sound = await Hive.openBox(CacheSettings.soundPath);
      notifyListeners();
    }
    return sound;
  }

  Future<void> closeSoundBox() async{
    if (sound != null && sound!.isOpen) {
      await sound?.close();
      sound = null;
      notifyListeners();
    }
  }

  Box<VideoModel>? video;

  Future<Box<VideoModel>?> openVideoBox() async {
    if (video == null|| !video!.isOpen) {
      video = await Hive.openBox(CacheSettings.videoPath);
      notifyListeners();
    }
    return video;
  }

  Future<void> closeVideoBox() async{
    if (video != null && video!.isOpen) {
      await video?.close();
      video = null;
      notifyListeners();
    }
  }

  @override
  void dispose() async{
   await closeBookBox();
   await closeSummaryBox();
   await closeFormBox();
   await closeSoundBox();
   await closeVideoBox();
   await closeLectureBox();
   super.dispose();
  }
}
