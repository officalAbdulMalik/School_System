import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/controllers/cubits/teacher_cubit/get_teacher_subject_cubit.dart';
import 'package:school_system/views/bottom_bar_techer/prifile_screen/show_student.dart';
import 'package:school_system/views/bottom_bar_techer/prifile_screen/slect_section.dart';
import 'package:school_system/views/bottom_bar_techer/prifile_screen/teacher_create_subject.dart';
import 'package:school_system/views/utils/colors.dart';

import '../../../controllers/cubits/teacher_cubit/get_class_student_cubit.dart';
import '../../../controllers/cubits/teacher_cubit/show_teacher_class_cubit.dart';
import '../../utils/custom_widget/custom_widgets.dart';

class ShowTeacherSubject extends StatefulWidget {
  ShowTeacherSubject({Key? key, required this.classID}) : super(key: key);

  String classID;

  @override
  State<ShowTeacherSubject> createState() => _ShowTeacherSubjectState();
}

class _ShowTeacherSubjectState extends State<ShowTeacherSubject> {
  @override
  void initState() {
    context.read<GetTeacherSubjectCubit>().getSubject(widget.classID);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 40.sp, bottom: 10.sp),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return CreateSubjects(
                  classId: widget.classID,
                );
              },
            ));
          },
          child: RichText(
            text: TextSpan(
                text: 'if you want to add another Subject',
                style: GoogleFonts.acme(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
                children: [
                  TextSpan(
                    text: ' Click here',
                    style: GoogleFonts.acme(
                      color: kButtonColor,
                      fontSize: 16.sp,
                    ),
                  ),
                ]),
          ),
        ),
      ),
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: kButtonColor,
        centerTitle: true,
        title: Text(
          'Classes',
          style: GoogleFonts.acme(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
        children: [
          SizedBox(
            height: 20.h,
          ),
          BlocBuilder<GetTeacherSubjectCubit, GetTeacherSubjectState>(
            builder: (context, state) {
              if (state is GetTeacherSubjectLoading) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomWidgets.loadingIndicator(),
                  ],
                );
              } else if (state is GetTeacherSubjectLoaded) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: 400.w,
                  child: state.subjects.data == null
                      ? ListView.separated(
                          itemCount: state.subjects.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              child: ListTile(
                                leading: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.greenAccent,
                                  ),
                                  height: 10.h,
                                  width: 10.w,
                                ),
                                title: Text(state.subjects.data![index].name!),
                                trailing: Text(state.subjects.data![index].code
                                    .toString()),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox();
                          },
                        )
                      : Center(
                          child: Text(
                          'No Subjects Here',
                          style: GoogleFonts.acme(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        )),
                );
              } else {
                return const Text('Data Issue');
              }
            },
          )
        ],
      ),
    );
  }
}
