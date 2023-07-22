import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:university_app/controllers/home_api_controller.dart';
import 'package:university_app/models/category.dart';

class CardCategoriesScreen extends StatefulWidget {
   CardCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CardCategoriesScreen> createState() => _CardCategoriesScreenState();
}

class _CardCategoriesScreenState extends State<CardCategoriesScreen> {
  List<CategoryModel> categoriesList = <CategoryModel>[];
  late Future<List<CategoryModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = HomeApiController().getCategory();

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
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'خطة الدفع ',
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
                  ]),
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50.h,),
                Text(
                  "اختر خطة الدفع التي تناسبك",
                  style: TextStyle(fontSize: 20.sp, color: Color(0xff2D475F)),
                ),
                SizedBox(height: 50.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: FutureBuilder<List<CategoryModel>>(
                    future: _future,
                    builder: (context, snapshot){
                      categoriesList = snapshot.data ?? [];

                      return GridView.count(
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5,
                        //  childAspectRatio: 0.09,
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 2,
                        children: categoriesList.map((e) {
                          return Padding(
                            padding: EdgeInsets.all(5),
                            child:  CardCategoriesWidget(
                              category: e,
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardCategoriesWidget extends StatelessWidget {
  CategoryModel category ;
   CardCategoriesWidget({
    Key? key,
    required this.category
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xff3AA8F2),
              Color(0xff2D475F),

            ]),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 1), // changes position of shadow
          ),
          //you can set more BoxShadow() here
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          SizedBox(height: 20.h,),
          Text(
            category.name,
            style: TextStyle(fontSize:16.sp,color: Colors.white),
          ),
          Row(
            children: [
              Text('المدة:',style: TextStyle(fontSize: 14.sp),),
              Text(
                category.period.toString(),
                style: TextStyle(color: Colors.white,fontSize:13.sp),
              ),
            ],
          ),
          Row(
            children: [
              Text('السعر:',style: TextStyle(fontSize: 14.sp),),
              Text(
                 category.price.toString(),
                style: TextStyle(color: Colors.white,fontSize:13.sp),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
