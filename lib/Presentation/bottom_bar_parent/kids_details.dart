import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/navigator_pop.dart';
import 'package:school_system/models/get_all_students.dart';
import 'package:school_system/models/get_class_student_model.dart';

import '../utils/custom_widget/custome_botton_details_screen.dart';
import '../utils/custom_widget/my_text.dart';

class KidsDetailsScreen extends StatefulWidget {
  KidsDetailsScreen({Key? key, required this.data, required this.index})
      : super(key: key);

  List<Std> data = [];
  int index;

  @override
  State<KidsDetailsScreen> createState() => _KidsDetailsScreenState();
}

class _KidsDetailsScreenState extends State<KidsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.data);
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
                  text1: 'Kids Details!',
                  text2: 'View your Kids details here.',
                  image: 'sign_star.png',
                  flex: 10,
                  dotButton: true,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.sp),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withAlpha(80), blurRadius: 2)
                    ],
                  ),
                  child: ListTile(
                    // leading: CircleAvatar(
                    //   radius: 40.sp,
                    //   backgroundImage: widget.data[widget.index].image != null
                    //       ? NetworkImage('${widget.data[widget.index].image}')
                    //       : AssetImage('images/prof.png') as ImageProvider,
                    // ),
                    title: Text(
                      "Name",
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        CircleAvatar(
                          radius: 3.sp,
                          backgroundColor: Colors.grey,
                        ),
                        Text(
                          "  class Name",
                          style: GoogleFonts.poppins(
                            color: kDescriptionColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    trailing: Container(
                        height: 30.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.sp)),
                        child: Center(
                            child: Text(
                          "Grade Name",
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ))),
                  ),
                ),
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
