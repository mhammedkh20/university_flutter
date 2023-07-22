import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:university_app/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  launchWhatsApp() async {
    const link = WhatsAppUnilink(
      phoneNumber: '+967718492367',
     // text: "Hey! I want to complete register to the app",
    );
    // The "launch" method is part of "url_launcher".
    await launch('$link');
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // backgroundColor: Colors.white,
        // appBar: AppBar(
        //     elevation: 0,
        //     backgroundColor: Colors.transparent,
        //     title: const Text(
        //       'About',
        //       style: TextStyle(
        //           color: Colors.black,
        //           fontFamily: 'Poppins',
        //           fontSize: 22,
        //           fontWeight: FontWeight.w700),
        //     ),
        //     leading: GestureDetector(
        //         onTap: () {
        //           Navigator.pop(context);
        //         },
        //         child: const Icon(
        //           Icons.arrow_back_ios,
        //           color: Colors.black,
        //         )),
        //   ),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'عن التطبيق',
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
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: ListView(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                SvgPicture.asset(
                  'images/logo.svg',
                  height: 180.h,
                  width: 70,
                ),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'تطبيق موسوعتي الجامعيه هوه تطبيق يضم كل ما يفيد الطالب الجامعي من شروحات وكتب ومراجع ومحاضرات سواء كانت صوت او فيديو بالاضافه الى نماذج للأمتحانات فيما يخص كل الجامعات و المعاهد الموجوده في اليمن',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // color: Colors.black45,
                      fontFamily: 'Droid',
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('خدمة العملاء التطبيق عبر واتس اب'),
                        GestureDetector(
                          onTap: () {
                            launchWhatsApp();
                          },
                          child: SvgPicture.asset(
                            'images/whatsapp.svg',
                            height: 30.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                )

                /*const Center(
              child: Text('عن الشركة',textAlign: TextAlign.right, style: TextStyle(color: Colors.black , fontFamily: 'Droid' , fontWeight: FontWeight.bold , fontSize: 18)
              ),
            ),
             Image.asset('images/company.png', height: 100),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(' DRAGON SOFT BLACK شركة   \n وهي شركة مختصة في مجال الاتصالات والبرمجة وأنظمة الطاقة البديلة موقعها الرسمي في اليمن', textAlign: TextAlign.right,style: TextStyle(color: Colors.black45, fontFamily: 'Droid', fontSize: 15),),
            )*/
              ],
            )),
//
      ),
    );
  }
}
