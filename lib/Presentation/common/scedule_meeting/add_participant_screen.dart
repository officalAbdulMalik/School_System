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
import 'package:school_system/Data/app_const.dart';
import 'package:school_system/Models/TeacherModels/teacher_classes.dart';
import 'package:school_system/Models/participations.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_dop_down.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/multi_item_picker.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:school_system/models/get_all_school_model.dart';

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

  List<Participation>? list;


  List<Classes>? classes;
  List<Schools>? schools;




  List? selected;

  String selectedClass = '';



  var myValue = false;

  List<String> listofParticipent = [];


  String? type = LoginApiShadePreference.preferences!.getString('type');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(vertical:10.0.sp,horizontal: 10.sp),
            child: CustomWidgets.customButton(
              'Continue',
              buttonColor: kPrimaryColor, onTap: () {
              print(listofParticipent.toString());
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return AddMeetingScreen(
                    ids: listofParticipent,
                  );
                },
              ));
            },
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
                              Dialogs.loadingDialog(context);
                            }
                            if (state is ShowTeacherClassLoaded) {
                              Navigator.pop(context);
                              classes = state.clasess;
                            }
                          },
                          builder: (context, state) {
                           return CustomDropDown(
                              hintText: 'Classes',
                              onChanged: (value) {
                                log(value.toString());
                                context
                                    .read<GetParentsTeachersCubit>()
                                    .getParentsTeachers(
                                    '/api/teacher/class/parents?class_id=$value');
                              },
                              itemsMap: classes!.map((e) {
                                return DropdownMenuItem(
                                  value: e.id,
                                  child: Text(
                                    e.name!,
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        )
                      : BlocConsumer<GetAllSchoolCubit, GetAllSchoolState>(
                    listener: (context, state) {

                      print(state);

                      if(state is GetAllSchoolLoading){
                        Dialogs.loadingDialog(context);
                      }
                      if(state is GetAllSchoolLoaded){
                        Navigator.of(context).pop(true);
                        schools = state.model;
                      }
                      if(state is GetAllSchoolError){
                        Fluttertoast.showToast(msg: state.error??"");
                      }
                    },
                          builder: (context, state) {
                            return schools != null? CustomDropDown(
                              hintText: 'School',
                              onChanged: (value) {
                                context
                                    .read<GetParentsTeachersCubit>()
                                    .getParentsTeachers(
                                    '/api/parent/school/teachers?school_id=$value');
                              },
                              itemsMap: schools!.map((e) {
                                return DropdownMenuItem(
                                  value: e.id,
                                  child: Text(
                                    e.schoolName!,
                                  ),
                                );
                              }).toList(),
                            ):const SizedBox();
                          },
                        ),
                  SizedBox(
                    height: 10.h,
                  ),
                  BlocConsumer<GetParentsTeachersCubit, GetAllParentsState>(
                    listener: (context, state) {
                      if (state is GetAllParentsLoading) {
                        Dialogs.loadingDialog(context);
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
                      return state is GetAllParentsLoaded?  MultiItemPicker(list: (list) {
                        print(list);
                        listofParticipent  = list.map((item) => item.id.toString()).toList();
                      }, getList: list ?? [], hintText: 'Select Participation',isParentSide: type == "parent",):const SizedBox();
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
