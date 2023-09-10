import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/views/utils/app_images.dart';
import 'package:school_system/views/utils/colors.dart';
import 'package:school_system/views/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/views/utils/custom_widget/my_text.dart';
import 'package:school_system/views/utils/custom_widget/navigator_pop.dart';

class ShowAttendance extends StatefulWidget {
  const ShowAttendance({Key? key}) : super(key: key);

  @override
  State<ShowAttendance> createState() => _ShowAttendanceState();
}

class _ShowAttendanceState extends State<ShowAttendance> {
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
        body: Padding(
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
                text1: 'Attendance Report',
                text2: 'View your students attendance report details.',
                dotButton: true,
                imageIs: false,
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withAlpha(80), blurRadius: 2)
                  ],
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 40.sp,
                    backgroundImage: AssetImage(AppImages.userImage),
                    // state.model.data![index].image != null
                    //     ? NetworkImage(
                    //     state.model.data![index].image!)
                    //     : AssetImage('images/prof.png')
                    // as ImageProvider,
                  ),
                  title: MyText(
                    'First Name',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  subtitle: MyText(
                    'First Name',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  trailing: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 5.sp, horizontal: 7.sp),
                      decoration: BoxDecoration(
                        color: kContainerColor,
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                      child: MyText(
                        'First Name',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.blueAccent,
                      )),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 8.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.sp),
                  color: kContainerColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      'Year 2022',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    MyText(
                      'Year 2022',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    MyText(
                      'Year 2022',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
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
              ),
            ],
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
            child: Image.asset('images/calnder.png'),
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
                'Date Time',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              MyText(
                'Subject',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ],
          ),
        ),
        Expanded(
            child: Image.asset(
          AppImages.attendIcon,
          color: attend[index]['attend'] == 'present'
              ? Colors.greenAccent
              : Colors.redAccent,
          height: 25.sp,
          fit: BoxFit.contain,
        )),
        Expanded(
          child: MyText(
            attend[index]['attend'],
            fontSize: 12.sp,
            color: attend[index]['attend'] == 'present'
                ? Colors.greenAccent
                : Colors.redAccent,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
