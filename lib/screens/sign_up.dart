import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:university_app/controllers/api_helper.dart';
import 'package:university_app/controllers/auth_api_controller.dart';
import 'package:university_app/models/register_user.dart';
import 'package:university_app/utils/constants.dart';
import 'package:university_app/widgets/app_text_field.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class SignUp extends StatefulWidget {
  const SignUp({ Key? key }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with ApiHelper {
  bool obsecuretext = true;
  late TextEditingController _name ; 
   late TextEditingController _email ;
    late TextEditingController _password ; 
    late TextEditingController _phone; 
    launchWhatsApp() async {
  final link = WhatsAppUnilink(
    phoneNumber: '+967735090373',
    text: "Hey! I want to complete register to the app",
  );
  // Convert the WhatsAppUnilink instance to a string.
  // Use either Dart's string interpolation or the toString() method.
  // The "launch" method is part of "url_launcher".
  await launch('$link');
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _name= TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _phone = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _phone.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  const BoxDecoration(
         image: DecorationImage(image: AssetImage('images/bc.png',   ), fit: BoxFit.cover),
          // gradient: LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     colors: [Color(0x3AA8F2),Color(0x2C3E50)]
          //     )
              ),
    
      child: Scaffold(
       
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          
          child: Column(children: [
           
            SizedBox(height: 100.h,),
            SvgPicture.asset('images/logo.svg', height: 70.h, width: 70.w),
                 SizedBox(height: 10.h,),
                 Text(' موسوعتي الجامعية', style: AppUtils.h3White),
                
                
                
                
                 Container(
                   margin: const EdgeInsets.only(right: 50 , left: 50),
                   child: AppTextField(hint: 'اسم الطالب', controller: _name)), 
                 Container(
                    margin: const EdgeInsets.only(right: 50 , left: 50),
                   child: AppTextField(hint: 'رقم الجوال  ', keyboardType: TextInputType.number,controller: _phone)),
                   Container(
                    margin: const EdgeInsets.only(right: 50 , left: 50),
                   child: AppTextField(hint: 'الإيميل ', controller: _email)),
                  Container(
                     margin: const EdgeInsets.only(right: 50 , left: 50),
                    child: AppTextField(hint: 'كلمة السر  ', controller: _password,obscureText: obsecuretext,
                    suffixIcon: GestureDetector(onTap: (){
                     setState(() {
                       obsecuretext = !obsecuretext;
                     });
              },
              child: Icon(obsecuretext ? Icons.visibility : Icons.visibility_off),
              ),
                    )), 
                
                
                    SizedBox(height: 40.h,),
                    Text('إكمال عملية التسجيل من خلال الواتسآب' ,textAlign: TextAlign.center ,style:AppUtils.h3White),
                    SizedBox(height: 15.h,),
                    GestureDetector(
                      onTap: (){
                   launchWhatsApp();
                      },
                      child: SvgPicture.asset('images/whatsapp.svg')),
                    SizedBox(height: 10.h,),
                    TextButton(onPressed: (){
                       Navigator.pushNamed(context, '/sign_in');
                    }, child: Text('لدي حساب بالفعل, تسجيل دخول ',style:AppUtils.h3 ,)),


                    // TextButton(onPressed: (){
                    //    Navigator.pushNamed(context, '/how_to_register');
                    // }, child: Text('لمعرفة كيفية التسجيل , اضغط هنا ',style:AppUtils.h3 ,)),

                
          ],),
          
        ),
         floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        floatingActionButton: Padding(
          padding:  EdgeInsets.only(right:20.w , bottom: 10.h),
          child: Container( 
            height:90.h,
      width: 90.w,
      decoration: BoxDecoration(
      gradient:const LinearGradient(colors: [Color(0xff3AA8F2),Color(0xff2D475F)]),
     
        borderRadius: BorderRadius.circular(100) 
        //more than 50% of width makes circle
      ),
            child: InkWell(
              onTap: () async{
                 //Navigator.pushNamed(context, '/sign_in');
                 await performRegister();
              },
              child: Container(
            
               
                child:  Center(child: Text('تسجيل', style: TextStyle(fontSize: 16.sp , fontWeight: FontWeight.bold , fontFamily: 'Droid',color: Colors.white),)),
               
                ),
            ),
          ),
        ),
      ),
    );
  }


  Future<void> performRegister() async{
    if(checkData()){
      await register();
    }
  } 

  bool checkData(){
    if(_phone.text.isNotEmpty && _email.text.isNotEmpty && _password.text.isNotEmpty && _name.text.isNotEmpty){
      return true;
    }
    showSnackBar(
      context,
      message: 
      'من فضلك, أدخل البيانات المطلوبة',
      error: true,
    );
    return false;
  }

  Future<void> register()async{
    bool status = await AuthApiController().register(context, user: user);
    if(status) {
       showSnackBar(context, message:'تم انشاء الحساب بنجاح' );
       Navigator.pushNamed(context, '/sign_in');
    }

  }


  User get user {
    User user = User();
    user.name = _name.text;
    user.email = _email.text;
    user.password = _password.text;
    user.phone = _phone.text;


    return user; 
  }
}