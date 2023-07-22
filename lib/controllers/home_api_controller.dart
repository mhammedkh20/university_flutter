import 'dart:convert';
import 'dart:io';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:university_app/controllers/api_helper.dart';
import 'package:university_app/cache/cache_file/book_cache.dart';
import 'package:university_app/controllers/functions.dart';
import 'package:university_app/models/book.dart';
import 'package:university_app/models/category.dart';
import 'package:university_app/models/courses.dart';
import 'package:university_app/models/dep_model.dart';
import 'package:university_app/models/distribution_points.dart';
import 'package:university_app/models/form.dart';
import 'package:university_app/models/links.dart';
import 'package:university_app/models/major_dep.dart';
import 'package:university_app/models/resource_type.dart';
import 'package:university_app/models/semester.dart';
import 'package:university_app/models/sound.dart';
import 'package:university_app/models/success_code.dart';
import 'package:university_app/models/summary.dart';
import 'package:university_app/models/university.dart';
import 'package:university_app/models/video.dart';
import 'package:university_app/models/video_link.dart';
import 'package:university_app/models/years_model.dart';
import 'package:university_app/screens/subject_screen.dart';
import '../cache/hive_functions/hive_functions.dart';
import '../models/lectures.dart';
import '../prefs/shared_prefs_controller.dart';
import 'api_settings.dart';
import 'package:http/http.dart' as http;

class HomeApiController with ApiHelper {



  Future<List<University>> getUniversities({bool? isRefreshRequest}) async {
    print('load from api');
    var url = Uri.parse(ApiSettings.universities);
    var response = await http.get(url, headers: headers);

    // print(response.body);
    // print(headers);
    if (response.statusCode == 200) {
      APICacheDBModel model =
          APICacheDBModel(key: 'api_univ', syncData: response.body);
      await APICacheManager().addCacheData(model);
      var categoriesJsonArray = jsonDecode(response.body)['data'] as List;

      return categoriesJsonArray
          .map((jsonObject) => University.fromJson(jsonObject))
          .toList();
    }

    return [];
  }

  Future<List<DepartmentModel>> getDepartment(
    String id,
    BuildContext context, {
    bool? isRefreshRequest,
  }) async {
    bool? isConnected = await checkInternetAccess(context);
    if (isConnected) {
      var url = Uri.parse(
        ApiSettings.departmentByUniv.replaceFirst("{id}", id),
      );
      print(url);
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var depJsonArray = jsonDecode(response.body)['data'] as List;
        return depJsonArray
            .map((jsonObject) => DepartmentModel.fromJson(jsonObject))
            .toList();
      }
    }

    return [];
  }

  Future<List<MajorModel>> getMajor(String id, BuildContext context,
      {bool? isRefreshRequest}) async {
    bool? isConnected = await checkInternetAccess(context);
    if (isConnected) {
      var url = Uri.parse(
        ApiSettings.majorInDepartment.replaceFirst("{id}", id),
      );
      print(url);
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var depJsonArray = jsonDecode(response.body)['data'] as List;
        return depJsonArray
            .map((jsonObject) => MajorModel.fromJson(jsonObject))
            .toList();
      }
    }

    return [];
  }

  Future<List<YearsModel>> getYears(BuildContext context) async {
    bool? isConnected = await checkInternetAccess(context);
    if (isConnected) {
      var url = Uri.parse(ApiSettings.years);
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var yearsJsonArray = jsonDecode(response.body)['data'] as List;

        return yearsJsonArray
            .map((jsonObject) => YearsModel.fromJson(jsonObject))
            .toList();
      }
    }
    return [];
  }

  Future<String> getFileSize(String url) async {
    final request = await HttpClient().headUrl(Uri.parse(url));
    final response = await request.close();
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to get file size for $url');
    }
    return formatFileSize(response.contentLength);
    // return response.contentLength;
  }

  Future<List<SemesterModel>> getSemesters(BuildContext context) async {
    bool? isConnected = await checkInternetAccess(context);
    if (isConnected) {
      var url = Uri.parse(ApiSettings.semesters);

      var response = await http.get(url, headers: headers);

      print(response.statusCode);
      if (response.statusCode == 200) {
        var semesterJsonArray = jsonDecode(response.body)['data'] as List;
        return semesterJsonArray
            .map((jsonObject) => SemesterModel.fromJson(jsonObject))
            .toList();
      }
    }

    return [];
  }

  Future<List<CoursesModel>> geSemesterCourses(
      String mid, String yid, String sid, BuildContext context,
      {bool? isRefreshRequest}) async {
    bool? isConnected = await checkInternetAccess(context);
    if (isConnected) {
      var url = Uri.parse(ApiSettings.yearsemestercourses
          .replaceAll('{major_id}', mid)
          .replaceAll('{year_id}', yid)
          .replaceAll('{semester_id}', sid));
      print(url);
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var courseJsonArray = jsonDecode(response.body)['data'] as List;
        return courseJsonArray
            .map((jsonObject) => CoursesModel.fromJson(jsonObject))
            .toList();
      }
    }

    return [];
  }

  Future<List<ResourceType>> getResourceType() async {
    var url = Uri.parse(ApiSettings.resourceTypes);
    var response = await http.get(url, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> jsonData = body['data'];
      return jsonData
          .map((jsonObject) => ResourceType.fromJson(jsonObject))
          .toList();
    }
    return [];
  }

  Future<List<SoundModel>> getSound(String id) async {
    var url = Uri.parse(ApiSettings.sounds.replaceFirst("{id}", id));
    print(url);
    var response = await http.get(url, headers: headers);

    print(response.statusCode);
    if (response.statusCode == 200) {
      APICacheDBModel model =
          APICacheDBModel(key: 'api_sounds', syncData: response.body);
      await APICacheManager().addCacheData(model);
      var soundJsonArray = jsonDecode(response.body)['data'] as List;

      for(int i=0;i<soundJsonArray.length;i++){
        soundJsonArray[i]['size']=await getFileSize(soundJsonArray[i]['res']);
      }
      return soundJsonArray
          .map((jsonObject) => SoundModel.fromJson(jsonObject))
          .toList();
    }

    return [];
  }
//subject id
  Future<List<BookModel>> getBooks(String id, BuildContext context) async {
    bool? isConnected = await checkInternetAccess(context);
    if (isConnected) {
      var url = Uri.parse(ApiSettings.allBooks.replaceFirst("{id}", id));
      print(url);
      var response = await http.get(url, headers: headers);

      print(response.statusCode);
      if (response.statusCode == 200) {
        APICacheDBModel model =
            APICacheDBModel(key: 'api_books', syncData: response.body);
        await APICacheManager().addCacheData(model);
        var bookJsonArray = jsonDecode(response.body)['data'] as List;

        for(int i=0;i<bookJsonArray.length;i++){
          bookJsonArray[i]['size']=await getFileSize(bookJsonArray[i]['res']);
          bookJsonArray[i]['isPdf']=isPdfFile(bookJsonArray[i]['res']);

        }

        return bookJsonArray
            .map((jsonObject) => BookModel.fromJson(jsonObject))
            .toList();
      }
    }

    return [];
  }

  Future<List<LinksModel>> getLinks(String id) async {
    var url = Uri.parse(ApiSettings.urlResource.replaceFirst("{id}", id));
    print(url);
    var response = await http.get(url, headers: headers);

    print(response.statusCode);
    if (response.statusCode == 200) {
      var linkJsonArray = jsonDecode(response.body)['data'] as List;
      return linkJsonArray
          .map((jsonObject) => LinksModel.fromJson(jsonObject))
          .toList();
    }
    return [];
  }
  Future<List<LecturesModel>> getLectures(String id,context) async {
    bool? isConnected = await checkInternetAccess(context);
    if (isConnected) {
      var url = Uri.parse(ApiSettings.lectures.replaceFirst("{id}", id));
      print(url);
      var response = await http.get(url, headers: headers);

      print(response.statusCode);
      if (response.statusCode == 200) {
        APICacheDBModel model =
        APICacheDBModel(key: 'api_lectures', syncData: response.body);
        await APICacheManager().addCacheData(model);
        var bookJsonArray = jsonDecode(response.body)['data'] as List;

        for(int i=0;i<bookJsonArray.length;i++){
          bookJsonArray[i]['size']=await getFileSize(bookJsonArray[i]['res']);
          bookJsonArray[i]['isPdf']=isPdfFile(bookJsonArray[i]['res']);

        }

        return bookJsonArray
            .map((jsonObject) => LecturesModel.fromJson(jsonObject))
            .toList();
      }
    }

    return [];
  }

  Future<List<SummaryModel>> getSummary(String id) async {
    var url = Uri.parse(ApiSettings.summarizations.replaceFirst("{id}", id));
    print('test url :$url');
    var response = await http.get(url, headers: headers);

    print(response.statusCode);
    if (response.statusCode == 200) {
      APICacheDBModel model =
          APICacheDBModel(key: 'api_summary', syncData: response.body);
      await APICacheManager().addCacheData(model);
      var summaryJsonArray = jsonDecode(response.body)['data'] as List;

      for(int i=0;i<summaryJsonArray.length;i++){
        summaryJsonArray[i]['size']=await getFileSize(summaryJsonArray[i]['res']);
        summaryJsonArray[i]['isPdf']=isPdfFile(summaryJsonArray[i]['res']);

      }
      return summaryJsonArray
          .map((jsonObject) => SummaryModel.fromJson(jsonObject))
          .toList();
    }

    return [];
  }

  Future<List<VideoModel>> getVideo(String id) async {
    var url = Uri.parse(ApiSettings.video.replaceFirst("{id}", id));
    print(url);
    var response = await http.get(url, headers: headers);

    print(response.statusCode);
    if (response.statusCode == 200) {
      var videoJsonArray = jsonDecode(response.body)['data'] as List;

      for(int i=0;i<videoJsonArray.length;i++){
        videoJsonArray[i]['size']=await getFileSize(videoJsonArray[i]['res']);
      }

      return videoJsonArray
          .map((jsonObject) => VideoModel.fromJson(jsonObject))
          .toList();
    }

    return [];
  }

  Future<List<FormModel>> getFormSample(String id, BuildContext context) async {
    bool? isConnected = await checkInternetAccess(context);
    if (isConnected) {
      var url = Uri.parse(ApiSettings.samples.replaceFirst("{id}", id));
      print(url);
      var response = await http.get(url, headers: headers);

      print(response.statusCode);
      if (response.statusCode == 200) {
        var formJsonArray = jsonDecode(response.body)['data'] as List;

        for(int i=0;i<formJsonArray.length;i++){
          formJsonArray[i]['size']=await getFileSize(formJsonArray[i]['res']);
          formJsonArray[i]['isPdf']=isPdfFile(formJsonArray[i]['res']);
        }
        return formJsonArray
            .map((jsonObject) => FormModel.fromJson(jsonObject))
            .toList();
      }
    }

    return [];
  }

  Future<List<VideoLinksModel>> getVideoUrl(String id) async {
    var url = Uri.parse(ApiSettings.videoUrl.replaceFirst("{id}", id));
    print(url);
    var response = await http.get(url, headers: headers);

    print(response.statusCode);
    if (response.statusCode == 200) {
      APICacheDBModel model =
          APICacheDBModel(key: 'api_getVideoUrl', syncData: response.body);
      await APICacheManager().addCacheData(model);
      var vlinkJsonArray = jsonDecode(response.body)['data'] as List;

      return vlinkJsonArray
          .map((jsonObject) => VideoLinksModel.fromJson(jsonObject))
          .toList();
    }
    return [];
  }

  Future<List<CategoryModel>> getCategory() async {
    var url = Uri.parse(ApiSettings.getCategories);
    print(url);
    var response = await http.get(url, headers: headers);

    print(response.statusCode);
    if (response.statusCode == 200) {
      var categoriesArray = jsonDecode(response.body)['data'] as List;

      return categoriesArray
          .map((jsonObject) => CategoryModel.fromJson(jsonObject))
          .toList();
    }

    return [];
  }

  Future<List<DistributionPointsModel>> getDistributionPoints() async {
    var url = Uri.parse(ApiSettings.getDistributionPoints);
    print(url);
    var response = await http.get(url, headers: headers);

    print(response.statusCode);
    if (response.statusCode == 200) {
      var pointsArray = jsonDecode(response.body)['data'] as List;
      return pointsArray
          .map((jsonObject) => DistributionPointsModel.fromJson(jsonObject))
          .toList();
    }
    return [];
  }

  chargeUserCard(String cardCode, BuildContext context) async {
    var url = Uri.parse(ApiSettings.chargeUserCard);
    print(url);
    var response = await http.post(url, headers: headers, body: {
      'code': cardCode,
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      //List jsonObject = json.decode(response.body);
      //  ApiResponse jsonObject =ApiResponse.fromJson(response.body);
      //  print(jsonObject);
      print(json.decode(response.body)['message']);
      var message = json.decode(response.body)['message'];
      if (message == "تم تفعيل البطاقة بنجاح") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "تم تفعيل البطاقة بنجاح",
            ),
          ),
        );
        SharedPrefController().setIsActiveCard('yes');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessCode(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              message,
            ),
          ),
        );
      }
    }
  }

  search(String courseName, BuildContext context) async {
    var url = Uri.parse(ApiSettings.search + "?txt=$courseName");

    print(url);
    var response = await http.get(url, headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            jsonDecode(response.body)['message'],
          ),
        ),
      );
      print(response.body);

      var courseArray = jsonDecode(response.body)['data'] as List;
      List<CoursesModel> list = courseArray
          .map((jsonObject) => CoursesModel.fromJson(jsonObject))
          .toList();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SubjectScreen(
            subjectId: courseArray[0]['id'],
            name: courseArray[0]['name'],
          ),
        ),
      );
      print(list.first.id);
      print(courseArray[0]['id'].toString());
    }
  }
}

Future<bool> checkInternetAccess(BuildContext context) async {
  bool isConnected = true;
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      isConnected = true;
    }
  } on SocketException catch (_) {
    isConnected = false;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('لا يوجد اتصال بالانترنت'),
      ),
    );
  }
  return isConnected;
}
