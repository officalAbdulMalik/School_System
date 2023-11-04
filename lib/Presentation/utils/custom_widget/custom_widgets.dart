import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../colors.dart';

class CustomWidgets {
  static errorText(String error) {
    return Center(
      child: Text(
        error,
        style: GoogleFonts.acme(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  static textStyle(
      {required Color color,
      required double size,
      required FontWeight weight}) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: size,
      fontWeight: weight,
    );
  }

  static customButton(String text,
      {Color? buttonColor, double? fontSize, int? hight}) {
    return Container(
      margin: EdgeInsets.only(top: 10.sp),
      height: 45.h,
      width: 340.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.sp),
        color: buttonColor ?? kPrimaryColor,
      ),
      child: Center(
          child: Text(
        text,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: fontSize ?? 16.h,
          fontWeight: FontWeight.w500,
        ),
      )),
    );
  }

  static style() {
    return GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
  }
}
