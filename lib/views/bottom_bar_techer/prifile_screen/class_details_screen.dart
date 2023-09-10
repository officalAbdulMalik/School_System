import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/models/get_teacher_class_model.dart';
import 'package:school_system/views/utils/app_images.dart';
import 'package:school_system/views/utils/colors.dart';
import 'package:school_system/views/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/views/utils/custom_widget/custome_botton_details_screen.dart';
import 'package:school_system/views/utils/custom_widget/my_text.dart';
import 'package:school_system/views/utils/custom_widget/navigator_pop.dart';

class ClassDeatailsScreen extends StatefulWidget {
  ClassDeatailsScreen({Key? key, required this.data, required this.index})
      : super(key: key);

  List<TeacherClasses> data = [];
  int index;

  @override
  State<ClassDeatailsScreen> createState() => _ClassDeatailsScreenState();
}

class _ClassDeatailsScreenState extends State<ClassDeatailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.sp,
              right: 20.sp,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20.sp,
                ),
                NavigatorPop(),
                SizedBox(
                  height: 10.h,
                ),
                CustomRowWidget(
                  text1: 'Class Details',
                  text2: 'View your class details here.',
                  image: 'sign_star.png',
                  flex: 10,
                  dotButton: true,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                    padding: EdgeInsets.only(
                        bottom: 10.sp, top: 10.sp, left: 10.sp, right: 10),
                    height: 70.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.sp),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withAlpha(80), blurRadius: 2)
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: MyText(
                                  widget.data[widget.index].name!,
                                  color: Color(0xFF000600),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: MyText(
                                  "class Name",
                                  color: kDescriptionColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        )),
                        VerticalDivider(),
                        Expanded(
                            child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: MyText(
                                  widget.data[widget.index].grade,
                                  color: Color(0xFF000600),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: MyText(
                                  "Grade",
                                  color: kDescriptionColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        )),
                        VerticalDivider(),
                        Expanded(
                            child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: MyText(
                                  widget.data[widget.index].schoolId.toString(),
                                  color: Color(0xFF000600),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: MyText(
                                  "Students",
                                  color: kDescriptionColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ))
                      ],
                    )),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => role == 'teacher'
                          //             ? TeacherClass()
                          //             : ShowChildren(
                          //                 classId: '',
                          //               )));
                        },
                        child: Container(
                          height: 136.sp,
                          padding: const EdgeInsets.all(16),
                          decoration: ShapeDecoration(
                            color: kCardBColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  width: 64.sp,
                                  height: 64.sp,
                                  child: Center(
                                    child: Image.asset('images/satar.png'),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: MyText(
                                    "36",
                                    color: Color(0xFF000600),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: MyText(
                                    "Teachers",
                                    color: kDescriptionColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.sp,
                    ),
                    Expanded(
                      child: Container(
                        height: 136.sp,
                        padding: const EdgeInsets.all(16),
                        decoration: ShapeDecoration(
                          color: kCardPColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                width: 64.sp,
                                height: 64.sp,
                                child: Center(
                                  child: Image.asset(AppImages.starConfuse),
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Center(
                                child: MyText(
                                  '18',
                                  color: Color(0xFF000600),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Center(
                                child: MyText(
                                  'Subjects',
                                  color: kDescriptionColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButtonDetailsScreen(
                  color: kCardPColor,
                  image: 'images/attend.png',
                  text: 'Attendance',
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButtonDetailsScreen(
                  color: kCardBColor,
                  image: 'images/report.png',
                  text: 'Reports',
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButtonDetailsScreen(
                  color: kCardGColor,
                  image: 'images/metting.png',
                  text: 'Meetings',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
