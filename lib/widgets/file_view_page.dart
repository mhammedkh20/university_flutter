import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:open_file_safe/open_file_safe.dart';

import 'package:path/path.dart' as p;

class FileViewPage extends StatefulWidget {
  final String fileUrl;

  const FileViewPage({
    Key? key,
    required this.fileUrl,
  }) : super(key: key);

  @override
  _FileViewPageState createState() => _FileViewPageState();
}

class _FileViewPageState extends State<FileViewPage> {
  late Future<String> _localFilePathFuture;

  Future<String> _downloadFile(String url) async {
    final response = await http.get(Uri.parse(url));

    final directory = await getTemporaryDirectory();
    final extension = p.extension(url).toLowerCase();

    final filePath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}$extension';

    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    return filePath;
  }

  Future<void> _openFile(String filePath) async {
    final result = await OpenFile.open(filePath);
    if (result.type == ResultType.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to open file'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _localFilePathFuture = _downloadFile(widget.fileUrl);
  }

  @override
  void dispose() {
    _localFilePathFuture.then((filePath) {
      if (filePath.isNotEmpty) {
        File(filePath).deleteSync();
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String>(
        future: _localFilePathFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            final localFilePath = snapshot.data!;
            _openFile(localFilePath);
            Navigator.pop(context);
            return SizedBox();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
