import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/add_section_cubit.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/get_sessions_cubit.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/get_subjects_cubit.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/show_teacher_class_cubit.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/container_decoration.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_dop_down.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';

import '../../utils/custom_widget/custom_widgets.dart';

class AssignSubjects extends StatefulWidget {
  AssignSubjects({Key? key}) : super(key: key);

  @override
  State<AssignSubjects> createState() => _AssignSubjectsState();
}

class _AssignSubjectsState extends State<AssignSubjects> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String selectedSchool = '';
  String selectedSubject = '';

  String selectedSection = '';

  final formKey = GlobalKey<FormState>();

  ValueNotifier<bool> loading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
          children: [
            SizedBox(
              height: 30.h,
            ),
            CustomRowWidget(
              text1: 'Assign Subject',
              text2: 'You can assign subject to your class...',
              image: 'add_s_star.png',
            ),
            SizedBox(
              height: 20.h,
            ),
            BlocConsumer<GetSubjectsCubit, GetSubjectsState>(
              listener: (context, state) {
                if (state is GetSessionsLoading) {
                  LoadingDialog.showLoadingDialog(context);
                }
                if (state is GetSubjectsLoaded) {
                  Navigator.of(context).pop(true);
                }
              },
              builder: (context, state) {
                print(state);
                if (state is GetSubjectsLoaded) {
                  print(state.data);
                  return state.data!.isNotEmpty
                      ? CustomDropDown(
                          hintText: 'Subject',
                          onChanged: (value) {
                            selectedSubject = value.toString();
                          },
                          itemsMap: state.data!.map((e) {
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
                            'Subject not found',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                } else if (state is GetSubjectsError) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Subject not found',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                } else {
                  return CustomDropDown(
                    hintText: 'Subject',
                    onChanged: (value) {
                      selectedSubject = value.toString();
                    },
                    itemsMap: [].map((e) {
                      return DropdownMenuItem(
                        value: e.id,
                        child: Text(
                          e.name!,
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            BlocBuilder<ShowTeacherClassCubit, ShowTeacherClassState>(
              builder: (context, state) {
                if (state is ShowTeacherClassLoaded) {
                  print(state.model.data!.length);
                  return state.model.data!.isNotEmpty
                      ? CustomDropDown(
                          hintText: 'Classes',
                          onChanged: (value) {
                            print(value);
                            selectedSchool = value.toString();
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
                  return CustomDropDown(
                    hintText: 'Classes',
                    onChanged: (value) {
                      print(value);
                      selectedSchool = value.toString();
                    },
                    itemsMap: [].map((e) {
                      return DropdownMenuItem(
                        value: e.id,
                        child: Text(
                          e.name!,
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            BlocConsumer<AddSectionCubit, AddSectionState>(
              listener: (context, state) {
                if (state is AddSectionError) {
                  Fluttertoast.showToast(msg: state.error!);
                }
                if (state is AddSectionLoaded) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is AddSectionLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context
                            .read<AddSectionCubit>()
                            .addSubjectToClass(selectedSubject, selectedSchool);
                      }
                    },
                    child: CustomWidgets.customButton('Save'),
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
