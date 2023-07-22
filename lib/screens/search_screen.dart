import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:university_app/controllers/home_api_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: const Text(
            'البحث',
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
        body: SingleChildScrollView(
          child: Column(
            children: [
               SizedBox(
                height: 15.h,
              ),
              Container(
                height: 40.h,
                margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 8.0,
                      offset: Offset(1, 3),
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          HomeApiController()
                              .search(textEditingController.text, context);
                        },
                        child: const Icon(
                          Icons.search_sharp,
                          color: Color(0xff2D475F),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 45.h,
                          child: TextField(
                            decoration:  InputDecoration(
                              hintText: 'اكتب اسم المادة التي تبحث عنها',
                              hintStyle:TextStyle(fontSize: 10.sp),
                            ),
                            controller: textEditingController,
                            //initialValue: 'ابحث عن المادة..',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 90.h,
              ),
              Center(
                child: SvgPicture.asset(
                  'images/search.svg',
                  height: MediaQuery.of(context).size.height / 3.5,
                  color: Color(0xff2D475F),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
