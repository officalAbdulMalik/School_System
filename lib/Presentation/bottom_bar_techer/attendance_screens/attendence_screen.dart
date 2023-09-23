import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/Presentation/bottom_bar_techer/attendance_screens/show_attendence_screen.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/Presentation/utils/custom_widget/navigator_pop.dart';
import 'package:school_system/Presentation/utils/custom_widget/search_text_field.dart';
import 'package:school_system/models/get_teacher_class_model.dart';

import 'package:table_calendar/table_calendar.dart';

class AttendanceScreen extends StatefulWidget {
  AttendanceScreen({Key? key, required this.data}) : super(key: key);

  List<TeacherClasses> data = [];

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.0.sp, right: 20.sp),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                NavigatorPop(),
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
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withAlpha(80), blurRadius: 2)
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
                        'FEB 2023',
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
                            child: customRow(
                                'Present', '15 Students', Colors.greenAccent),
                          ),
                          Expanded(
                            child: customRow(
                                'Absent', '8 Students', Colors.redAccent),
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
                    MyText(
                      'Mark Attendance',
                      color: Colors.blueAccent,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
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
                  height: 0.5.sh,
                  width: 1.sw,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 60.h,
                          child: showStudentRow(attend, index),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: 4),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showStudentRow(List attend, int index) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: CircleAvatar(
            radius: 40.sp,
            backgroundImage: AssetImage(AppImages.userImage),
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(
                ' Student Name',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              MyText(
                ' Students Last Name',
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
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ShowAttendance();
              },
            ));
          },
          child: Image.asset(
            AppImages.docImage,
            height: 25.sp,
          ),
        )),
        Expanded(
            child: InkWell(
          onTap: () {
            attendSat = !attendSat;
            attend[index]['attend'] = attendSat == true ? 'absent' : 'present';
            setState(() {});
          },
          child: Image.asset(
            AppImages.attendIcon,
            color: attend[index]['attend'] == 'present'
                ? Colors.greenAccent
                : Colors.redAccent,
            height: 25.sp,
            fit: BoxFit.contain,
          ),
        )),
        Expanded(
          child: InkWell(
            onTap: () {
              attendSat = !attendSat;

              attend[index]['attend'] =
                  attendSat == true ? 'absent' : 'present';
              setState(() {});
            },
            child: MyText(
              attend[index]['attend'],
              fontSize: 12.sp,
              color: attend[index]['attend'] == 'present'
                  ? Colors.greenAccent
                  : Colors.redAccent,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
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
