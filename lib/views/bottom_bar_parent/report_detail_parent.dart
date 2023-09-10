import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_system/views/bottom_bar_parent/show_report_sreen.dart';

import '../utils/app_images.dart';
import '../utils/custom_widget/my_text.dart';

class ReportDetailParent extends StatelessWidget {
  const ReportDetailParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                'Reports Details',
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 3.sp,
              ),
              const MyText(
                'View your kids reports details.',
                color: Color(0xFF6B7280),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )
            ],
          ),
          SizedBox(
            height: 32.sp,
          ),
          ReportCard(studentName: 'Daves Jobs', className: 'Class A'),
          SizedBox(
            height: 20.sp,
          ),
          Container(
            height: 34.sp,
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
            decoration: ShapeDecoration(
              color: const Color(0xFFF3F4F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: MyText(
                    'Year 2022',
                    color: Color(0xFF000600),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(
                  child: MyText(
                    'Term 1',
                    color: Color(0xFF000600),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),

          const ReportDetailCard(marks: '96', subject: 'Science',),
          const ReportDetailCard(marks: '92', subject: 'Mathematics',),
          const ReportDetailCard(marks: '95', subject: 'History',),
          const ReportDetailCard(marks: '90', subject: 'Geography',),
        ],
      ),
    );
  }
}

class ReportDetailCard extends StatelessWidget {
  final String subject;
  final String marks;
  const ReportDetailCard({Key? key, required this.marks,required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return           SizedBox(
      height: 52.sp,
      child: Row(
        children: [
          Container(
            width: 32.sp,
            height: 32.sp,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.bookIcon),
                fit: BoxFit.fill,
              ),
              shape: OvalBorder(),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: MyText(
                          subject,
                          color: Color(0xFF000600),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Flexible(
                        child: MyText(
                          'Arman Malik',
                          color: Colors.black,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20.sp,
                        height: 20.sp,
                        child: SvgPicture.asset(AppImages.report),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 20.sp,
                        height: 20.sp,
                        child: SvgPicture.asset(AppImages.chatComment),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Center(
            child: Container(
              width: 100.sp,
              height: 26.sp,
              padding: const EdgeInsets.only(top: 4, left: 4, right: 8, bottom: 4),
              decoration: ShapeDecoration(
                color: const Color(0xFFE2F4FF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Flexible(
                    child: MyText(
                      marks,
                      color: const Color(0xFF6B7280),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.75,

                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 16.sp,
                        height: 16.sp,
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: OvalBorder(),
                        ),
                        child:  Center(
                          child: Text(
                            'A',
                            style: TextStyle(
                              color: const Color(0xFF000600),
                              fontSize: 12.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.75,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),),


        ],
      ),
    );
  }
}

