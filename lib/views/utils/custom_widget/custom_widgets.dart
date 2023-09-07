import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../colors.dart';

class CustomWidgets {
  static customTextField(
      {required String hintText, required TextEditingController controller}) {
    return Container(
      padding: EdgeInsets.only(left: 10.sp),
      height: 50.h,
      width: 340.w,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15.r),
        gradient: LinearGradient(
            colors: [
              const Color(0xFFC7CEF1),
              const Color(0xFF8C9BE3),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.1, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.acme(color: Colors.black, fontSize: 13.sp),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black, fontSize: 13.sp),
          border: InputBorder.none,
        ),
        cursorColor: kPrimaryColor,
        // decoration: textFieldIconDecoration(
        //     Icons.alternate_email, 'service@gmail.com', null),
      ),
    );
  }

  static customText({required TextStyle fonts, required String text}) {
    return Text(
      text,
      style: fonts,
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

  static customButton(String text) {
    return Container(
      height: 45.h,
      width: 340.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.sp),
        color: kPrimaryColor,
      ),
      child: Center(
          child: Text(
        text,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 16.h,
          fontWeight: FontWeight.w500,
        ),
      )),
    );
  }

  static loadingIndicator() {
    return Center(
        child: LoadingAnimationWidget.fallingDot(
      color: kPrimaryColor,
      size: 50.sp,
    ));
  }

  static style() {
    return GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
  }
}
