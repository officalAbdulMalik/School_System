import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_images.dart';
import '../../utils/custom_widget/my_text.dart';

class TeacherAddReport extends StatefulWidget {
  const TeacherAddReport({Key? key}) : super(key: key);

  @override
  State<TeacherAddReport> createState() => _TeacherAddReportState();
}

class _TeacherAddReportState extends State<TeacherAddReport> {
  List<String> classes = [
    "Nursery",
    "Pre School",
    "Kindergarten",
    "1st Grade",
    "2nd Grade",
    "3rd Grade",
    "4th Grade",
    " 5th Grade",
    "6th Grade",
    "7th Grade",
    " 8th Grade",
    "9th Grade",
    "10th Grade",
    "Other",
  ];
  List<String> years = [
    "2020",
    "2021",
    "2022",
    "2023",

  ];
  List<String> terms = [
    "Term 1",
    "Term 2",

  ];
  var selectedClass;
  var year;
  var term;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),

        child: Column(
          children: [
            Expanded(child: ListView(
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
                SizedBox(height: 39.sp,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  height: 44.sp,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF3F4F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: MyText(
                            selectedClass ?? 'Select Class',
                            color:selectedClass == null ? const Color(0xff6B7280): Colors.black,
                            fontSize: 14.sp,
                          )),
                      SizedBox(
                        width: 30.w,
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: SizedBox(),
                          icon: const Icon(Icons.keyboard_arrow_down_outlined),
                          items: classes.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (value) {
                            selectedClass = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.sp,),

                Row(
                  children: [
                    Expanded(child:           Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      height: 44.sp,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF3F4F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: MyText(
                                year ?? 'Year',
                                color:year == null ? const Color(0xff6B7280): Colors.black,
                                fontSize: 14.sp,
                              )),
                          SizedBox(
                            width: 30.w,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: SizedBox(),
                              icon: const Icon(Icons.keyboard_arrow_down_outlined),
                              items: years.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (value) {
                                year = value!;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    ),
                    SizedBox(width: 8.sp,),
                    Expanded(child:           Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      height: 44.sp,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF3F4F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: MyText(
                                term ?? 'Term',
                                color:term == null ? const Color(0xff6B7280): Colors.black,
                                fontSize: 14.sp,
                              )),
                          SizedBox(
                            width: 30.w,
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: SizedBox(),
                              icon: const Icon(Icons.keyboard_arrow_down_outlined),
                              items: terms.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (value) {
                                term = value!;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    ),
                  ],
                )

              ],
            ),),

            InkWell(
              onTap: (){},
              child: Container(
                width: 1.sw,
                height: 45.sp,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: ShapeDecoration(
                  color: const Color(0xFF3DAEF5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: MyText(
                  'Continue',
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 32.sp,),
          ],
        ),
      ),
    );
  }
}
