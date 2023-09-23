import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';

class MeetingList extends StatelessWidget {
  const MeetingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 10.sp),
            padding: EdgeInsets.all(16.sp),
            decoration: ShapeDecoration(
              color: const Color(0xFFEFE7FD),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: MyText(
                        'Class A',
                        color: Color(0xFF000600),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 15.sp,
                            child: SvgPicture.asset(AppImages.profile)),
                        const SizedBox(width: 4),
                        const Flexible(
                          child: MyText(
                            '15',
                            color: Color(0xFF6B7280),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.sp,
                ),
                const MyText(
                  'Parents Meeting - Grade 6',
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.75,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 6.sp,
                ),
                Row(
                  children: [
                    SvgPicture.asset(AppImages.historyClock),
                    SizedBox(
                      width: 4.sp,
                    ),
                    const Expanded(
                      child: MyText(
                        '09:00 - 11:00',
                        color: Color(0xFF6B7280),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      // width: 67,
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 4.sp),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFF3D51A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          const MyText(
                            'Pending',
                            color: Color(0xFF000600),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}
