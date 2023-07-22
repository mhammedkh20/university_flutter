import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingBody extends StatelessWidget {
   OnBoardingBody({Key? key, required this.text, required this.imagePath,  required this.isPortrait}) : super(key: key);
  final String text;
  final String imagePath;
    final bool isPortrait;


  @override
  Widget build(BuildContext context) {
    Widget image= SvgPicture.asset(imagePath,fit: BoxFit.cover,height:isPortrait?0.39.sh:0.39.sw ,width:isPortrait? 0.39.sh:0.39.sw,);
    Widget sizeBox= SizedBox(height:isPortrait? 0.075.sh:0.075.sw,);
    Widget textWidget= Padding(
      padding:  EdgeInsets.symmetric(horizontal: isPortrait?30:0,vertical: isPortrait?0:30),
      child: Text(
        text,
        textDirection: TextDirection.rtl,
        style: TextStyle(fontFamily: 'Droid',fontSize: 16.spMin,color: const Color(0xff2C3E50)),
      ),
    );
    return SingleChildScrollView(
      child: isPortrait?Column(
        children: [
          image,
          sizeBox,
          textWidget,
        ],
      ) :Row(
        children: [
          image,
          sizeBox,
          Expanded(child: textWidget)

        ],
      )
    );
  }
}
