import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtonDetailsScreen extends StatelessWidget {
  CustomButtonDetailsScreen(
      {Key? key, required this.color, required this.text, required this.image})
      : super(key: key);

  Color color;
  String image;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: Row(
        children: [
          Expanded(child: SizedBox(height: 45.h, child: Image.asset(image))),
          Expanded(
              child: Text(
            text,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
              color: Colors.black,
            ),
          )),
          Spacer(),
        ],
      ),
    );
  }
}
