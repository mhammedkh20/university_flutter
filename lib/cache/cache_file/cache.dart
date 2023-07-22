


import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;



abstract class Cache {
    late String resType;

    void setResType(String input){
       resType=input;
    }

    Future<String> filePath(int id,String extension)async{
       String dirPath = (await getTemporaryDirectory()).path;
       return '$dirPath/$resType/$id$extension';
    }

    Future<void> removeFile(int id,String extension) async {
      File file = File(await filePath(id,extension));
      if (await file.exists()) {
        await file.delete();
      }
    }
    Future<bool> isFileFound(int id,String extension) async {

      File file = File(await filePath(id,extension));
      if (await file.exists()) {
        print('founed $resType $id');
        return true;
      } else {
        return false;
      }
    }

    Future<String> putFileFromUrlInPath(String url, int id) async {
      var request = await http.get(Uri.parse(url));
      var bytes = request.bodyBytes;
      File file = File(await filePath(id,p.extension(url).toLowerCase()));
      await file.writeAsBytes(bytes);
      return file.path;
    }

    Future<String?> getFilePath(int id,String extension)async{
      if(await isFileFound(id,extension)){
        return await filePath(id,extension);
      }
      return null;

    }



}