import 'package:flutter/material.dart';
import 'package:university_app/controllers/home_api_controller.dart';
import 'package:university_app/models/links.dart';
import 'package:university_app/widgets/lectures.dart';
import 'package:university_app/widgets/links.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/lectures.dart';


class LecturesScreen extends StatefulWidget {
  const LecturesScreen({ Key? key , required this.subjectId}) : super(key: key);
  final int subjectId ;

  @override
  State<LecturesScreen> createState() => _LecturesScreenState();
}

class _LecturesScreenState extends State<LecturesScreen> {
  late Future<List<LecturesModel>> _future;
  List<LecturesModel> _lectures = <LecturesModel>[];

  @override
  void initState() {

    super.initState();
    _future = HomeApiController().getLectures(widget.subjectId.toString(),context);
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: const Text(
            'المحاضرات',
            style: TextStyle(fontFamily: 'Droid'),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xff2D475F), Color(0xff3AA8F2)],
              ),
            ),
          ),
        ),
        body: FutureBuilder<List<LecturesModel>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                _lectures = snapshot.data ?? [];
                return _lectures.isNotEmpty ?OrientationBuilder(
                  builder: (BuildContext context, Orientation orientation) {
                    bool iPortrait=orientation==Orientation.portrait;
                    return GridView.builder(
                      padding: EdgeInsets.only(
                        left: 15.w,
                        right: 15.w,
                        top: 20.h,
                        bottom: 10,
                      ),
                      itemCount: _lectures.length,
                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: iPortrait?2:4,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15),
                      itemBuilder: (BuildContext context, int index) {
                        return LecturesWidget(
                          lectureModel: _lectures[index],
                          imagepath: 'images/pdf.png',
                        );
                      },
                    );
                  },
                ):Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/nodata.jpg',
                      height: 250.h,
                      width: 250.w,
                    ),
                    const Center(
                      child: Text(
                        'سيتم إضافتها قريباً ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return const SizedBox();
              }
            }),
      ),
    );
  }
}