import 'package:flutter/material.dart';
import 'package:university_app/controllers/home_api_controller.dart';
import 'package:university_app/models/major_dep.dart';
import 'package:university_app/screens/major_screen.dart';
import 'package:university_app/widgets/department.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DepartmentScreen extends StatefulWidget {
  const DepartmentScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  late Future<List<MajorModel>> _future;
  List<MajorModel> _major = <MajorModel>[];

  @override
  void initState() {
    super.initState();
    _future = HomeApiController().getMajor(widget.id.toString(),context);
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
            'القسم ',
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
         /* actions: [
            InkWell(
              onTap: () {
                _future = HomeApiController()
                    .getMajor(widget.id.toString(), isRefreshRequest: true);
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
        body: FutureBuilder<List<MajorModel>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                _major = snapshot.data ?? [];

                return _major.isNotEmpty? OrientationBuilder(
                  builder: (BuildContext context, Orientation orientation) {
                    bool isPortrait=orientation==Orientation.portrait;
                    return ListView.builder(
                      itemCount: _major.length,
                      padding: EdgeInsets.symmetric(horizontal:isPortrait? 20:40,vertical: 20),
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MajorScreen(id: _major[index].id)));
                            },
                            child: Department(title: _major[index].name, paddingWidth: isPortrait?15:10, paddingHeight: isPortrait?10:5,));
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
              }
              return SizedBox();
            }),
      ),
    );
  }
}
