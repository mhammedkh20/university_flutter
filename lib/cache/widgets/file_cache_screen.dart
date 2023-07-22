
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class FileCacheScreen extends StatelessWidget {
  final Widget cacheBody;
  const FileCacheScreen({Key? key, required this.cacheBody}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body:cacheBody,
      ),
    );
  }

}



