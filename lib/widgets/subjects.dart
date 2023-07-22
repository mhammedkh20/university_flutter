import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../controllers/mode.dart';
import '../theme/my_colors.dart';

class SubjectsWidget extends StatelessWidget {
  final String title;
  final String imagepath;

  const SubjectsWidget({Key? key, required this.title, required this.imagepath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color =context.watch<SettingsModel>().isDark?colorPrimaryD:Colors.white;

    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          width: 1,
          color: color,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      // width: 170.w,
      // height: 174.h,
      child: Column(
        //  mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(imagepath,height: 80.h,),
          Text(
            title,
            style: TextStyle(
                color: const Color(0xff377198),
                fontSize: 13.spMin,
                fontFamily: 'Droid',
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
