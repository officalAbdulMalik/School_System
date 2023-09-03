import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/views/bottom_bar_parent/profile_screens/show_teahers_classes.dart';

import '../../../controllers/cubits/parent_cubit/get_school_teacher_cubit.dart';
import '../../utils/colors.dart';
import '../../utils/custom_widget/custom_widgets.dart';
import 'add_child_screen.dart';

class SchoolTeacher extends StatefulWidget {
  SchoolTeacher({super.key, required this.schoolId});

  String schoolId;

  @override
  State<SchoolTeacher> createState() => _SchoolTeacherState();
}

class _SchoolTeacherState extends State<SchoolTeacher> {
  @override
  void initState() {
    context.read<GetSchoolTeacherCubit>().getTeacher(widget.schoolId);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xFF2A3B5D),
          centerTitle: true,
          title: Text(
            'Select Teacher',
            style: GoogleFonts.acme(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<GetSchoolTeacherCubit, GetSchoolTeacherState>(
          builder: (context, state) {
            if (state is GetSchoolTeacherLoaded) {
              return SizedBox(
                height: 1000.h,
                width: 500.w,
                child: state.teachers.data!.isNotEmpty
                    ? ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                        padding: EdgeInsets.only(
                            left: 10.sp, right: 10.sp, top: 30.sp),
                        itemCount: state.teachers.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ShowTeacherClasses(
                                  teacherId: '',
                                );
                              }));
                            },
                            child: Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      state.teachers.data![index].image ?? ''),
                                ),
                                title: Text(
                                    state.teachers.data![index].firstName!),
                                subtitle:
                                    Text(state.teachers.data![index].lastName!),
                                trailing: Text(state
                                    .teachers.data![index].language
                                    .toString()),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'No School found',
                          style: GoogleFonts.acme(
                              color: Colors.white, fontSize: 20.sp),
                        ),
                      ),
              );
            } else {
              return CustomWidgets.loadingIndicator();
            }
          },
        ),
      ),
    );
  }
}
