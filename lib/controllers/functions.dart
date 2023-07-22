import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file_safe/open_file_safe.dart';

import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:university_app/cache/cache_settIngs.dart';
import 'package:url_launcher/url_launcher.dart';

bool isPdfFile(String url) {
  final extension = p.extension(url).toLowerCase();
  return extension == '.pdf';
}

Future<void> viewFile(String url, int id, BuildContext context) async {
  final directory = await getTemporaryDirectory();
  final extension = p.extension(url).toLowerCase();
  final filePath =
      '${directory.path}/${CacheSettings.randomPath}/$id$extension';
  final file = File(filePath);
  if (!await file.exists()) {
    final response = await http.get(Uri.parse(url));
    await file.writeAsBytes(response.bodyBytes);
    if (kDebugMode) {
      print('downloded $filePath');
    }
  } else {
    if (kDebugMode) {
      print('exist $filePath');
    }
  }

  await _openFile(filePath, context);
}

Future<void> _openFile(String filePath, BuildContext context) async {
  final result = await OpenFile.open(filePath);
  if (result.type == ResultType.error) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to open file'),
      ),
    );
  }
}

void deleteAllRandomFiles() async {
  Directory tempDirectory = await getTemporaryDirectory();
  Directory directory =
      Directory('${tempDirectory.path}/${CacheSettings.randomPath}');
  // Get all files in the directory.
  List<FileSystemEntity> files = directory.listSync();

  // Delete each file in the directory.
  for (FileSystemEntity file in files) {
    await file.delete(recursive: true);
    print('file deleted ${file.path}');
  }
}
