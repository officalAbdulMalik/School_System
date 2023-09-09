import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/custom_widget/my_text.dart';

class ProfileTitles extends StatelessWidget {
  final String icon;
  final String title;
  final String value;
  const ProfileTitles({Key? key,required this.title,required this.value,required this.icon,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      height: 46,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(5.sp),
            width: 32.sp,
            height: 32.sp,
            decoration: const ShapeDecoration(
              color: Color(0xFFF9FAFB),
              shape: OvalBorder(),
            ),
            child: SvgPicture.asset(icon),
          ),
           SizedBox(width: 16.sp),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Flexible(
                  child: MyText(
                    title,
                    color: const Color(0xFF6B7280),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                  SizedBox(height: 4.sp),
                Flexible(
                  child: MyText(
                    value,
                    color: const Color(0xFF000600),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
