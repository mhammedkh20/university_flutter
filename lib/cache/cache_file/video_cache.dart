import 'package:hive/hive.dart';

import 'cache.dart';
import '../cache_settIngs.dart';
import '../../models/cache/video/video.dart'as cv;
import '../../models/video.dart';
import 'package:path/path.dart'as p;

class CacheVideo extends Cache{
  static final CacheVideo _instance = CacheVideo._internal();

  factory CacheVideo() {
    return _instance;
  }

  CacheVideo._internal(){
    setResType(CacheSettings.videoPath);
  }

  Future<String> addVideoModel(VideoModel video,Box<cv.VideoModel> box) async {
    final file = cv.VideoModel()
      ..id = video.id
      ..name = video.name
      ..resource_type_id = video.resource_type_id
      ..size = video.size
      ..res = video.res
      ..created_at = DateTime.now().toString()
      ..updated_at = video.updated_at;

    await box.add(file);
    // print(await getFilePath(video.id));
    return await putFileFromUrlInPath(video.res, video.id);
  }

  Future<void> deleteVideoModel(cv.VideoModel videoModel) async {
    await removeFile(videoModel.id,p.extension(videoModel.res).toLowerCase());
    await videoModel.delete();
  }

  void removeAllCached(Box<cv.VideoModel> box) async {
    for (var model in box.values) {
      await removeFile(model.id,p.extension(model.res).toLowerCase());
    }
    await box.clear();
  }


}
