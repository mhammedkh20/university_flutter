import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../controllers/mode.dart';
import '../theme/my_colors.dart';
import '../utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectWidget extends StatelessWidget {
  final String imagepath;
  final String title;

  const SubjectWidget({
    Key? key,
    required this.title,
    required this.imagepath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color =context.watch<SettingsModel>().isDark?colorPrimaryD:Colors.white;

    return Container(

      padding: EdgeInsets.only(top: 10.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius:  BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Image.asset(imagepath,)),
          const SizedBox(height: 5,),
          Container(
            width: double.infinity,
            // height: 45.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(AppUtils.blueColor),
            ),
            child: Container(
              padding:  EdgeInsets.symmetric(vertical: 5.h),
              alignment: Alignment.center,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.spMin,
                  fontFamily: 'Droid',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
