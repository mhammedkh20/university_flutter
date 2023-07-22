import 'package:flutter/material.dart';
import 'package:university_app/utils/constants.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.hint,
    required this.controller,
   this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  }) : super(key: key);

  final String hint;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final TextEditingController controller;
 
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
     
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppUtils.h3,
            suffixIcon: suffixIcon,
            enabledBorder: border(),
           // focusedBorder: border(borderColor: Colors.black)
        ),
      ),
    );
  }

  UnderlineInputBorder border({Color borderColor = Colors.white}) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: borderColor,
        width: 1,
      ),
     // borderRadius: BorderRadius.circular(10),
    );
  }
}
