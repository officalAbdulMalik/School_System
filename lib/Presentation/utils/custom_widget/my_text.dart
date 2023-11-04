import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final Color? color;
  final double? letterSpacing;
  final TextOverflow? overflow;
  final int? maxLines;

  const MyText(
    this.text, {
    Key? key,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.letterSpacing,
    this.textAlign,
    this.fontSize,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize ?? 12.sp,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        color: color,
      ),
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
