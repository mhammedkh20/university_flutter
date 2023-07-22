import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:university_app/utils/constants.dart';

import '../controllers/auth_api_controller.dart';
import '../widgets/app_bar.dart';
import '../widgets/app_text_field.dart';
import '../widgets/downloading_widget.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late TextEditingController _email;

  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }
  bool _isFutureExecuting = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/bc.png'), fit: BoxFit.cover),
      ),
      child: WillPopScope(
        onWillPop: () async {
          if (_isFutureExecuting) {
            return false;
          }
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const CustomAppBar(
            title: 'تأكيد الحساب',
          ),
          body: ListView(
            padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
            shrinkWrap: true,
            children: [
              Text(
                'أدخل البريد الالكتروني',
                style: AppUtils.h1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '1) الرجاء ادخال البريد الالكتروني لارسال كلمة مرور جديدة''\n'"2) قم بالتوجه الى بريدك الالكتروني لمعرفة كلمة المرور الجديدة",
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  margin: const EdgeInsets.only(right: 50, left: 50),
                  child: AppTextField(hint: ' الايميل ', controller: _email)),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async{
                      setState(() {
                        _isFutureExecuting = true;
                      });
                      showDialog(context: context, builder: (_)=> DownloadingWidget());
                      bool status = await AuthApiController().forgotPassword(
                        context,
                        email: _email.text,
                      );
                      _isFutureExecuting = false;
                      if (status) {
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      "ارسال",
                      style: AppUtils.h3White.copyWith(color: Colors.blue),
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
