import 'package:flutter/material.dart';
import 'package:university_app/controllers/home_api_controller.dart';
import 'package:university_app/models/major_dep.dart';
import 'package:university_app/models/semester.dart';
import 'package:university_app/models/years_model.dart';
import 'package:university_app/screens/subjects_screen.dart';
import 'package:university_app/widgets/term.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermScreen extends StatefulWidget {
  const TermScreen({Key? key, required this.mid, required this.yid})
      : super(key: key);
  final int mid;
  final int yid;

  @override
  State<TermScreen> createState() => _TermScreenState();
}

class _TermScreenState extends State<TermScreen> {
  late Future<List<SemesterModel>> _future;
  List<SemesterModel> _semester = <SemesterModel>[];

  @override
  void initState() {
    super.initState();
    _future = HomeApiController().getSemesters(context);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          centerTitle: true,
          title: const Text(
            'التخصص ',
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
        ),
        body: FutureBuilder<List<SemesterModel>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                _semester = snapshot.data ?? [];

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: _semester.isNotEmpty?ListView.builder(
                      itemCount: _semester.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 50.h,
                            ),
                            InkWell(
                                onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SubjectsScreens(
                                          mid: widget.mid,
                                          yid: widget.yid,
                                          sid: _semester[index].id,
                                        ),
                                      ),
                                    ),
                                child: TermWidget(name: _semester[index].name)),
                          ],
                        );
                      }): Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/nodata.jpg',
                        height: 250.h,
                        width: 250.w,
                      ),
                      Center(
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
                  ),
                );
              } else {
                return const SizedBox();
              }
            }),
      ),
    );
  }
}
