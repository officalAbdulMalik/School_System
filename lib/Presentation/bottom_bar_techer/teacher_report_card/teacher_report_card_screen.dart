import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_time_picker.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/Presentation/utils/custom_widget/search_text_field.dart';
import 'package:school_system/controllers/cubits/teacher_cubit/add_report_cubit.dart';
import 'package:school_system/controllers/cubits/teacher_cubit/get_class_student_cubit.dart';
import 'package:school_system/models/get_class_student_model.dart';

import '../../utils/app_images.dart';
import '../../utils/custom_widget/my_text.dart';

class TeacherReportCardScreen extends StatefulWidget {
  TeacherReportCardScreen({
    Key? key,
    required this.className,
    required this.querter,
    required this.sesion,
    required this.id,
    required this.subjectId,
  }) : super(key: key);

  String className;
  String id;
  String querter;
  String subjectId;
  String sesion;

  @override
  State<TeacherReportCardScreen> createState() =>
      _TeacherReportCardScreenState();
}

class _TeacherReportCardScreenState extends State<TeacherReportCardScreen> {
  TextEditingController gradeController = TextEditingController();
  TextEditingController marksController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

  @override
  void initState() {
    // context.read<ShowStudentsCubit>().getStudents(widget.id!);
    context.read<GetClassStudentCubit>().getStudent(widget.id.toString());

    // TODO: implement initState
    super.initState();
  }

  List<Map<String, dynamic>> students = [];
  bool check = false;

  @override
  Widget build(BuildContext context) {
    log(students.toString());
    return Scaffold(
      bottomNavigationBar: BlocConsumer<AddReportCubit, AddReportState>(
        listener: (context, state) {
          if (state is AddReportError) {
            Fluttertoast.showToast(msg: state.error!);
          }
        },
        builder: (context, state) {
          if (state is AddReportLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(10.0.sp),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Column(
                          children: [
                            MyTextField(
                              controller: commentsController,
                              filledColor: kContainerColor,
                              hintText: 'Add Comment',
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  if (commentsController.text.isNotEmpty &&
                                      students.isNotEmpty) {
                                    for (int i = 0; i < students.length; i++) {
                                      students[i] = {
                                        "student_id": students[i]['student_id'],
                                        "points": students[i]['points'],
                                        "grade": students[i]['grade'],
                                        'comment':
                                            commentsController.text.trim(),
                                      };
                                      break;
                                    }

                                    print(widget.querter);
                                    print(widget.id);

                                    print(widget.subjectId);

                                    print(widget.sesion);

                                    context.read<AddReportCubit>().addReport(
                                          querterIO: widget.querter,
                                          classId: widget.id,
                                          sessionID: 'widget.session',
                                          subjectID: widget.subjectId,
                                          data: students,
                                          comments: commentsController.text,
                                        );
                                  } else {
                                    Fluttertoast.showToast(msg: 'Add Data');
                                  }
                                },
                                child: Container(
                                  height: 35.h,
                                  width: 190.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: kPrimaryColor,
                                  ),
                                  child: Center(
                                    child: MyText(
                                      'Continue',
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: CustomWidgets.customButton('Continue'),
              ),
            );
          }
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
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
                        widget.className,
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      MyText(
                        widget.sesion,
                        color: Color(0xFF6B7280),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                const Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.more_vert))),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 35.h,
            width: MediaQuery.of(context).size.width,
            child: SearchTextField(
              hintText: 'Search Student',
              filledColor: kContainerColor,
              callBack: (val) {
                setState(() {
                  print(val);
                  // updateValue = val;
                });
              },
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          BlocBuilder<GetClassStudentCubit, GetClassStudentState>(
              builder: (context, state) {
            if (state is GetClassStudentLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            } else if (state is GetClassStudentLoaded) {
              return state.model.data!.isNotEmpty
                  ? SizedBox(
                      height: 0.25.sh,
                      width: 40.w,
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemCount: state.model.data!.length,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              thickness: 2,
                              color: Colors.black,
                            );
                          },
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 5.h,
                                ),
                                studentRow(state.model.data![index]),
                                const Divider(
                                  color: kDescriptionColor,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                              ],
                            );
                          }),
                    )
                  : const Center(
                      child: MyText('Student Not Found'),
                    );
            } else {
              return SizedBox();
            }
          }),
        ],
      ),
    );
  }

  studentRow(Std data) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: ShapeDecoration(
            image: DecorationImage(
              image: data.image!.isNotEmpty
                  ? NetworkImage(data.image!)
                  : AssetImage(AppImages.userImage) as ImageProvider,
              fit: BoxFit.fill,
            ),
            shape: OvalBorder(side: BorderSide(color: Colors.black)),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${data.firstName} ${data.lastName}",
              style: TextStyle(
                color: Color(0xFF000600),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            Text(
              data.id.toString() ?? "",
              style: TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ],
        ),
        Spacer(),
        Flexible(
          child: Container(
            alignment: Alignment.center,
            height: 50.h,
            width: 70.w,
            child: Center(
              child: ReportMyTextField(
                callback: (val) {
                  if (val.isNotEmpty) {
                    var map = {
                      "student_id": data.id,
                      "points": marksController.text.trim(),
                      "grade": val,
                    };

                    for (int i = 0; i < students.length; i++) {
                      if (students[i]['student_id'] == map['student_id']) {
                        students[i] = map;
                        check = true;
                        break;
                      }
                    }
                    if (!check) {
                      students.add(map);
                    }
                    setState(() {});
                  }
                },
                controller: gradeController,

                hintText: 'Grade',
                filledColor: Colors.grey.shade200,
                // decoration: textFieldIconDecoration(
                //     Icons.alternate_email, 'service@gmail.com', null),
              ),

              // const SizedBox(width: 12),
              // Container(
              //   height: 26,
              //   padding:
              //       const EdgeInsets.only(top: 4, left: 4, right: 8, bottom: 4),
              //   decoration: ShapeDecoration(
              //     color: Color(0xFFF3F4F6),
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8)),
              //   ),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Text(
              //         '85',
              //         style: TextStyle(
              //           color: Color(0xFF6B7280),
              //           fontSize: 12,
              //           fontFamily: 'Poppins',
              //           fontWeight: FontWeight.w400,
              //           height: 0,
              //           letterSpacing: 0.75,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(width: 12),
              // Container(
              //   height: 26,
              //   padding:
              //       const EdgeInsets.only(top: 4, left: 4, right: 8, bottom: 4),
              //   decoration: ShapeDecoration(
              //     color: Color(0xFFF3F4F6),
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8)),
              //   ),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Text(
              //         '85',
              //         style: TextStyle(
              //           color: Color(0xFF6B7280),
              //           fontSize: 12,
              //           fontFamily: 'Poppins',
              //           fontWeight: FontWeight.w400,
              //           height: 0,
              //           letterSpacing: 0.75,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Flexible(
          child: Container(
            alignment: Alignment.center,
            height: 50.h,
            width: 70.w,
            child: Center(
              child: ReportMyTextField(
                callback: (val) {
                  if (val.isNotEmpty) {
                    var map = {
                      "student_id": data.id,
                      "points": val,
                      "grade": gradeController.text.trim(),
                    };

                    for (int i = 0; i < students.length; i++) {
                      if (students[i]['student_id'] == map['student_id']) {
                        students[i] = map;
                        check = true;
                        break;
                      }
                    }
                    if (!check) {
                      students.add(map);
                    }
                    setState(() {});
                  }
                },
                controller: marksController,

                hintText: 'Marks',
                filledColor: Colors.grey.shade200,
                // decoration: textFieldIconDecoration(
                //     Icons.alternate_email, 'service@gmail.com', null),
              ),

              // const SizedBox(width: 12),
              // Container(
              //   height: 26,
              //   padding:
              //       const EdgeInsets.only(top: 4, left: 4, right: 8, bottom: 4),
              //   decoration: ShapeDecoration(
              //     color: Color(0xFFF3F4F6),
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8)),
              //   ),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Text(
              //         '85',
              //         style: TextStyle(
              //           color: Color(0xFF6B7280),
              //           fontSize: 12,
              //           fontFamily: 'Poppins',
              //           fontWeight: FontWeight.w400,
              //           height: 0,
              //           letterSpacing: 0.75,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(width: 12),
              // Container(
              //   height: 26,
              //   padding:
              //       const EdgeInsets.only(top: 4, left: 4, right: 8, bottom: 4),
              //   decoration: ShapeDecoration(
              //     color: Color(0xFFF3F4F6),
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8)),
              //   ),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Text(
              //         '85',
              //         style: TextStyle(
              //           color: Color(0xFF6B7280),
              //           fontSize: 12,
              //           fontFamily: 'Poppins',
              //           fontWeight: FontWeight.w400,
              //           height: 0,
              //           letterSpacing: 0.75,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ),
          ),
        )
      ],
    );
  }
}
