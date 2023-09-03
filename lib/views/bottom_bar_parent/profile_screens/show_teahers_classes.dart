import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/models/show_teacher_classes.dart';
import 'package:school_system/views/bottom_bar_parent/profile_screens/show_children.dart';

import '../../../controllers/cubits/parent_cubit/get_school_teacher_cubit.dart';
import '../../../controllers/cubits/parent_cubit/teacher_classes_cubit.dart';
import '../../utils/colors.dart';
import 'add_child_screen.dart';

class ShowTeacherClasses extends StatefulWidget {
  ShowTeacherClasses({super.key, required this.teacherId});

  String teacherId;

  @override
  State<ShowTeacherClasses> createState() => _ShowTeacherClassesState();
}

class _ShowTeacherClassesState extends State<ShowTeacherClasses> {
  @override
  void initState() {
    context.read<TeacherClassesCubit>().getTeacherClasses(widget.teacherId);
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
            'Select Classes',
            style: GoogleFonts.acme(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<TeacherClassesCubit, TeacherClassesState>(
          builder: (context, state) {
            if (state is TeacherClassesLoaded) {
              return SizedBox(
                height: 1000.h,
                width: 500.w,
                child: state.classes.data!.isNotEmpty
                    ? ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                        padding: EdgeInsets.only(
                            left: 10.sp, right: 10.sp, top: 30.sp),
                        itemCount: state.classes.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return ShowChildren(
                                    classId: state.classes.data![index].id
                                        .toString(),
                                  );
                                },
                              ));
                            },
                            child: Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      state.classes.data![index].grade ?? ''),
                                ),
                                title: Text(state.classes.data![index].name!),
                                subtitle: Text(state
                                    .classes.data![index].schoolId
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
              return Center(
                  child: LoadingAnimationWidget.fallingDot(
                color: Colors.white,
                size: 50.sp,
              ));
            }
          },
        ),
      ),
    );
  }
}
