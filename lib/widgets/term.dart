import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../controllers/mode.dart';
import '../theme/my_colors.dart';

class TermWidget extends StatelessWidget {
  final String name;

  const TermWidget({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color =context.watch<SettingsModel>().isDark?colorPrimaryD:Colors.white;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Container(

            padding:EdgeInsets.symmetric(horizontal: 10.w,) ,
            // width: 380.w,
            alignment: Alignment.center,
            height: 100.h,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style:  TextStyle(
                  color: Colors.blue,
                  fontSize: 22.spMin,
                  fontFamily: 'Droid',
                  fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
                boxShadow:  [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 10,
                      offset: Offset(1, 3)

                  )
                ],
              borderRadius: BorderRadius.circular(15),
              color: color,
            ),
          ),
        ),
        Positioned(
          top: 20.h,
          left: 15.w,
          bottom: 20.h,
          child: CircleAvatar(
            maxRadius: 20,
            backgroundColor: color,
            child: Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
