import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:university_app/controllers/home_api_controller.dart';
import 'package:university_app/screens/card_categories_screen.dart';
import 'package:university_app/screens/distribution_points.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../models/success_code.dart';

class CardCodeScreen extends StatelessWidget {
  CardCodeScreen({Key? key}) : super(key: key);

  launchWhatsApp() async {
    const link = WhatsAppUnilink(
      phoneNumber: '+967735090373',
      text: "Hey! I want to complete register to the app",
    );

    await launch('$link');
  }
  TextEditingController codeController =TextEditingController();

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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                'يرجى ادخال كود البطاقة',
                style: TextStyle(fontSize: 20.sp, color: Color(0xff2D475F),fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50.h,
                child: TextFormField(
                  controller: codeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Color(0xff2D475F)),
                    ),
                    labelText: 'أدخل كود البطاقة',
                  ),
                ),
              ),
              SizedBox(height: 5.h,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: (){
                     HomeApiController().chargeUserCard(codeController.text.toString(),context);

                }, child: const Text("تحقق من الكود"),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff2D475F),
                  ),

                ),
              ),
              SizedBox(
                height: 70.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  DistributionPoints(),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                Color(0xff2D475F),
                                Color(0xff3AA8F2),
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.business,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "نقاط البيع",
                          style: TextStyle(
                            color: const Color(0xff2D475F),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  CardCategoriesScreen(),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                Color(0xff2D475F),
                                Color(0xff3AA8F2),
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.category,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "فئات الكروت",
                          style: TextStyle(
                            color: const Color(0xff2D475F),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  InkWell(
                    onTap: () {
                      launchWhatsApp();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                Color(0xff2D475F),
                                Color(0xff3AA8F2),
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.chat,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "خدمة العملاء",
                          style: TextStyle(
                            color: const Color(0xff2D475F),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
