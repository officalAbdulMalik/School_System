import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContinerDecoration {
  static continerDecoration() {
    return BoxDecoration(
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
            tileMode: TileMode.clamp));
  }
}
