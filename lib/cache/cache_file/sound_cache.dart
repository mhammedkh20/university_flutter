import 'package:hive/hive.dart';

import 'cache.dart';
import '../cache_settIngs.dart';
import '../../models/cache/sound/sound.dart'as cs;
import '../../models/sound.dart';
import 'package:path/path.dart'as p;

class CacheSound extends Cache{
  static final CacheSound _instance = CacheSound._internal();

  factory CacheSound() {
    return _instance;
  }

  CacheSound._internal(){
    setResType(CacheSettings.soundPath);
  }





  Future<String> addSoundModel(SoundModel sound,Box<cs.SoundModel> box) async {
    final file = cs.SoundModel()
      ..id = sound.id
      ..name = sound.name
      ..resource_type_id = sound.resource_type_id
      ..size = sound.size
      ..res = sound.res
      ..created_at = DateTime.now().toString()
      ..updated_at = sound.updated_at;


    await box.add(file);
    // print(await getFilePath(sound.id));
    return await putFileFromUrlInPath(sound.res, sound.id);
  }

  Future<void> deleteSoundModel(cs.SoundModel soundModel) async {
    await removeFile(soundModel.id,p.extension(soundModel.res).toLowerCase());
    await soundModel.delete();
  }

  void removeAllCached(Box<cs.SoundModel> box) async {
    for (var model in box.values) {
      await removeFile(model.id,p.extension(model.res).toLowerCase());
    }
    await box.clear();
  }


}
