
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:university_app/cache/cache_settIngs.dart';
import 'package:university_app/cache/controller/hive_provider.dart';
import 'package:university_app/controllers/mode.dart';
import 'package:university_app/screens/about_firm_screen.dart';


import 'package:university_app/screens/card_categories_screen.dart';
import 'package:university_app/screens/distribution_points.dart';
import 'package:university_app/screens/forget_password.dart';
import 'package:university_app/screens/how_to_register.dart';
import 'package:university_app/screens/info_screen.dart';
import 'package:university_app/screens/onboarding.dart';
import 'package:university_app/screens/payments_ways_screen.dart';
import 'package:university_app/screens/saves_screen.dart';
import 'package:university_app/screens/search_screen.dart';
import 'package:university_app/screens/sign_in.dart';
import 'package:university_app/screens/splash_screen.dart';
import 'package:university_app/screens/univ_screen.dart';

import 'cache/hive_functions/hive_functions.dart';
import 'prefs/shared_prefs_controller.dart';
import 'screens/sign_up.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPref();
  await boxesInit();
  await createBoxDir(CacheSettings.randomPath);

  bool? isDark = SharedPrefController().isDark;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_)=>SettingsModel()..changeMode(fromShared: isDark),
        ),
        ChangeNotifierProvider(
          create: (_)=>HiveProvider()
        ),
      ],
        child: const MyApp()
    )
    
    );
}




class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(375 ,812),
        builder: (context , child) {

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/splash_screen',
            darkTheme: ThemeData.dark(
            ),
            themeMode: context.watch<SettingsModel>().isDark?ThemeMode.dark:ThemeMode.light,
            routes: {
              '/splash_screen':(context)=>const SplashScreen(),
              '/SignUp':(context)=> const SignUp(),
              '/sign_in':((context) => const SignIn()),
              '/univ_screen'  :(context)=> const UniversitiesScreen(),
              '/info':(context)=> const Info(),
              '/how_to_register':(context) => HowToRegister(),
              '/company':(context)=>AboutFirmScreen(),
              '/search':(context)=>SearchScreen(),
              '/pay_ways':(context)=>PaymentsWaysScreen(),
              '/card_category':(context)=>CardCategoriesScreen(),
              '/point':(context)=>DistributionPoints(),
              '/saves_screen':(context)=>SavesScreen(),
              '/forget_password':(context)=>ForgetPassword(),
              '/onboarding':(_)=>OnBoarding()
              //  '/univ_department':(context)=> const UnivDepartment(),
              // '/department_screen' : (context)=> const DepartmentScreen(),
              // '/major_screen' :((context) => const MajorScreen()),
              //  '/term_screen':(context)=>const TermScreen(),
              //  '/subject_screen' : ((context) => const SubjectScreen()),
              //  '/subjects_screen':(context)=>const SubjectsScreens(),
              // '/books_screen':(context)=>const BooksScreen(),
              // '/summary_screen':(context)=> const SummaryScreen(),
              // '/forms_screen':(context)=> const FormsScreen()     ,
              // '/links_screen':(context)=> const Links()  ,
              // '/VideosScreen' :(context)=> const VideosScreen() ,
              // '/voiceScreen':(context)=> const Voice()


            },
          );
        }
    );
      

      
    
  }
}
