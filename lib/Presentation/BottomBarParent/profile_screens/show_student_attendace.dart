import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_system/Controllers/Cubits/ParentCubit/student_attendance_cubit.dart';
import 'package:school_system/Controllers/Services/AdsServices/show_ads.dart';
import 'package:school_system/Presentation/common/resources/Extension/extension.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/Presentation/utils/custom_widget/navigator_pop.dart';
import 'package:school_system/models/ParentModels/student_attendance.dart';
import 'package:school_system/models/get_class_student_model.dart';

class StudentAttendance extends StatefulWidget {
  StudentAttendance({Key? key, required this.data}) : super(key: key);
  ClassStudents data;

  @override
  State<StudentAttendance> createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {
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
  void initState() {
    context
        .read<StudentAttendanceCubit>()
        .getAttendance(widget.data.id.toString());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 20.0.sp, right: 20.sp),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
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
                  text1: 'Attendance Report',
                  text2: 'View your students attendance report details.',
                  dotButton: true,
                  imageIs: false,
                ),
                SizedBox(
                  height: 10.h,
                ),
                const ShowAds(),
                SizedBox(
                  height: 10.h,
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
                      // state.model[index].image != null
                      //     ? NetworkImage(
                      //     state.model.data![index].image!)
                      //     : AssetImage('images/prof.png')
                      // as ImageProvider,
                    ),
                    title: MyText(
                      '${widget.data.firstName}${widget.data.lastName}',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    subtitle: MyText(
                      'school Name',
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
                          widget.data.gender!,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.blueAccent,
                        )),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                // Container(
                //   padding:
                //       EdgeInsets.symmetric(vertical: 8.sp, horizontal: 8.sp),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12.sp),
                //     color: kContainerColor,
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       MyText(
                //         'Year 2022',
                //         fontSize: 14.sp,
                //         fontWeight: FontWeight.w500,
                //       ),
                //       MyText(
                //         'Year 2022',
                //         fontSize: 14.sp,
                //         fontWeight: FontWeight.w500,
                //       ),
                //       MyText(
                //         'Year 2022',
                //         fontSize: 14.sp,
                //         fontWeight: FontWeight.w500,
                //       )
                //     ],
                //   ),
                // ),

                BlocConsumer<StudentAttendanceCubit, StudentAttendanceState>(
                  listener: (context, state) {
                    if (state is StudentAttendanceLoading) {
                      Dialogs.showLoadingDialog(context);
                    }
                    if (state is StudentAttendanceLoaded) {
                      Navigator.pop(context);
                    }
                    if (state is StudentAttendanceError) {
                      Fluttertoast.showToast(msg: state.error!);
                      Navigator.pop(context);
                    }
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is StudentAttendanceLoaded) {
                      return SizedBox(
                        height: 0.5.sh,
                        width: 1.sw,
                        child: state.attendance!.isNotEmpty
                            ? ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    height: 60.h,
                                    child:
                                        showStudentRow(state.attendance, index),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                                itemCount: state.attendance!.length)
                            : Center(
                                child: MyText(
                                  'Attendance not found',
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                ),
                              ),
                      );
                    } else if (state is StudentAttendanceError) {
                      return Center(
                        child: MyText(state.error!),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showStudentRow(List<ParentStudentAttendance>? attend, int index) {
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
                attend?[index].date!.humanReadableDate ?? "",
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              // MyText(
              //   "",
              //   fontSize: 14.sp,
              //   fontWeight: FontWeight.w400,
              //   color: Colors.black,
              // ),
            ],
          ),
        ),
        Expanded(
            child: Image.asset(
          AppImages.attendIcon,
          color:
              attend![index].type == 1 ? Colors.greenAccent : Colors.redAccent,
          height: 25.sp,
          fit: BoxFit.contain,
        )),
        Expanded(
          child: MyText(
            attend[index].type == 1 ? "Present" : "Absent",
            fontSize: 12.sp,
            color:
                attend[index].type == 1 ? Colors.greenAccent : Colors.redAccent,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
