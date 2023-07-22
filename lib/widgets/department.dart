import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:university_app/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/mode.dart';
import '../theme/my_colors.dart';
class Department extends StatelessWidget {
  final String title;
  final int paddingWidth;
  final int paddingHeight;

  const Department({Key? key, required this.title, required this.paddingWidth, required this.paddingHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color =context.watch<SettingsModel>().isDark?colorPrimaryD:Color(AppUtils.blueColor);
    Color iconColor =context.watch<SettingsModel>().isDark?colorPrimaryD:Colors.white;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding:  EdgeInsets.symmetric(vertical: 20.h,),
          margin: const EdgeInsets.only(bottom: 20),
          // width: 330.w,
          // height: 67.h,
          child: Center(
            child: Text(
                title,
                style:TextStyle(fontFamily: 'Droid' , fontSize: 18.spMin, fontWeight: FontWeight.bold , color: Colors.white)
            ),
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(15),
                topLeft: Radius.circular(30)),
            color: color,
          ),
        ),
        Positioned(
          left: -paddingWidth.w,
          top: paddingHeight.h,
          child: Container(
            padding: EdgeInsets.only(left: 5,right: 10,top: 5,bottom: 5),
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: Color(AppUtils.blueColor),
            ),
          ),
        ),
      ],
    );
  }
}
