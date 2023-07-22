import 'package:hive/hive.dart';

import 'cache.dart';
import '../cache_settIngs.dart';
import '../../models/cache/summary/summary.dart'as cs;
import '../../models/summary.dart';
import 'package:path/path.dart'as p;


class CacheSummary extends Cache{
  static final CacheSummary _instance = CacheSummary._internal();

  factory CacheSummary() {
    return _instance;
  }

  CacheSummary._internal(){
    setResType(CacheSettings.summaryPath);
  }





  Future<String> addSummaryModel(SummaryModel summary,Box<cs.SummaryModel> box) async {
    final pdf = cs.SummaryModel()
      ..id = summary.id
      ..name = summary.name
      ..resource_type_id = summary.resource_type_id
      ..size = summary.size
      ..res = summary.res
      ..created_at = DateTime.now().toString()
      ..updated_at = summary.updated_at
      ..isPdf=summary.isPdf;


    await box.add(pdf);
    return await putFileFromUrlInPath(summary.res, summary.id);
  }

  Future<void> deleteSummaryModel(cs.SummaryModel summaryModel) async {
    await removeFile(summaryModel.id,p.extension(summaryModel.res).toLowerCase());
    await summaryModel.delete();
  }

  void removeAllCached(Box<cs.SummaryModel> box) async {
    for (var model in box.values) {
      await removeFile(model.id,p.extension(model.res).toLowerCase());
    }
    await box.clear();
  }


}
