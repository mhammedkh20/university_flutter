import 'package:hive/hive.dart';

import 'cache.dart';
import '../cache_settIngs.dart';
import '../../models/cache/form/form.dart'as cf;
import '../../models/form.dart';
import 'package:path/path.dart'as p;

class CacheForm extends Cache{
  static final CacheForm _instance = CacheForm._internal();

  factory CacheForm() {
    return _instance;
  }

  CacheForm._internal(){
    setResType(CacheSettings.formPath);
  }





  Future<String> addFormModel(FormModel form,Box<cf.FormModel> box) async {
    final pdf = cf.FormModel()
      ..id = form.id
      ..name = form.name
      ..resource_type_id = form.resource_type_id
      ..size = form.size
      ..res = form.res
      ..created_at = DateTime.now().toString()
      ..updated_at = form.updated_at
      ..isPdf=form.isPdf;


    await box.add(pdf);
    return await putFileFromUrlInPath(form.res, form.id);
  }

  Future<void> deleteFormModel(cf.FormModel formModel) async {
    await removeFile(formModel.id,p.extension(formModel.res).toLowerCase());
    await formModel.delete();
  }

  void removeAllCached(Box<cf.FormModel> box) async {
    for (var model in box.values) {
      await removeFile(model.id,p.extension(model.res).toLowerCase());
    }
    await box.clear();

  }


}
