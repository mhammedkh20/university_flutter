import 'package:flutter/material.dart';
import 'package:university_app/controllers/home_api_controller.dart';
import 'package:university_app/models/courses.dart';
import 'package:university_app/screens/subject_screen.dart';

import '../widgets/subjects.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectsScreens extends StatefulWidget {
  const SubjectsScreens(
      {Key? key, required this.mid, required this.sid, required this.yid})
      : super(key: key);
  final int mid;

  final int yid;
  final int sid;

  @override
  State<SubjectsScreens> createState() => _SubjectsScreensState();
}

class _SubjectsScreensState extends State<SubjectsScreens> {
  late Future<List<CoursesModel>> _future;
  List<CoursesModel> _subjects = <CoursesModel>[];

  @override
  void initState() {
    super.initState();
    _future = HomeApiController().geSemesterCourses(widget.mid.toString(),
        widget.yid.toString(), widget.sid.toString(), context);
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
              icon: const Icon(Icons.arrow_back_ios)),
          centerTitle: true,
          title: const Text(
            'المواد  ',
            style: TextStyle(fontFamily: 'Droid'),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xff2D475F),
                  Color(0xff3AA8F2),
                ],
              ),
            ),
          ),
          /*   actions: [
            InkWell(
              onTap: () {
                _future = HomeApiController().geSemesterCourses(
                    widget.mid.toString(), widget.yid.toString(), widget.sid.toString(),isRefreshRequest: true);
                setState(() {});
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
            ),
          ],*/
        ),
        body: FutureBuilder<List<CoursesModel>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                _subjects = snapshot.data ?? [];
                print('subjects');
                return _subjects.isNotEmpty
                    ? OrientationBuilder(
                      builder: (BuildContext context, Orientation orientation) {
                        bool isPortrait=orientation==Orientation.portrait;

                        return GridView.builder(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
                          itemCount: _subjects.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: isPortrait?2:4,
                              crossAxisSpacing: 15.w,
                              mainAxisSpacing: 20),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubjectScreen(
                                    subjectId: _subjects[index].id,
                                    name: _subjects[index].name,
                                  ),
                                ),
                              ),
                              child: SubjectsWidget(
                                title: _subjects[index].name,
                                imagepath: 'images/folder.png',
                              ),
                            );
                          },
                        );
                      },
                    )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/nodata.jpg',
                            height: 250.h,
                            width: 250.w,
                          ),
                        const  Center(
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
