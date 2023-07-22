import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class NoCacheFound extends StatelessWidget {
  final String resType;
  const NoCacheFound({Key? key, required this.resType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'images/nodata.jpg',
          height: 250.h,
          width: 250.w,
        ),
         Center(
          child: Text(
            ' لا يوجد $resType محفوظة ',
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        )
      ],
    );;
  }
}
