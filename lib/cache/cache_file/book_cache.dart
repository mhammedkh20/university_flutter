import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:university_app/cache/cache_settIngs.dart';

import 'cache.dart';
import '../../models/cache/book/book.dart' as cb;
import '../../models/book.dart' as b;
import '../../models/cache/book/book.dart';
import 'package:path/path.dart'as p;


class CacheBook extends Cache{
  static final CacheBook _instance = CacheBook._internal();

  factory CacheBook() {
    return _instance;
  }

  CacheBook._internal(){
    setResType(CacheSettings.bookPath);
  }


   // List<cb.BookModel> get cached => Boxes.getBookModels().values.toList();



   Future<String> addBookModel(b.BookModel book,Box<cb.BookModel> box) async {
    final pdf = cb.BookModel()
      ..id = book.id
      ..name = book.name
      ..resource_type_id = book.resource_type_id
      ..size = book.size
      ..res = book.res
      ..created_at = DateTime.now().toString()
      ..updated_at = book.updated_at
    ..isPdf=book.isPdf;

    await box.add(pdf);
    return await putFileFromUrlInPath(book.res, book.id);
  }

  Future<void> deleteBookModel(cb.BookModel bookModel) async {
    await removeFile(bookModel.id,p.extension(bookModel.res).toLowerCase());
    await bookModel.delete();
  }

   void removeAllCached(Box<cb.BookModel>box) async {
    for (var book in box.values) {
      await removeFile(book.id,p.extension(book.res).toLowerCase());
    }
    await box.clear();
  }


}


