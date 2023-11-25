import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/add_report_cubit.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/get_class_student_cubit.dart';
import 'package:school_system/Controllers/Services/AdsServices/show_ads.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/common/views/bottom_bar.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_time_picker.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/Presentation/utils/custom_widget/search_text_field.dart';
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
  TextEditingController commentsController = TextEditingController();

  @override
  void initState() {
    // context.read<ShowStudentsCubit>().getStudents(widget.id!);
    context.read<GetClassStudentCubit>().getStudent(
        '/api/teacher/class/students?class_id=${widget.id}&first_name=&last_name=');

    // TODO: implement initState
    super.initState();
  }

  List<Map<String, dynamic>> students = [];

  List<TextEditingController> gradeController = [];
  List<TextEditingController> marksController = [];

  bool check = false;

  @override
  Widget build(BuildContext context) {
    log(check.toString());
    return Scaffold(
      bottomNavigationBar: BlocConsumer<AddReportCubit, AddReportState>(
          listener: (context, state) {
        if (state is AddReportError) {
          Fluttertoast.showToast(msg: state.error!);
          Navigator.pop(context);
        }
        if (state is AddReportLoading) {
          Dialogs.loadingDialog(context);
        }
        if (state is AddReportLoaded) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);

          // Navigator.pushAndRemoveUntil(
          //     context,
          // MaterialPageRoute<dynamic>(
          //   builder: (BuildContext context) =>
          //       const BottomBarPages(index: 3),
          // ),
          // (route) => false);
        }
      }, builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(10.0.sp),
          child: InkWell(
            onTap: () {
              log("here is the students${students.toString()}");

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
                                    'comment': commentsController.text.trim(),
                                  };
                                  break;
                                }

                                context.read<AddReportCubit>().addReport(
                                      querterIO: widget.querter,
                                      classId: widget.id,
                                      sessionID: widget.sesion,
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
            child: CustomWidgets.customButton('Continue', onTap: () {

            }),
          ),
        );
      }),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
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
            height: 10.h,
          ),
          const ShowAds(),
          SizedBox(
            height: 10.h,
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
          BlocConsumer<GetClassStudentCubit, GetClassStudentState>(
              listener: (context, state) {
            if (state is GetClassStudentLoading) {
              Dialogs.loadingDialog(context);
            }
            if (state is GetClassStudentLoaded) {
              Navigator.pop(context);
              for (int i = 0; i < state.model!.length; i++) {
                marksController.add(TextEditingController());
                gradeController.add(TextEditingController());
              }
            }
            if (state is GetClassStudentError) {
              Navigator.pop(context);
              Fluttertoast.showToast(msg: state.error!);
            }
          }, builder: (context, state) {
            if (state is GetClassStudentLoaded) {
              return state.model!.isNotEmpty
                  ? SizedBox(
                      height: 0.25.sh,
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.model!.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox();
                          },
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 5.h,
                                ),
                                studentRow(state.model![index], index),
                                const Divider(
                                  height: 0.5,
                                  color: kDividerColor,
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
              return const SizedBox();
            }
          }),
        ],
      ),
    );
  }

  studentRow(ClassStudents data, int index) {
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
              image: data.image != null
                  ? NetworkImage(data.image!)
                  : AssetImage(AppImages.userImage) as ImageProvider,
              fit: BoxFit.fill,
            ),
            shape: const OvalBorder(),
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
              style: const TextStyle(
                color: Color(0xFF000600),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            Text(
              data.student!.rollNumber ?? "",
              style: const TextStyle(
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
                controller: gradeController[index],
                callback: (val) {
                  if (val.isNotEmpty) {
                    log(students.toString());
                    var map = {
                      "student_id": data.id,
                      "points": marksController[index].text.trim(),
                      "grade": val,
                    };

                    log(map.toString());

                    bool check = false; // Initialize check to false

                    for (int i = 0; i < students.length; i++) {
                      if (students[i]['student_id'] == map['student_id']) {
                        students[i] = map;
                        check = true;
                        setState(() {}); // Call setState to update the UI
                        break;
                      }
                    }

                    if (!check) {
                      log('added');
                      students.add(map);
                      setState(() {}); // Call setState to update the UI
                    }
                  }
                },

                hintText: 'Grade',
                filledColor: Colors.grey.shade200,
                // decoration: textFieldIconDecoration(
                //     Icons.alternate_email, 'service@gmail.com', null),
              ),
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
                  log("here is id${data.id.toString()}");

                  if (val.isNotEmpty) {
                    log(students.toString());
                    var map = {
                      "student_id": data.id,
                      "points": val,
                      "grade": gradeController[index].text.trim(),
                    };

                    log(map.toString());

                    bool check = false; // Initialize check to false

                    for (int i = 0; i < students.length; i++) {
                      if (students[i]['student_id'] == map['student_id']) {
                        students[i] = map;
                        check = true;
                        setState(() {}); // Call setState to update the UI
                        break;
                      }
                    }

                    if (!check) {
                      log('added');
                      students.add(map);
                      setState(() {}); // Call setState to update the UI
                    }
                  }
                },
                controller: marksController[index],
                hintText: 'Marks',
                filledColor: Colors.grey.shade200,
              ),
            ),
          ),
        )
      ],
    );
  }
}
