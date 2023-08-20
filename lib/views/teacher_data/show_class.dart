import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/views/teacher_data/show_children.dart';
import 'package:school_system/views/teacher_data/slect_section.dart';
import 'package:school_system/views/utils/colors.dart';

import '../../controllers/cubits/teacher_cubit/get_class_student_cubit.dart';
import '../../controllers/cubits/teacher_cubit/show_teacher_class_cubit.dart';

class TeacherClass extends StatefulWidget {
  const TeacherClass({Key? key}) : super(key: key);

  @override
  State<TeacherClass> createState() => _TeacherClassState();
}

class _TeacherClassState extends State<TeacherClass> {
  @override
  void initState() {
    context.read<ShowTeacherClassCubit>().getClasses();
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
                return const SelectSection();
              },
            ));
          },
          child: RichText(
            text: TextSpan(
                text: 'if you want to add another class',
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
          BlocBuilder<ShowTeacherClassCubit, ShowTeacherClassState>(
            builder: (context, state) {
              if (state is ShowTeacherClassLoading) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: LoadingAnimationWidget.fallingDot(
                      color: Colors.white,
                      size: 50.sp,
                    )),
                  ],
                );
              } else if (state is ShowTeacherClassLoaded) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: 400.w,
                  child: ListView.separated(
                    itemCount: state.model.data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.read<GetClassStudentCubit>().getSections(
                              state.model.data![index].id.toString());
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const ShowChildren();
                            },
                          ));
                        },
                        child: Card(
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
                            title: Text(state.model.data![index].name!),
                            subtitle: Text(state.model.data![index].grade!),
                            trailing: Text(
                                state.model.data![index].schoolId.toString()),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox();
                    },
                  ),
                );
              } else {
                return Text('Data Issue');
              }
            },
          )
        ],
      ),
    );
  }
}
