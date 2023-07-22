import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:university_app/controllers/auth_api_controller.dart';
import 'package:university_app/controllers/home_api_controller.dart';
import 'package:university_app/controllers/mode.dart';
import 'package:university_app/cache/cache_file/book_cache.dart';
import 'package:university_app/models/cache/book/book.dart';
import 'package:university_app/models/university.dart';
import 'package:university_app/prefs/shared_prefs_controller.dart';
import 'package:university_app/screens/department_screen.dart';
import 'package:university_app/screens/univ_department.dart';
import 'package:university_app/widgets/custom_university_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/constants.dart';

class UniversitiesScreen extends StatefulWidget {
  const UniversitiesScreen({Key? key}) : super(key: key);

  @override
  State<UniversitiesScreen> createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  late Future<List<University>> _future;
  List<University> _university = <University>[];
  bool isLoading = false;

  // late Box<BookModel> _myBox;

  @override
  void initState() {
    // _myBox = Hive.box<BookModel>('books');
    super.initState();
    _future = HomeApiController().getUniversities();

    // ()async{
    //   await Hive.openBox<BookModel>('books');
    // };

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool portrait=MediaQuery.of(context).orientation==Orientation.portrait;
    return Scaffold(
      endDrawer: Directionality(
        textDirection: TextDirection.rtl,
        child: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              // DrawerHeader(child: ),
              Container(
                padding:  EdgeInsets.fromLTRB(16.0, 16.0+MediaQuery.of(context).padding.top, 16.0, 8.0),
                margin: const EdgeInsets.only(bottom: 8.0),
                constraints: const BoxConstraints(
                  minHeight: 160,
                ),
                decoration:  BoxDecoration(
                  border: Border(
                    bottom: Divider.createBorderSide(context),
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color(0xff2D475F),
                      Color(0xff3AA8F2),
                    ],
                  ),
                ), //BoxDecoration
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      'images/logo.svg',
                      height: 50.h,
                      width: 70.w,
                    ),

                    Text(
                      'أهلاً بك في تطبيق ',
                      style: TextStyle(fontSize: 11.spMin, color: Colors.white),
                    ),
                    Text(
                      ' موسوعتي الجامعية',
                      style: TextStyle(
                          fontSize: 16.spMin,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),


                  ],
                ), //UserAccountDrawerHeader
              ), //DrawerHeader

              Consumer<SettingsModel>(
                builder: (context, provider, child) {
                  return SwitchListTile(
                    secondary: !provider.isDark?
                    Icon(Icons.dark_mode,color: Colors.deepPurpleAccent,)
                    :Icon(Icons.light_mode,color: Colors.amberAccent,),

                      title:!provider.isDark?
                      const Text('التنسيق الداكن ')
                      :const Text('التنسيق الفاتح '),
                    value:provider.isDark,
                    onChanged: (bool value) {
                      provider.changeMode();
                    },
                  );
                },
              ),

              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('عن التطبيق'),
                onTap: () {
                  Navigator.pushNamed(context, '/info');
                },
              ),
              ListTile(
                leading: const Icon(Icons.business_center_sharp),
                title: const Text('عن الشركة'),
                onTap: () {
                  Navigator.pushNamed(context, '/company');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.category,
                ),
                title: const Text('فئات الاشتراك'),
                onTap: () {
                  Navigator.pushNamed(context, '/card_category');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.business,
                ),
                title: const Text('نقاط البيع'),
                onTap: () {
                  Navigator.pushNamed(context, '/point');
                },

              ),

              ListTile(
                leading: const Icon(
                  Icons.save_alt,
                ),
                title: Text('المحفوظات'),
                onTap: () {
                  Navigator.pushNamed(context, '/saves_screen');
                },
              ),

              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('تسجيل خروج'),
                onTap: () async {
                  await logout(context);
                },
              )


            ],
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text(
          ' الجامعات',
          style: TextStyle(fontFamily: 'Droid'),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xff1D5377),
                Color(0xff2B7BB1),
                Color(0xff3496D8),
                Color(0xff39A5EE),
              ],
            ),
          ),
        ),
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              /*InkWell(
                onTap: () {
                  _future = HomeApiController()
                      .getUniversities(isRefreshRequest: true);
                  setState(() {

                  });
                },
                child: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              ),*/
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
                child: Icon(
                  Icons.search_sharp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        /*IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/info');
              },
              icon: Icon(Icons.info)),
          IconButton(
              onPressed: () async {
                await logout(context);
              },
              icon: Icon(Icons.logout)),
        ],*/
      ),
      body: Stack(
        children: [
          Positioned(
            right: -20,
            top: 20,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xff3AA8F2),
                    Color(0xff2D475F),
                  ],
                ),
              ),
              height: 650.h,
              width: 103.w,
            ),
          ),
          /*  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xff2D475F),
                  Color(0xff3AA8F2),
                ],
              ),*/ /*
              color: Colors.red,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 15.0,
                    offset: Offset(0.0, 0.75)
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Icon(Icons.search_sharp,color: Colors.white,),
                  SizedBox(width: 20,),
                  Expanded(
                    child: SizedBox(
                        height: 30,
                        child: TextFormField(
                          initialValue: 'ابحث عن المادة..',
                        )),
                  ),
                ],
              ),
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: FutureBuilder<List<University>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData &&
                    snapshot.data!.isNotEmpty &&
                    snapshot.connectionState == ConnectionState.done) {
                  _university = snapshot.data ?? [];
                  return _university.isNotEmpty
                      ? OrientationBuilder(
                        builder: (BuildContext context, Orientation orientation) {
                          bool isPortrait=orientation==Orientation.portrait;
                          return ListView.builder(
                            itemCount: _university.length,
                            padding: EdgeInsets.symmetric(horizontal: isPortrait?30.h:100.h,vertical: 15.h),
                            itemBuilder: ((context, index) {
                              return InkWell(
                                onTap: () =>
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UnivDepartment(
                                                id: _university[index].id),
                                      ),
                                    ),
                                child: Padding(
                                  padding:  EdgeInsets.only(bottom: isPortrait?30.h:40.h),
                                  child: CustomUnivItem(
                                      nameAR: _university[index].name,
                                      imagePath: _university[index].photo,
                                    ),
                                ),
                              );
                            }),
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    bool loggedOut = await AuthApiController().logout(context);
    if (loggedOut) Navigator.pushReplacementNamed(context, '/sign_in');
  }
}
