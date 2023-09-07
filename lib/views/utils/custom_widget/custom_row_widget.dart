import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/views/utils/colors.dart';

class CustomRowWidget extends StatelessWidget {
  String text1;
  String text2;
  int? size;
  String? image;
  CustomRowWidget(
      {Key? key,
      required this.text1,
      required this.text2,
      this.size,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                  text: text1,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                  children: [
                    TextSpan(
                      text: '\n$text2',
                      style: GoogleFonts.poppins(
                        color: kDescriptionColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                    )
                  ]),
            ),
          ),
        ),
        Expanded(
          child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                'images/${image ?? 'satar.png'}',
              )),
        ),
      ],
    );
  }
}
