import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:university_app/controllers/api_helper.dart';
import 'package:university_app/controllers/auth_api_controller.dart';
import 'package:university_app/utils/constants.dart';
import 'package:university_app/widgets/app_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with ApiHelper {
  bool obsecuretext = true;

  late TextEditingController _email;

  late TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bc.png'), fit: BoxFit.cover),
          // gradient: LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     colors: [Color(0x3AA8F2),Color(0x2C3E50)]
          //     )
        ),
        child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            bool isPortrait = orientation == Orientation.portrait;
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100.h,
                    ),
                    SvgPicture.asset('images/logo.svg',
                        height: isPortrait ? 70.h : 70.w,
                        width: isPortrait ? 70.w : 70.h),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(' موسوعتي الجامعية', style: AppUtils.h3White),
                    SizedBox(
                      height: 80.h,
                    ),
                    Container(
                        margin: const EdgeInsets.only(right: 50, left: 50),
                        child: AppTextField(
                            hint: ' الايميل ', controller: _email)),
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 50, left: 50),
                      child: AppTextField(
                        hint: 'كلمة السر  ',
                        controller: _password,
                        obscureText: obsecuretext,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obsecuretext = !obsecuretext;
                            });
                          },
                          child: Icon(obsecuretext
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 50, left: 50, top: 10),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/forget_password');
                            },
                            child: Text(
                              'نسيت كلمة المرور ؟',
                              style: AppUtils.h3,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/SignUp');
                        },
                        child: Text(
                          'ليس لدي حساب , إنشاء حساب ',
                          style: AppUtils.h3,
                        ))
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startFloat,
              floatingActionButton: InkWell(
                onTap: () async {
                  await performLogin();
                },
                child: Container(
                  height: isPortrait ? 0.1.sh : 0.1.sw,
                  width: isPortrait ? 0.1.sh : 0.1.sw,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xff3AA8F2), Color(0xff2D475F)]),
                      borderRadius: BorderRadius.circular(100)),
                  child: Text(
                    'تسجيل' + '\n' + 'الدخول',
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12.spMin,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Droid',
                        color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ));
  }

  // Padding(
  // padding: EdgeInsets.only(bottom: 10.h),
  // child: Container(
  // height: 70,
  // width: 70,
  // alignment: Alignment.center,
  // decoration: BoxDecoration(
  // gradient: const LinearGradient(
  // colors: [Color(0xff3AA8F2), Color(0xff2D475F)]),
  // borderRadius: BorderRadius.circular(100)
  // //more than 50% of width makes circle
  // ),
  // child: InkWell(
  // onTap: () async {
  // await performLogin();
  // // Navigator.pushNamed(context, '/univ_screen');
  // },
  // child:  Text(
  // 'تسجيل الدخول\n',
  // textAlign: TextAlign.center,
  // style: TextStyle(
  // fontSize: 12.sp,
  // fontWeight: FontWeight.bold,
  // fontFamily: 'Droid',
  // color: Colors.white),
  // ),
  // ),
  // ),
  // )
  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
      context,
      message: 'من فضلك, أدخل البيانات المطلوبة',
      error: true,
    );
    return false;
  }

  Future<void> login() async {
    bool status = await AuthApiController().login(
      context,
      email: _email.text,
      password: _password.text,
    );
    if (status) Navigator.pushReplacementNamed(context, '/univ_screen');
  }
}
