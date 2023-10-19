import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/get_all_school_cubit.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/get_parents_teachers_cubit.dart';
import 'package:school_system/Controllers/Cubits/ParentCubit/get_school_teacher_cubit.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/show_teacher_class_cubit.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_dop_down.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

import '../../utils/app_images.dart';
import '../../utils/custom_widget/my_text.dart';
import 'add_meeting_screen.dart';

class AddParticipantScreen extends StatefulWidget {
  AddParticipantScreen({Key? key, required this.schoolId}) : super(key: key);

  String schoolId;

  @override
  State<AddParticipantScreen> createState() => _AddParticipantScreenState();
}

class _AddParticipantScreenState extends State<AddParticipantScreen> {
  @override
  void initState() {
    // context.read<GetSchoolTeacherCubit>().getTeacher(widget.schoolId);
    context.read<ShowTeacherClassCubit>().getClasses();
    context.read<GetAllSchoolCubit>().getAllSchool('/api/get/schools');
    context.read<GetParentsTeachersCubit>().emitFirstState();

    // TODO: implement initState
    super.initState();
  }

  var selectedSchool;

  List? list;

  String selectedClass = '';

  var myValue = false;

  List<String> listofParticipent = [];

  String? type = LoginApiShadePreference.preferences!.getString('type');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: InkWell(
              onTap: () {
                print(listofParticipent.toString());
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return AddMeetingScreen(
                      ids: listofParticipent,
                    );
                  },
                ));
              },
              child: CustomWidgets.customButton(
                'Continue',
                buttonColor: kPrimaryColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  MyText(
                    'Add Participants',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 3.sp,
                  ),
                  const MyText(
                    'You can add meeting participants here.',
                    color: Color(0xFF6B7280),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  type == "teacher"
                      ? BlocConsumer<ShowTeacherClassCubit,
                          ShowTeacherClassState>(
                          listener: (context, state) {
                            if (state is ShowTeacherClassLoading) {
                              LoadingDialog.showLoadingDialog(context);
                            }
                            if (state is ShowTeacherClassLoaded) {
                              Navigator.pop(context);
                            }
                          },
                          builder: (context, state) {
                            if (state is ShowTeacherClassLoaded) {
                              print(state.model.data!.length);
                              return state.model.data!.isNotEmpty
                                  ? CustomDropDown(
                                      hintText: 'Classes',
                                      onChanged: (value) {
                                        log(value.toString());
                                        context
                                            .read<GetParentsTeachersCubit>()
                                            .getParentsTeachers(
                                                '/api/teacher/class/parents?class_id=$value');
                                      },
                                      itemsMap: state.model.data!.map((e) {
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
                                        'Class not found',
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
                      : BlocBuilder<GetAllSchoolCubit, GetAllSchoolState>(
                          builder: (context, state) {
                            if (state is GetAllSchoolLoaded) {
                              return state.model.isNotEmpty
                                  ? CustomDropDown(
                                      hintText: 'School',
                                      onChanged: (value) {
                                        context
                                            .read<GetParentsTeachersCubit>()
                                            .getParentsTeachers(
                                                '/api/parent/school/teachers?school_id=$value');
                                      },
                                      itemsMap: state.model.map((e) {
                                        return DropdownMenuItem(
                                          value: e.id,
                                          child: Text(
                                            e.schoolName!,
                                          ),
                                        );
                                      }).toList(),
                                    )
                                  : Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'School not found',
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    );
                            } else if (state is GetAllSchoolError) {
                              return Text(state.error!);
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                  SizedBox(
                    height: 10.h,
                  ),
                  BlocConsumer<GetParentsTeachersCubit, GetAllParentsState>(
                    listener: (context, state) {
                      if (state is GetAllParentsLoading) {
                        LoadingDialog.showLoadingDialog(context);
                      }

                      if (state is GetAllParentsLoaded) {
                        list = state.model;

                        Navigator.pop(context);
                      }
                      if (state is GetAllParentsError) {
                        Fluttertoast.showToast(msg: state.error!);
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      if (state is GetAllParentsLoaded) {
                        print(state.model.length);

                        return state.model.isNotEmpty
                            ? SizedBox(
                                height: 0.65.sh,
                                width: 1.sw,
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.model.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            top: 5.sp, bottom: 5.sp),
                                        width: 343,
                                        height: 52,
                                        padding: const EdgeInsets.all(8),
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                height: 36,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    //const SizedBox(width: 12),
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Checkbox(
                                                              value: state
                                                                      .checkList[
                                                                  index],
                                                              onChanged: (val) {
                                                                state.checkList[
                                                                        index] =
                                                                    !state.checkList[
                                                                        index];

                                                                if (listofParticipent
                                                                    .contains(state
                                                                        .model[
                                                                            index]
                                                                        .id
                                                                        .toString())) {
                                                                  listofParticipent
                                                                      .remove(state
                                                                          .model[
                                                                              index]
                                                                          .id
                                                                          .toString());
                                                                } else {
                                                                  listofParticipent
                                                                      .add(state
                                                                          .model[
                                                                              index]
                                                                          .id
                                                                          .toString());
                                                                }

                                                                // widget.list(list);

                                                                print(
                                                                    'this is the value $listofParticipent');

                                                                // newList = list;
                                                                //
                                                                // widget.list(list);
                                                                //
                                                                // myValue = !myValue;

                                                                setState(() {});
                                                              }),
                                                          Container(
                                                            width: 32,
                                                            height: 32,
                                                            decoration:
                                                                ShapeDecoration(
                                                              image:
                                                                  DecorationImage(
                                                                image: state
                                                                            .model[
                                                                                index]
                                                                            .image !=
                                                                        null
                                                                    ? NetworkImage(state
                                                                        .model[
                                                                            index]
                                                                        .image!)
                                                                    : AssetImage(
                                                                            AppImages.profile)
                                                                        as ImageProvider,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                              shape:
                                                                  const OvalBorder(),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 8),
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Flexible(
                                                                  child: MyText(
                                                                    state.model[index]
                                                                            .firstName! ??
                                                                        "",
                                                                    color: const Color(
                                                                        0xFF000600),
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  child: MyText(
                                                                    state.model[index]
                                                                            .lastName! ??
                                                                        "",
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        10.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            const Icon(
                                              Icons.more_vert,
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              )
                            : Center(
                                child: Text(
                                  "No Data Found",
                                  style: GoogleFonts.acme(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              );
                      } else if (state is GetSchoolTeacherError) {
                        return const Center(child: Text('error' ?? ''));
                      } else if (state is GetAllParentsFirstState) {
                        return const Center(child: Text('' ?? ''));
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
