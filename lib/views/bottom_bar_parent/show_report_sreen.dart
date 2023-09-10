import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/views/bottom_bar_parent/report_detail_parent.dart';
import 'package:school_system/views/utils/colors.dart';

import '../utils/app_images.dart';
import '../utils/custom_widget/my_text.dart';

class ReportCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      'Reports',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 3.sp,
                    ),
                    const MyText(
                      'View all your kids reports here.',
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
                  child: Image.asset(AppImages.starConfuse)),
            ],
          ),

          SizedBox(
            height: 20.sp,
          ),
          ReportCard(studentName: 'Daves Jobs', className: 'Class A'),
          ReportCard(studentName: 'Rayan Jobs', className: 'Class A'),
          ReportCard(studentName: 'Anita Dewinya', className: 'Class A'),

          SizedBox(
            height: 100.h,
          ),
        ],
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String studentName;
  final String className;
  // final Color color;
  // final Map<String, String> subjectGrades;

  ReportCard({
    required this.studentName,
    required this.className,
    // required this.subjectGrades,
    // required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
     onTap: (){
       Navigator.of(context).push(MaterialPageRoute(builder: (context){
         return ReportDetailParent();
       }));
     },
      child: Container(
        margin: EdgeInsets.only(bottom: 15.sp),
        height: 96.sp,
        padding:  EdgeInsets.all(16.sp),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x19303133),
              blurRadius: 30,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.userImage),
                  fit: BoxFit.fill,
                ),
                shape: const OvalBorder(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: MyText(
                      studentName,
                      color: Color(0xFF000600),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                Expanded(child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: ShapeDecoration(
                        color: Color(0xFF6B7280),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Harward School',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.75,
                      ),
                    ),
                  ],
                ),),
              ],
            ),),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: ShapeDecoration(
                color: Color(0xFFF3F4F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: MyText(
                className ,
                color: Color(0xFF3DAEF5),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

          ],
        ),
      ),
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A+':
        return Colors.green;
      case 'A':
        return Colors.blue;
      case 'A-':
        return Colors.lightBlue;
      case 'B+':
        return Colors.yellow;
      case 'B':
        return Colors.orange;
      case 'C':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
