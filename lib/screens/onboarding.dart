import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:university_app/prefs/shared_prefs_controller.dart';

import '../widgets/onboarding.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController controller = PageController();
  late int pageCount;
  static const int duration = 500;

  @override
  void initState() {
    pageCount = 7;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // set the status bar color
        statusBarBrightness: Brightness.dark, // set the status bar brightness
        statusBarIconBrightness: Brightness.dark));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  OnBoardingBody body(int index,bool isPortrait){
    switch (index) {
      case 0:
        {
          return OnBoardingBody(
            text:
                'يمكنك الاشتراك عن طريق عن طريق الإيداع في حساباتنا الموجودة في الخيارات مع ارفاق السند لخدمة العملاء أو عن طريق الدفع عبر المحافظ الالكترونية ومنها محفظة كاش',
            imagePath: 'images/onboarding/1.svg',
            isPortrait: isPortrait,
          );
        }
      case 1:
        {
          return OnBoardingBody(
            text:
            'كما يمكنك الاشتراك عن طريق شراء كروت تعبئة موجودة لدى نقاط بيعنا القريبة منك وتعبئة كرتك لكي تصل الى محتوى ضخم وثري ومتجدد',
            imagePath: 'images/onboarding/2.svg',
            isPortrait: isPortrait,
          );
        }
      case 2:
        {
          return OnBoardingBody(
            text:
                'تطبيق موسوعتي الجامعية وهو تطبيق يضم كل ما يفيد الطالب الجامعي من شروحات وكتب ومراجع ومحاضرات سواء كانت صوت أو فيديو والكثير الكثير فيما يخص كل الجامعات اليمنية',
            imagePath: 'images/onboarding/3.svg',
            isPortrait: isPortrait,
          );
        }
      case 3:
        {
          return OnBoardingBody(
            text:
                'تصميم بسيط وجذاب يساعدك على الوصول لكل ما تحتاجه بدون تشتت او توهان وبكل سهولة وبعدة نقرات تصل لمكتبات تخصصك التي تبحث عنها',
            imagePath: 'images/onboarding/4.svg',
            isPortrait: isPortrait,
          );
        }
      case 4:
        {
          return OnBoardingBody(
            text:
                'يمكنك حفظ الملفات والمسافات التي تريدها عن طريق خانة المحفوظات ستتمكن من الوصول الى ملفاتك بسهولة دون الحاجة للوصول الى الانترنت',
            imagePath: 'images/onboarding/5.svg',
            isPortrait: isPortrait,
          );
        }
      case 5:
        {
          return OnBoardingBody(
            text:
                'في حالة عدم فهمك للمحاضرات يمكنك الرجوع للتطبيق ويتجد ضالتك بسهولة دون تشتت او توهان',
            imagePath: 'images/onboarding/6.svg',
            isPortrait: isPortrait,
          );
        }
        case 6:
        {
          return OnBoardingBody(
            text:
                'ماذا تنتظر الآن سجل واشترك',
            imagePath: 'images/onboarding/7.svg',
            isPortrait: isPortrait,
          );
        }

    }
    return OnBoardingBody(
      text:
      'في حالة عدم فهمك للمحاضرات يمكنك الرجوع للتطبيق ويتجد ضالتك بسهولة دون تشتت او توهان',
      imagePath: 'images/onboarding/6.svg',
      isPortrait: isPortrait,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 0.15.sh),
                child: OrientationBuilder(
                  builder: (BuildContext context, Orientation orientation) {
                    bool isPortrait = orientation == Orientation.portrait;
                    return PageView.builder(
                      itemCount: pageCount,
                      controller: controller,
                      itemBuilder: (BuildContext context, int index) {
                       return body(index,isPortrait);
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SmoothPageIndicator(
              controller: controller,
              count: pageCount,
              effect: const WormEffect(
                  spacing: 2,
                  dotColor: Color(0xffADADAD),
                  dotHeight: 6,
                  dotWidth: 6,
                  activeDotColor: Color(0xff3AA8F2)),
              onDotClicked: (index) => controller.animateToPage(
                index,
                duration: const Duration(milliseconds: duration),
                curve: Curves.easeInOut,
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                  top: 0.04.sh, bottom: 0.075.sh, right: 20, left: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xff39A5EE),
                    Color(0xff3496D8),
                    Color(0xff2B7BB1),
                    Color(0xff1D5377),
                  ],
                ),
              ),
              child: TextButton(
                onPressed: () async {
                  SharedPrefController().setShowHome(true);
                  Navigator.pushReplacementNamed(context, '/sign_in');
                },
                child: Text(
                  'لنبدأ !',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Droid',
                      fontSize: 16.spMin,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
