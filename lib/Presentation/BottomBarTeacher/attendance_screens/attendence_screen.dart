import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/add_attendance_cubit.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/get_class_student_cubit.dart';
import 'package:school_system/Controllers/Services/AdsServices/show_ads.dart';
import 'package:school_system/Presentation/common/resources/Extension/extension.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/Presentation/utils/custom_widget/navigator_pop.dart';
import 'package:school_system/Presentation/utils/custom_widget/search_text_field.dart';
import 'package:school_system/models/get_class_student_model.dart';
import 'package:school_system/models/get_teacher_class_model.dart';

import 'package:table_calendar/table_calendar.dart';

class AttendanceScreen extends StatefulWidget {
  AttendanceScreen({Key? key, required this.data, required this.index})
      : super(key: key);

  TeacherShowClass data;
  int? index;

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String updateValue = '';

  bool attendSat = true;

  List<String> presentStudentIds = [];
  List<String> absentStudentIds = [];

  List<bool> isPresent = [];

  void addToPresent(String studentId) {
    setState(() {
      // If the student ID is already in the absent list, remove it
      if (absentStudentIds.contains(studentId.toString())) {
        absentStudentIds.remove(studentId.toString());
        log("absesnts${presentStudentIds.toString()}");
      }
      // Add the student ID to the present list
      if (presentStudentIds.contains(studentId)) {
      } else {
        presentStudentIds.add(studentId.toString());
        log("absesnts${presentStudentIds.toString()}");
      }
    });
  }

  void addToAbsent(String studentId) {
    setState(() {
      // If the student ID is already in the present list, remove it
      if (presentStudentIds.contains(studentId)) {
        presentStudentIds.remove(studentId);
        log("presents ${absentStudentIds.toString()}");
      }
      // Add the student ID to the absent list
      if (absentStudentIds.contains(studentId)) {
      } else {
        absentStudentIds.add(studentId);
        log("presents ${absentStudentIds.toString()}");
      }
    });
  }

  @override
  void initState() {
    context.read<GetClassStudentCubit>().getStudent(
        '/api/teacher/class/students?class_id=${widget.data.data![widget.index!].id}&first_name=&last_name=');

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10.sp),
                    height: 35.h,
                    width: 340.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                      color: Colors.grey,
                    ),
                    child: Center(
                        child: Text(
                      "Cancel",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14.h,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                  ),
                ),
              ),
              SizedBox(
                width: 15.sp,
              ),
              Expanded(
                child: BlocListener<AddAttendanceCubit, AddAttendanceState>(
                  listener: (context, state) {
                    if (state is AddAttendanceLoading) {
                      Dialogs.loadingDialog(context);
                    }
                    if (state is AddAttendanceLoaded) {
                      Navigator.of(context).pop(true);
                      Fluttertoast.showToast(msg: 'Data Success');
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                    if (state is AddAttendanceError) {
                      Fluttertoast.showToast(msg: state.error!);
                      Navigator.of(context).pop(true);
                    }
                    // TODO: implement listener
                  },
                  child: InkWell(
                    onTap: () {
                      context.read<AddAttendanceCubit>().addAttendanceCubit(
                          classId:
                              widget.data.data![widget.index!].id.toString(),
                          date: DateTime.now().humanReadableDate,
                          present: presentStudentIds,
                          absent: absentStudentIds);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10.sp),
                      height: 35.h,
                      width: 340.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                        color: kPrimaryColor,
                      ),
                      child: Center(
                          child: Text(
                        "Save",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14.h,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 20.0.sp, right: 20.sp),
          child: BlocConsumer<GetClassStudentCubit, GetClassStudentState>(
            listener: (context, state) {
              if (state is GetClassStudentLoading) {
                Dialogs.loadingDialog(context);
              }
              if (state is GetClassStudentLoaded) {
                Navigator.of(context).pop(true);
                isPresent = List.generate(
                  state.model!
                      .length, // Change this to match the number of names
                  (index) => false,
                );
              }
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is GetClassStudentLoaded) {
                return Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    const NavigatorPop(),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomRowWidget(
                      text1: 'Attendance',
                      text2: 'Mark your class attendance here',
                      dotButton: true,
                      flex: 10,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const ShowAds(),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withAlpha(80), blurRadius: 2)
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          MyText(
                            DateTime.now().toPkDate,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          Divider(),
                          TableCalendar(
                            onDaySelected: (selectedDay, focusedDay) {},
                            headerStyle: HeaderStyle(
                              leftChevronVisible: true,
                              headerMargin: EdgeInsets.only(left: 10.sp),
                              rightChevronVisible: true,
                              formatButtonVisible: true,
                              formatButtonShowsNext: true,
                            ),
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            calendarFormat: CalendarFormat.week,
                            firstDay: DateTime.utc(2010, 10, 16),
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: DateTime.now(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      height: 0.20.sh,
                      width: 1.sw,
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 50.h,
                              child: showStudentRow(index, state.model!),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: state.model!.length),
                    )
                  ],
                );
              } else if (state is GetClassStudentError) {
                return Center(
                  child: Text(state.error!),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  showStudentRow(int index, List<ClassStudents> students) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: CircleAvatar(
            radius: 40.sp,
            backgroundImage: students[index].image != null
                ? NetworkImage(
                    students[index].image!,
                  )
                : AssetImage(AppImages.userImage) as ImageProvider,
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(
                "${students[index].firstName} ${students[index].lastName}",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              MyText(
                '${students[index].mobile ?? ""}',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ],
          ),
        ),
        Expanded(
            child: InkWell(
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(
            //   builder: (context) {
            //     return ShowAttendance();
            //   },
            // ));
          },
          child: Image.asset(
            AppImages.docImage,
            height: 25.sp,
          ),
        )),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
            flex: 2,
            child: InkWell(
              onTap: () {
                isPresent[index] == true
                    ? addToPresent(students[index].id.toString())
                    : addToAbsent(students[index].id.toString());
                isPresent[index] = !isPresent[index];
                setState(() {});
              },
              child: Row(
                children: [
                  Flexible(
                    child: Image.asset(
                      AppImages.attendIcon,
                      color: isPresent[index] == true
                          ? Colors.greenAccent
                          : Colors.redAccent,
                      height: 25.sp,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Flexible(
                    flex: 2,
                    child: MyText(
                      isPresent[index] == true ? "Present" : "Absent",
                      fontSize: 12.sp,
                      color: isPresent[index] == true
                          ? Colors.greenAccent
                          : Colors.redAccent,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  customRow(String text1, String text2, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
      margin: EdgeInsets.only(right: 5.sp, left: 5.sp),
      decoration: BoxDecoration(
        color: kContainerColor,
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text1,
                color: textColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              Icon(
                Icons.more_vert,
                size: 20.sp,
                color: kDescriptionColor,
              ),
            ],
          ),
          MyText(
            text2,
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
