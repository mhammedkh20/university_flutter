import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteAllButton extends StatelessWidget {
  final VoidCallback onTapDeleteAll;
  const DeleteAllButton({Key? key, required this.onTapDeleteAll}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  bool isPortrait = MediaQuery.of(context).orientation==Orientation.portrait;
    return FloatingActionButton(
      backgroundColor: Colors.transparent,
        hoverColor: Colors.white.withOpacity(0.1),
        onPressed:onTapDeleteAll,
        child: Container(
            height: isPortrait? 90.h:90.w,
            width: isPortrait?90.h:90.w,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xff3AA8F2), Color(0xff2D475F)]),
                borderRadius: BorderRadius.circular(100)
              //more than 50% of width makes circle
            ),
            child: const Icon(Icons.delete)
        ));
  }
}
