import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:university_app/screens/account_numbers.dart';
import 'package:university_app/screens/card_categories_screen.dart';
import 'package:university_app/screens/card_code_screen.dart';

class PaymentsWaysScreen extends StatelessWidget {
  const PaymentsWaysScreen({Key? key}) : super(key: key);

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
            'طرق الدفع',
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
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 50.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  "اختر طريقة الدفع التي تناسبك",
                  style: TextStyle(fontSize: 20.sp, color: Color(0xff2D475F)),
                ),
                Text(
                  "لتتمتع بكافة مزايا التطبيق",
                  style: TextStyle(fontSize: 16.sp, color: Color(0xff2D475F)),
                ),
                const Text(
                  "نتمنى لك تجربة سعيدة",
                  style: TextStyle(color: Color(0xff3AA8F2)),
                ),
                SizedBox(
                  height: 100.h,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  AccountNumbers(),
                      ),
                    );
                  },
                  child: Container(
                    //  padding: EdgeInsets.symmetric(horizontal: 50.w),
                    height: 55,
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
                        'حوالة بنكية',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  CardCodeScreen(),
                      ),
                    );
                  },
                  child: Container(
                    //  padding: EdgeInsets.symmetric(horizontal: 50.w),
                    height: 55,
                    //  width: ,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
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
                        'شحن رصيد',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      //  padding: EdgeInsets.symmetric(horizontal: 50.w),
                      height: 55,
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
                      child: Center(
                          child: Text(
                        'دفع اونلاين',
                        style: TextStyle(color: Colors.white),
                      ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
