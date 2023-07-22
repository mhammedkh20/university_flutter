import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class AboutFirmScreen extends StatefulWidget {
  const AboutFirmScreen({Key? key}) : super(key: key);

  @override
  State<AboutFirmScreen> createState() => _AboutFirmScreenState();
}

class _AboutFirmScreenState extends State<AboutFirmScreen> {
  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+967780033443',
   //   text: "Hey! I want to complete register to the app",
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
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'عن الشركة',
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
        body: Container(
          //    margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListView(
            children: [
              Image.asset(
                'images/company.png',
                height: 320.h,
              ),
              const Padding(
                padding: EdgeInsets.all(0.0),
                child: Text(
                  ' DRAGON SOFT BLACK شركة   \n وهي شركة مختصة في مجال الاتصالات والبرمجة وأنظمة الطاقة البديلة موقعها الرسمي في اليمن',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // color: Colors.black45,
                    fontFamily: 'Droid',
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('خدمة العملاء عبر واتس اب'),
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
            ],
          ),
        ),
      ),
    );
  }
}
