import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/Presentation/bottom_bar_parent/profile_screens/show_children.dart';
import 'package:school_system/Presentation/common/resources/loading_dialog.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_dop_down.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/controllers/cubits/parent_cubit/assign_child_to_class_cubit.dart';
import 'package:school_system/controllers/cubits/parent_cubit/teacher_classes_cubit.dart';

import '../../../controllers/cubits/parent_cubit/get_school_teacher_cubit.dart';
import '../../utils/colors.dart';
import '../../utils/custom_widget/custom_widgets.dart';
import 'add_child_screen.dart';

class SchoolTeacher extends StatefulWidget {
  SchoolTeacher({super.key, required this.schoolId, required this.studentId});

  String studentId;
  String schoolId;

  @override
  State<SchoolTeacher> createState() => _SchoolTeacherState();
}

class _SchoolTeacherState extends State<SchoolTeacher> {
  @override
  void initState() {
    context.read<GetSchoolTeacherCubit>().getTeacher(widget.schoolId);
    context.read<TeacherClassesCubit>().getTeacherClasses('');

    // TODO: implement initState
    super.initState();
  }

  String? classId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 15.0.sp, right: 15.sp, bottom: 15.sp),
          child: BlocListener<AssignChildToClassCubit, AssignChildToClassState>(
            listener: (context, state) {
              if (state is AssignChildToClassLoading) {
                LoadingDialog.showLoadingDialog(context);
              }
              if (state is AssignChildToClassLoaded) {
                Navigator.of(context).pop(true);
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return ShowChildren();
                  },
                ));
              }
              if (state is AssignChildToClassError) {
                Fluttertoast.showToast(msg: state.error!);

                Navigator.of(context).pop(true);
              }
              // TODO: implement listener
            },
            child: InkWell(
              onTap: () {
                context
                    .read<AssignChildToClassCubit>()
                    .assign(widget.studentId, classId!);
              },
              child: CustomWidgets.customButton('Add Class'),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<GetSchoolTeacherCubit, GetSchoolTeacherState>(
          listener: (context, state) {
            if (state is GetSchoolTeacherLoading) {
              LoadingDialog.showLoadingDialog(context);
            }
            if (state is GetSchoolTeacherLoaded) {
              Navigator.of(context).pop(true);
            }
            if (state is GetSchoolTeacherError) {
              Fluttertoast.showToast(msg: 'Some Thing Wrong');
              Navigator.of(context).pop(true);
            }
          },
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
              children: [
                SizedBox(height: 20.h),
                CustomRowWidget(
                  text1: 'Select Class',
                  text2: 'Select class from here...',
                  image: 'add_s_star.png',
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomDropDown(
                  hintText: 'Teachers',
                  onChanged: (value) {
                    print(value);
                    // slectedClass = value.toString();
                  },
                  itemsMap: state is GetSchoolTeacherLoaded
                      ? state.teachers.data!.map((e) {
                          return DropdownMenuItem(
                            value: e.id,
                            child: Text(
                              "${e.firstName}${e.lastName}",
                            ),
                            onTap: () {
                              context
                                  .read<TeacherClassesCubit>()
                                  .getTeacherClasses(e.id.toString());
                            },
                          );
                        }).toList()
                      : [].map((e) {
                          return DropdownMenuItem(
                            value: e.id,
                            child: Text(
                              "${e.firstName} ${e.lastName}",
                            ),
                          );
                        }).toList(),
                ),
                SizedBox(
                  height: 10.h,
                ),
                BlocConsumer<TeacherClassesCubit, TeacherClassesState>(
                  listener: (context, state) {
                    if (state is TeacherClassesLoading) {
                      LoadingDialog.showLoadingDialog(context);
                    }
                    if (state is TeacherClassesLoaded) {
                      Navigator.of(context).pop(true);
                    }
                    if (state is TeacherClassesError) {
                      Fluttertoast.showToast(msg: state.error!);
                      Navigator.of(context).pop(true);
                    }
                  },
                  builder: (context, state) {
                    return CustomDropDown(
                      hintText: 'Classes',
                      onChanged: (value) {
                        print(value);
                        // slectedClass = value.toString();
                      },
                      itemsMap: state is TeacherClassesLoaded
                          ? state.classes.data!.map((e) {
                              return DropdownMenuItem(
                                value: e.id,
                                child: Text(
                                  "${e.name}",
                                ),
                                onTap: () {
                                  classId = e.id.toString();
                                  setState(() {});
                                },
                              );
                            }).toList()
                          : [].map((e) {
                              return DropdownMenuItem(
                                value: e.id,
                                child: Text(
                                  "",
                                ),
                              );
                            }).toList(),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
