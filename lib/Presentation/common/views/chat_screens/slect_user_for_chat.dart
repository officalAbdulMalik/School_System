import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/create_chat_cubit.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/get_all_school_cubit.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/get_parents_teachers_cubit.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/get_class_student_cubit.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/show_teacher_class_cubit.dart';
import 'package:school_system/Controllers/firebase_repos/add_chat_message.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/common/views/bottom_bar.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_dop_down.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

import 'chat_screen.dart';

class SelectUserForChat extends StatefulWidget {
  const SelectUserForChat({Key? key}) : super(key: key);

  @override
  State<SelectUserForChat> createState() => _SelectUserForChatState();
}

class _SelectUserForChatState extends State<SelectUserForChat> {
  String? userType = LoginApiShadePreference.preferences!.getString('type');

  @override
  void initState() {
    userType == "teacher"
        ? context.read<ShowTeacherClassCubit>().getClasses()
        : context
            .read<GetClassStudentCubit>()
            .getStudent('/api/students?class_id=&last_name=&first_name=');
    // TODO: implement initState
    super.initState();
  }

  String? userId = LoginApiShadePreference.preferences!.getString('user_id');

  // this is the outer user data to create chat with this
  String? outerId;
  // ParentsTeachers? user;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<CreateChatCubit, CreateChatState>(
        listener: (context, state) {
          if (state is CreateChatLoading) {
            Dialogs.loadingDialog(context);
          }
          if (state is CreateChatLoaded) {
            Navigator.pop(context);
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const BottomBarPages(index: 2);
              },
            ));
          }
          if (state is CreateChatError) {
            Fluttertoast.showToast(msg: state.error!);
          }
          // TODO: implement listener
        },
        child: Scaffold(
            bottomNavigationBar: Padding(
              padding: EdgeInsets.all(10.0.sp),
              child: CustomWidgets.customButton('Start Chat', onTap: () {  }),
            ),
            body: ListView(
              padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
              children: [
                SizedBox(
                  height: 30.h,
                ),
                CustomRowWidget(
                  text1: 'Start New Chat',
                  text2: 'Start new chat here.',
                  image: 'add_s_star.png',
                ),
                SizedBox(
                  height: 20.h,
                ),
                userType == 'teacher'
                    ? BlocConsumer<ShowTeacherClassCubit,
                        ShowTeacherClassState>(
                        listener: (context, state) {
                          if (state is ShowTeacherClassLoading) {
                            Dialogs.loadingDialog(context);
                          }
                          if (state is ShowTeacherClassLoaded) {
                            Navigator.pop(context);
                          }
                        },
                        builder: (context, state) {
                          if (state is ShowTeacherClassLoaded) {
                            return state.clasess.isNotEmpty
                                ? CustomDropDown(
                                    hintText: 'Class',
                                    onChanged: (value) {
                                      print(value);
                                      context
                                          .read<GetParentsTeachersCubit>()
                                          .getParentsTeachers(
                                              '/api/teacher/student/parents?student_id=$value');
                                    },
                                    itemsMap: state.clasess.map((e) {
                                      return DropdownMenuItem(
                                        value: e.id,
                                        child: Text(
                                          e.name!,
                                        ),
                                      );
                                    }).toList(),
                                  )
                                : Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Class Not found',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                          } else if (state is ShowTeacherClassError) {
                            return Text(state.error!);
                          } else {
                            return const SizedBox();
                          }
                        },
                      )
                    : BlocConsumer<GetClassStudentCubit, GetClassStudentState>(
                        listener: (context, state) {
                          if (state is GetClassStudentLoading) {
                            Dialogs.loadingDialog(context);
                          }
                          if (state is GetClassStudentLoaded) {
                            Navigator.pop(context);
                          }
                        },
                        builder: (context, state) {
                          if (state is GetClassStudentLoaded) {
                            return state.model!.isNotEmpty
                                ? CustomDropDown(
                                    hintText: 'Student',
                                    onChanged: (value) {
                                      print(value);
                                      context
                                          .read<GetParentsTeachersCubit>()
                                          .getParentsTeachers(
                                              '/api/parent/student/teachers?student_id=$value');
                                    },
                                    itemsMap: state.model!.map((e) {
                                      return DropdownMenuItem(
                                        value: e.id,
                                        child: Text(
                                          e.firstName!,
                                        ),
                                      );
                                    }).toList(),
                                  )
                                : Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Students Not found',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  );
                          } else if (state is GetClassStudentError) {
                            return Text(state.error!);
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                SizedBox(
                  height: 10.h,
                ),
                // BlocConsumer<GetParentsTeachersCubit, GetAllParentsState>(
                //   listener: (context, state) {
                //     if (state is GetAllParentsLoading) {
                //       Dialogs.loadingDialog(context);
                //     }
                //
                //     if (state is GetAllParentsLoaded) {
                //       // list = state.model;
                //
                //       Navigator.pop(context);
                //     }
                //     if (state is GetAllParentsError) {
                //       Fluttertoast.showToast(msg: state.error!);
                //       Navigator.pop(context);
                //     }
                //   },
                //   builder: (context, state) {
                //     if (state is GetAllParentsLoaded) {
                //
                //
                //       return state.model!.isNotEmpty
                //           ? CustomDropDown(
                //               hintText: 'Parent Teacher',
                //               itemsMap: state.model!.map((e) {
                //                 return DropdownMenuItem(
                //                   value: e.id,
                //                   child: Text(
                //                     e.firstName!,
                //                   ),
                //                 );
                //               }).toList(),
                //               onChanged: (value) {
                //                 outerId = value.toString();
                //                 // user = state.model
                //                 //     .firstWhere((user) => user.id == value);
                //                 setState(() {});
                //               },
                //             )
                //           : Center(
                //               child: Text(
                //                 "No Data Found",
                //                 style: GoogleFonts.acme(
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.w400,
                //                   fontSize: 16.sp,
                //                 ),
                //               ),
                //             );
                //     } else if (state is GetAllParentsError) {
                //       return const Center(child: Text('error' ?? ''));
                //     } else {
                //       return SizedBox();
                //     }
                //   },
                // ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            )),
      ),
    );
  }
}
