import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:university_app/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/mode.dart';
import '../theme/my_colors.dart';
class UnivDepartmentWidget extends StatelessWidget {

 // final String imagePath ; 
  final String title ; 

  const UnivDepartmentWidget({ Key? key  , required this.title ,
  // required this.imagePath
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color =context.watch<SettingsModel>().isDark?colorPrimaryD:Color(AppUtils.blueColor);
    return Stack(
      
      clipBehavior: Clip.none,
      children: [

        Container(
         
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
            color: color,
            border: Border.all(
              width: 1,
              color: color,
            ),
              borderRadius: const BorderRadius.only(
                  
                  topRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0)), ),
        /*  width: 170.w,*/
          // height: 145.h,
          child: Center(
            child: Text(
              title,
              style:  TextStyle(fontFamily: 'Droid' , fontSize: 18.spMin, fontWeight: FontWeight.bold , color: Colors.white),
            ),
          ),
        ),
       
        //  Positioned(
        //   top:-20.h,
          
        //  left: 50.w,
        //   child: Image.network(imagePath,
        //    width: 80.w , height: 80.h,)), 
    
        //  Positioned(
        //   left: 65.w,
        //   bottom: 27.h,
        //   child: CircleAvatar(
        //     maxRadius: 20,
        //     backgroundColor: Colors.white,
        //     child: Icon(
        //       Icons.arrow_back_ios,
        //       size: 20,
        //       color: Color(AppUtils.blueColor),
        //     ),
        //   ),
        // ),
      ],
    );

















  
  }
}