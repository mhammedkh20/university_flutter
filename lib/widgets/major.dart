import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:university_app/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/mode.dart';
import '../theme/my_colors.dart';

class MajorWidget extends StatelessWidget {
  final String title;

  const MajorWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color =context.watch<SettingsModel>().isDark?colorPrimaryD:Colors.white;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
            border: Border.all(
              width: 1,
              color: Color(AppUtils.blueColor),
            ),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
          ),
          // height: MediaQuery.of(context).size.height / 5,
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontFamily: 'Droid' , fontSize: 15.spMin, fontWeight: FontWeight.bold , color: Colors.blue),
            ),
          ),
        ),
        /*Positioned(
          left: MediaQuery.of(context).size.width / 6,
          right: MediaQuery.of(context).size.width / 6,
          bottom: MediaQuery.of(context).size.height / 30,
          child: CircleAvatar(
            maxRadius: 20,
            backgroundColor: Color(AppUtils.blueColor),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 15,
              color: Colors.white,
            ),
          ),
        ),*/
      ],
    );
  }
}
