import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/show_class_attendance_cubit.dart';
import 'package:school_system/Controllers/Services/AdsServices/show_ads.dart';
import 'package:school_system/Presentation/common/resources/Extension/extension.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/Presentation/utils/custom_widget/navigator_pop.dart';
import 'package:school_system/Presentation/utils/custom_widget/search_text_field.dart';
import 'package:school_system/models/get_class_student_model.dart';
import 'package:school_system/models/get_teacher_class_model.dart';
import 'package:school_system/models/show_attendance_model.dart';

import 'package:table_calendar/table_calendar.dart';

import 'attendence_screen.dart';

class ShowAllAttendanceScreen extends StatefulWidget {
  ShowAllAttendanceScreen({Key? key, required this.data, required this.index})
      : super(key: key);

  TeacherShowClass data;
  int? index;
  @override
  State<ShowAllAttendanceScreen> createState() =>
      _ShowAllAttendanceScreenState();
}

class _ShowAllAttendanceScreenState extends State<ShowAllAttendanceScreen> {
  String updateValue = '';

  bool attendSat = true;

  List<Map<String, dynamic>> attend = [
    {
      'attend': 'present',
    },
    {
      'attend': 'present',
    },
    {
      'attend': 'absent',
    },
    {
      'attend': 'absent',
    },
  ];

  List<Map<String, dynamic>> data = [
    {
      'attend': 'present',
    },
    {
      'attend': 'present',
    },
    {
      'attend': 'absent',
    },
    {
      'attend': 'absent',
    },
  ];

  List<int> presentStudentIds = [];
  List<int> absentStudentIds = [];

  List<bool> isPresent = [];

  @override
  void initState() {
    context.read<ShowClassAttendanceCubit>().getAttendance(
        widget.data.data![widget.index!].id.toString(), "2023-10-08");

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 20.0.sp, right: 20.sp),
          child:
              BlocConsumer<ShowClassAttendanceCubit, ShowClassAttendanceState>(
            listener: (context, state) {
              if (state is ShowClassAttendanceLoading) {
                Dialogs.loadingDialog(context);
              }
              if (state is ShowClassAttendanceLoaded) {
                // print(state.model![0].presentCount);
                Navigator.of(context).pop(true);
              }
            },
            builder: (context, state) {
              if (state is ShowClassAttendanceLoaded) {
                return SingleChildScrollView(
                  child: Column(
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
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: customRow('Present',
                                      state.present ?? "", Colors.greenAccent),
                                ),
                                Expanded(
                                  child: customRow('Absent', state.absent ?? "",
                                      Colors.redAccent),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            'Students',
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return AttendanceScreen(
                                    data: widget.data,
                                    index: widget.index,
                                  );
                                },
                              ));
                            },
                            child: MyText(
                              'Mark Attendance',
                              color: Colors.blueAccent,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
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
                              updateValue = val;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 0.20.sh,
                        width: 1.sw,
                        child: state.attendance!.isNotEmpty
                            ? ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    height: 60.h,
                                    child: showStudentRow(
                                        index, state.attendance!),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                                itemCount: state.attendance!.length)
                            : Center(
                                child: MyText(
                                  "Attendance not found",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                      )
                    ],
                  ),
                );
              } else if (state is ShowClassAttendanceError) {
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

  showStudentRow(int index, List<Attendance> attendance) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(
                "${attendance[index].date?.humanReadableDate} ${attendance[index].studentId}",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              MyText(
                '${attendance[index].classSectionId}',
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
            child: Row(
              children: [
                Flexible(
                  child: Image.asset(
                    AppImages.attendIcon,
                    color: attendance[index].type == 1
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
                    attendance[index].type == 1 ? "Present" : "Absent",
                    fontSize: 12.sp,
                    color: attendance[index].type == 1
                        ? Colors.greenAccent
                        : Colors.redAccent,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
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
