import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:university_app/screens/card_categories_screen.dart';
import 'package:university_app/screens/card_code_screen.dart';
import 'package:university_app/widgets/app_text_field.dart';

class AccountNumbers extends StatelessWidget {
  const AccountNumbers({Key? key}) : super(key: key);

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
            icon: const Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: const Text(
            'أرقام الحسابات',
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
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'يمكنك  اختيار فئة الاشتراك وتحويل سعر الاشتراك عبر الحسابات التالية:',
                style: TextStyle(
                  color: Color(0xff2D475F),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              const Divider(
                thickness: 2.0,
              ),
              Row(
                children: [
                  Text(
                    'بنك الكريمي:',
                    style: TextStyle(
                        color: Color(0xff2D475F),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '22201510',
                    style: TextStyle(
                        color: const Color(0xff2D475F),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(const ClipboardData(text: "22201510"))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تم نسخ رقم الحساب')));
                      });
                    },
                    child: Icon(
                      Icons.copy,
                      size: 18.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              const Divider(
                thickness: 2.0,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    'شركة ناصر العروي للصرافة:',
                    style: TextStyle(
                        color: Color(0xff2D475F),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '12255577',
                    style: TextStyle(
                        color: const Color(0xff2D475F),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(const ClipboardData(text: "12255577"))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم نسخ رقم الحساب'),
                          ),
                        );
                      });
                    },
                    child: Icon(
                      Icons.copy,
                      size: 18.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              const Divider(
                thickness: 2.0,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    'شركة عسكر البلعسي للصرافة:',
                    style: TextStyle(
                        color: Color(0xff2D475F),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '1227121',
                    style: TextStyle(
                        color: const Color(0xff2D475F),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(const ClipboardData(text: "1227121"))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم نسخ رقم الحساب'),
                          ),
                        );
                      });
                    },
                    child: Icon(
                      Icons.copy,
                      size: 18.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              const Divider(
                thickness: 2.0,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    'رقم حساب تطبيق محفظتي بنك التضامن:',
                    style: TextStyle(
                        color: Color(0xff2D475F),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '779508994',
                    style: TextStyle(
                        color: const Color(0xff2D475F),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(const ClipboardData(text: "779508994"))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم نسخ رقم الحساب'),
                          ),
                        );
                      });
                    },
                    child: Icon(
                      Icons.copy,
                      size: 15.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              const Divider(
                thickness: 2.0,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    'رقم حساب محفظة فلوسك:',
                    style: TextStyle(
                        color: Color(0xff2D475F),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '779508994',
                    style: TextStyle(
                        color: const Color(0xff2D475F),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(const ClipboardData(text: "779508994"))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم نسخ رقم الحساب'),
                          ),
                        );
                      });
                    },
                    child: Icon(
                      Icons.copy,
                      size: 18.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                thickness: 2.0,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    'رقم حساب بنك القطيبي:',
                    style: TextStyle(
                        color: const Color(0xff2D475F),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '280170237',
                    style: TextStyle(
                        color: const Color(0xff2D475F),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(const ClipboardData(text: "280170237"))
                          .then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم نسخ رقم الحساب'),
                          ),
                        );
                      });
                    },
                    child: Icon(
                      Icons.copy,
                      size: 18.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              const Divider(
                thickness: 2.0,
              ),
              SizedBox(
                height: 10.h,
              ),
              Spacer(),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  CardCategoriesScreen(),
                    ),
                  );
                },
                child: Container(
                  //  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  height: 55.h,
                  //  width: ,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Color(0xff2D475F),
                          Color(0xff3AA8F2),
                        ]),
                  ),
                  child: const Center(
                    child: Text(
                      'عرض فئات الاشتراك',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
