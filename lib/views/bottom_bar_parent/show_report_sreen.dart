import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/views/utils/colors.dart';

class ReportCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.sp,
            ),
            ReportCard(
              studentName: 'John Doe',
              className: 'Class 5A',
              subjectGrades: {
                'Mathematics': 'A',
                'Science': 'B+',
                'English': 'A+',
                'History': 'A-',
                'Geography': 'B',
                'Art': 'A',
                'Music': 'B+',
              },
              color: Colors.yellowAccent,
            ),
            ReportCard(
              studentName: 'Ste',
              className: 'Class A5',
              subjectGrades: {
                'Mathematics': 'A',
                'Science': 'B+',
                'English': 'A+',
                'History': 'A-',
                'Geography': 'B',
                'Art': 'A',
                'Music': 'B+',
              },
              color: Colors.pinkAccent,
            ),
            ReportCard(
              studentName: 'Eryan',
              className: 'Class 8',
              subjectGrades: {
                'Mathematics': 'A',
                'Science': 'B+',
                'English': 'A+',
                'History': 'A-',
                'Geography': 'B',
                'Art': 'A',
                'Music': 'B+',
              },
              color: Colors.yellowAccent,
            ),
            ReportCard(
              studentName: 'Ste',
              className: 'Class A5',
              subjectGrades: {
                'Mathematics': 'A',
                'Science': 'B+',
                'English': 'A+',
                'History': 'A-',
                'Geography': 'B',
                'Art': 'A',
                'Music': 'B+',
              },
              color: Colors.pinkAccent,
            ),
            SizedBox(
              height: 100.h,
            ),
          ],
        ),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String studentName;
  final String className;
  final Color color;
  final Map<String, String> subjectGrades;

  ReportCard({
    required this.studentName,
    required this.className,
    required this.subjectGrades,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 10.sp),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0.sp, horizontal: 10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student Name: $studentName',
              style:
                  GoogleFonts.acme(fontSize: 14.0, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 8.0),
            Text(
              'Class: $className',
              style:
                  GoogleFonts.acme(fontSize: 14.0, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 16.0),
            Text(
              'Subject Grades:',
              style:
                  GoogleFonts.acme(fontSize: 10.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.sp),
                color: color,
              ),
              child: ExpansionTile(
                title: Text('Grade Of Subjects'),
                children: [
                  ListTile(
                    leading: Text(
                      'Maths',
                      style: GoogleFonts.acme(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    title: Text('A+'),
                    trailing: Container(
                      height: 10,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: _getGradeColor('A+'),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      'Englis',
                      style: GoogleFonts.acme(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    title: Text('B+'),
                    trailing: Container(
                      height: 10,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: _getGradeColor('B+'),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      'Bio',
                      style: GoogleFonts.acme(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    title: Text('C+'),
                    trailing: Container(
                      height: 10,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: _getGradeColor('C'),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      'Arts',
                      style: GoogleFonts.acme(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    title: Text('C'),
                    trailing: Container(
                      height: 10,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: _getGradeColor('C'),
                      ),
                    ),
                  )
                ],
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
