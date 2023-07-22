import 'package:flutter/material.dart';
import 'package:university_app/controllers/home_api_controller.dart';
import 'package:university_app/models/major_dep.dart';
import 'package:university_app/models/years_model.dart';
import 'package:university_app/screens/term.dart';
import 'package:university_app/widgets/major.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MajorScreen extends StatefulWidget {
  const MajorScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<MajorScreen> createState() => _MajorScreenState();
}

class _MajorScreenState extends State<MajorScreen> {
  late Future<List<YearsModel>> _future;
  List<YearsModel> _majorYears = <YearsModel>[];

  List<MajorModel> _major = <MajorModel>[];

  @override
  void initState() {
    super.initState();
    _future = HomeApiController().getYears(context);
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
            'السنوات',
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
        body: Padding(
          padding: EdgeInsets.only(top: 20.0.h),
          child: FutureBuilder<List<YearsModel>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData ) {
                  _majorYears = snapshot.data ?? [];
                  return Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Center(
                      child:  _majorYears.isNotEmpty?OrientationBuilder(
                        builder: (BuildContext context, Orientation orientation)
                        {
                          bool isPortrait=orientation==Orientation.portrait;
                          return GridView.builder(
                                      itemCount: _majorYears.length,
                                      padding: const EdgeInsets.symmetric(vertical: 20),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: isPortrait?2:4,
                                        crossAxisSpacing: 15.w,
                                        mainAxisSpacing: 20.h,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                            onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        TermScreen(
                                                      mid: widget.id,
                                                      yid:
                                                          _majorYears[index].id,
                                                    ),
                                                  ),
                                                ),
                                            child: MajorWidget(
                                                title:
                                                    _majorYears[index].name));
                                      },
                                    );
                                  }):Column(
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
                    ),
                  );
                } else {
                  return SizedBox();
                }
              }),
        ),
      ),
    );
  }
}
