import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/views/utils/colors.dart';

import 'my_text.dart';

class CustomRowWidget extends StatelessWidget {
  String text1;
  String text2;
  int? size;
  String? image;
  int? flex;
  bool? dotButton;
  CustomRowWidget(
      {Key? key,
      required this.text1,
      required this.text2,
      this.flex,
      this.dotButton,
      this.size,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: flex ?? 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text1,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 6.sp,
              ),
              MyText(
                text2,
                color: Color(0xFF6B7280),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )
            ],
          ),
        ),
        Expanded(
          child: dotButton == null
              ? Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'images/${image ?? 'satar.png'}',
                  ))
              : const Icon(Icons.more_vert),
        ),
      ],
    );
  }
}
