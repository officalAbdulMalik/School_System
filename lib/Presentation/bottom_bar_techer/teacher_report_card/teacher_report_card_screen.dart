import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_images.dart';
import '../../utils/custom_widget/my_text.dart';

class TeacherReportCardScreen extends StatelessWidget {
  const TeacherReportCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      'Create Report Card',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 3.sp,
                    ),
                    const MyText(
                      'You can create student report cards share',
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
              ),
              SizedBox(
                  width: 86.sp,
                  height: 86.sp,
                  child: Image.asset(AppImages.glassesStarBig)),
            ],
          ),
          SizedBox(
            height: 20.sp,
          ),
          MyText(
            '2023 - Term 2',
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 343,
            height: 39,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        'Class A ',
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      MyText(
                        '32 Students',
                        color: Color(0xFF6B7280),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.more_vert)))
              ],
            ),
          )
        ],
      ),
    );
  }
}
