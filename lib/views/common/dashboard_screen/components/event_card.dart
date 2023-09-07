import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/app_images.dart';
import '../../../utils/custom_widget/my_text.dart';

class EventCard extends StatelessWidget {
  final Color cardColor;

  const EventCard({Key? key,required this.cardColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.sp),
      height: 94.sp,
      decoration: ShapeDecoration(
        color: const Color(0xFFF3F4F6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration:  ShapeDecoration(
                color: cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
              ),
              child: Column(

                children: [
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 20.sp),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(AppImages.timeIcon))),
                  ),

                  const Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: MyText(
                            '10:00 AM',
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            letterSpacing: 0.75,

                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Flexible(
                          child: MyText(
                            '11:00 AM',
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.75,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding:  EdgeInsets.only(left: 16.sp),
              child: Column(

                children: [
                  const Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: MyText(
                        'Grade 6',

                        color: Color(0xFF6B7280),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.75,
                      ),
                    ),
                  ),
                  Expanded(child: Align(
                      alignment: Alignment.topLeft,

                      child: MyText('Parents Meeting',fontSize: 16.sp,))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
