import 'package:flutter/material.dart';
import 'package:university_app/controllers/home_api_controller.dart';
import 'package:university_app/models/resource_type.dart';
import 'package:university_app/screens/audio_screen.dart';
import 'package:university_app/screens/books_screen.dart';
import 'package:university_app/screens/forms_screen.dart';
import 'package:university_app/screens/lectures_screen.dart';
import 'package:university_app/screens/links_screen.dart';
import 'package:university_app/screens/summary_screen.dart';
import 'package:university_app/screens/video_link.dart';
import 'package:university_app/screens/videos_screen.dart';
import 'package:university_app/screens/voice_screen.dart';
import 'package:university_app/widgets/subject.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../prefs/shared_prefs_controller.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({Key? key, required this.subjectId, required this.name})
      : super(key: key);
  final int subjectId;
  final String name;

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {

  late Future<List<ResourceType>> _future;
  List<ResourceType> _resourceType = <ResourceType>[];
  var isActiveCard = "No";
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _future = HomeApiController().getResourceType();
    isActiveCard = SharedPrefController().isActiveCard ?? "";

  }



  @override
  Widget build(BuildContext context) {
    print('subjectId : ${widget.subjectId}');

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
          title: Text(
            widget.name,
            style: const TextStyle(fontFamily: 'Droid'),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xff2D475F), Color(0xff3AA8F2)])),
          ),

        ),
        body: FutureBuilder<List<ResourceType>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                _resourceType = snapshot.data ?? [];
                return OrientationBuilder(
                  builder: (BuildContext context, Orientation orientation) {
                    bool isPortrait=orientation==Orientation.portrait;
                    return GridView.builder(
                        padding: EdgeInsets.only(top: 35.h,right: 15.w,left: 15.w,bottom: 35.h,),
                        itemCount: _resourceType.length,
                        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isPortrait?2:4,
                            crossAxisSpacing: 20.w,
                            mainAxisSpacing: isPortrait?15.h:20.h,
                        ),
                        itemBuilder: (context, index) {
                          if(_resourceType[index].id==23){
                            _resourceType[index].name='محاضرات';
                            imagePath='images/subject/lecture.png';
                          }else if(_resourceType[index].id==22){
                            _resourceType[index].name='الكتب والمراجع';
                            imagePath='images/subject/book.png';
                          }else if(_resourceType[index].id==18){
                            _resourceType[index].name='الملازم والملخصات';
                            imagePath='images/subject/summary.png';
                          }else if (_resourceType[index].id == 16) {
                            imagePath='images/subject/voic.png';
                          }else if (_resourceType[index].id == 17) {
                            imagePath='images/subject/link.png';
                          }else if (_resourceType[index].id == 19) {
                            imagePath='images/subject/vid.png';
                          }else if (_resourceType[index].id == 20) {
                            imagePath='images/subject/form.png';
                          }else if (_resourceType[index].id == 21) {
                            imagePath='images/subject/vid.png';
                          }

                          print('${_resourceType[index].name} ${_resourceType[index].id }  ');
                          return InkWell(
                              onTap: () {
                                if (
                                // isActiveCard == 'yes',
                                true
                                ) {
                                  if (_resourceType[index].id == 16) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) {
                                          return AudioScreen(subjectId: widget.subjectId);
                                        }),
                                      ),
                                    );
                                  }
                                  if (_resourceType[index].id == 22) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: ((context) {
                                          return BooksScreen(subjectId: widget.subjectId);
                                        })));
                                  }

                                  if (_resourceType[index].id == 17) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: ((context) {
                                          return Links(subjectId: widget.subjectId);
                                        })));
                                  }
                                  if (_resourceType[index].id == 18) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: ((context) {
                                          return SummaryScreen(subjectId: widget.subjectId);
                                        })));
                                  }
                                  if (_resourceType[index].id == 19) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: ((context) {
                                          return VideosScreen(subjectId: widget.subjectId);
                                        })));
                                  }
                                  if (_resourceType[index].id == 20) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: ((context) {
                                          return FormsScreen(subjectId: widget.subjectId);
                                        })));
                                  }
                                  if (_resourceType[index].id == 21) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: ((context) {
                                          return VideoLinks(subjectId: widget.subjectId);
                                        })));
                                  }
                                  if (_resourceType[index].id == 23) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: ((context) {
                                          return LecturesScreen(subjectId: widget.subjectId);
                                        })));
                                  }
                                }
                                else {
                                  Navigator.pushNamed(context, '/pay_ways');
                                }
                              },
                              child: SubjectWidget(
                                title: _resourceType[index].name,
                                imagepath: imagePath??'images/subject/book.png',
                              ));
                        });
                  },
                );
              } else {
                return Column(
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
                );
              }
            }),
      ),
    );
  }
}
