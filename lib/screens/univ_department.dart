import 'package:flutter/material.dart';
import 'package:university_app/controllers/home_api_controller.dart';
import 'package:university_app/models/dep_model.dart';
import 'package:university_app/screens/department_screen.dart';
import 'package:university_app/widgets/univ_department.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/functions.dart';

class UnivDepartment extends StatefulWidget {
  const UnivDepartment({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<UnivDepartment> createState() => _UnivDepartmenetState();
}

class _UnivDepartmenetState extends State<UnivDepartment> {
  late Future<List<DepartmentModel>> _future;
  List<DepartmentModel> _department = <DepartmentModel>[];

  @override
  void initState() {
    super.initState();
    _future = HomeApiController().getDepartment(widget.id.toString(),context);
  }
  @override
  void dispose() {
    deleteAllRandomFiles();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          centerTitle: true,
          title: const Text(
            'أقسام الجامعات',
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
          /*  actions: [
            InkWell(
                onTap: () {
                  _future = HomeApiController().getDepartment(
                      widget.id.toString(),
                      isRefreshRequest: true);
                  setState(() {});
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                )),
          ],*/
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 30.h, left: 10.w, right: 10.w),
          child: FutureBuilder<List<DepartmentModel>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  _department = snapshot.data ?? [];
                  return _department.isNotEmpty?OrientationBuilder(
                    builder: (BuildContext context, Orientation orientation) {
                      bool isPortrait=orientation==Orientation.portrait;

                      return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: GridView.builder(
                        itemCount: _department.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isPortrait?2:4,
                            crossAxisSpacing: 20.w,
                            mainAxisSpacing: 10.h),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DepartmentScreen(
                                          id: _department[index].id)));
                            },
                            child: UnivDepartmentWidget(
                              title: _department[index].name,
                              //  imagePath: _department[index].photo,
                            ),
                          );
                        },
                      ),
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
                  return const Center(child: Text('تخقق من اتصال الانرنت'),);
                }
              }),
        ),
      ),
    );
  }
}
