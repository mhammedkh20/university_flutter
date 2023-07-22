import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controllers/home_api_controller.dart';

class FileSize extends StatelessWidget {
   const FileSize({Key? key, required this.size}) : super(key: key);
   final String size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Text(
              size,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: const Color(0xff377198),
                fontSize: 12.spMin,
                fontFamily: 'Droid',
                fontWeight: FontWeight.w200,
                overflow: TextOverflow.ellipsis
              ),

            ),
          ),
          const Icon(
            Icons.download,
            color: Color(0xff377198),
            size: 12,
          ),
        ],
      ),
    );
  }
}
class FixedFileSize extends StatelessWidget {
   const FixedFileSize({Key? key, required this.size}) : super(key: key);
   final String size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          size,
          textDirection: TextDirection.ltr,
          style: TextStyle(
            color: const Color(0xff377198),
            fontSize: 12.spMin,
            fontFamily: 'Droid',
            fontWeight: FontWeight.w200,
            overflow: TextOverflow.ellipsis
          ),

        ),
        const Icon(
          Icons.download,
          color: Color(0xff377198),
          size: 12,
        ),
      ],
    );
  }
}
