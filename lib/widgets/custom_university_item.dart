import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:university_app/screens/univ_department.dart';
import 'package:university_app/theme/my_colors.dart';
import 'package:university_app/utils/constants.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/mode.dart';
import 'dart:math'as math;

class CustomUnivItem extends StatelessWidget {
  //final String nameEN;
  final String nameAR;
  final String imagePath;

  const CustomUnivItem({Key? key,
    required this.nameAR,
    // required this.nameEN,
    required this.imagePath,
    })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color =context.watch<SettingsModel>().isDark?colorPrimaryD:Colors.white;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(right:35 ),
          width: double.infinity,
          alignment: Alignment.center,
          height: 90,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(nameAR, style: AppUtils.h2),
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:Radius.circular(10) ,topRight:Radius.circular(30) ,bottomRight:Radius.circular(30) ),
            color: color,
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            height: 90,
            width: 90,
            decoration:  BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 20,
                      offset: Offset(1, 3)

                  )
                ],
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: CachedNetworkImageProvider(
                    imagePath,
                  ),)
            ),
          ),
        ),
        Positioned(
            top: 20.h,
            left: -20,
            bottom: 20.h,
            child: Container(
              padding: const EdgeInsets.only(left: 15,right: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],

              ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.blue,
                  ),
                ),
            )
        ),
      ],
    );
  }
}
