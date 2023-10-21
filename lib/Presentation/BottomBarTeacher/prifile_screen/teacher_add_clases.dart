import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/get_all_school_cubit.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/get_section_cubit.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/get_subjects_cubit.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/teacher_create_class_cubit.dart';
import 'package:school_system/Presentation/BottomBarTeacher/prifile_screen/show_class.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_dop_down.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/Data/global_list.dart';

import '../../../Data/Repository/teacher_create_class.dart';
import '../../utils/shade_prefrence.dart';
import 'assign_subjects.dart';
import 'create_new_section.dart';
import 'create_new_subject.dart';

class TeacherAddClass extends StatefulWidget {
  TeacherAddClass({Key? key}) : super(key: key);

  @override
  State<TeacherAddClass> createState() => _TeacherAddClassState();
}

ValueNotifier<bool> loading = ValueNotifier(false);

String country = 'United Kingdomw';

String selectedGrade = 'Select Grade';
String selectedSection = '';
String selectedSchool = '';

String language = 'English';

TextEditingController schoolName = TextEditingController();

List<String> uk = [
  "Nursery",
  "Reception",
  "Kindergarten",
  "Year 1",
  "Year 2",
  "Year 3",
  "Year 4",
  "Year 5",
  "Year 6",
  "Year 7",
  "Year 8",
  "Year 9",
  "Year 5",
  "Other",
];
List<String> usa = [
  "Nursery",
  "Pre School",
  "Kindergarten",
  "1st Grade",
  "2nd Grade",
  "3rd Grade",
  "4th Grade",
  "5th Grade",
  "6th Grade",
  "7th Grade",
  "8th Grade",
  "9th Grade",
  "10th Grade",
  "Other",
];

class _TeacherAddClassState extends State<TeacherAddClass> {
  var country = LoginApiShadePreference.preferences!.get('country');

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<GetSectionCubit>().getSections();
    context.read<GetSubjectsCubit>().getSubjects();
    context
        .read<GetAllSchoolCubit>()
        .getAllSchool('/api/get/teacher/schools?name=');
    print(country);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomRowWidget(
                      text1: 'Add New Class',
                      text2: 'Inspire students through a newly added class.',
                      image: 'add_s_star.png',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    MyTextField(
                      hintText: 'Class Name',
                      controller: schoolName,
                      filledColor: kContainerColor,
                      isRequiredField: true,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    BlocBuilder<GetSectionCubit, GetSectionState>(
                      builder: (context, state) {
                        if (state is GetSectionLoaded) {
                          print(state.sections.length);
                          return state.sections.isNotEmpty
                              ? CustomDropDown(
                                  hintText: 'Sections',
                                  onChanged: (value) {
                                    selectedSection = value.toString();
                                  },
                                  itemsMap: state.sections.map((e) {
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
                                    'Sections not found',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                        } else if (state is GetSectionError) {
                          return Text(state.error!);
                        } else {
                          return CustomDropDown(
                            hintText: 'Sections',
                            onChanged: (value) {
                              selectedSection = value.toString();
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
                    BlocConsumer<GetAllSchoolCubit, GetAllSchoolState>(
                      listener: (context, state) {
                        if (state is GetAllSchoolLoading) {
                          LoadingDialog.showLoadingDialog(context);
                        }
                        if (state is GetAllSchoolLoaded) {
                          Navigator.of(context).pop(true);
                        }
                        if (state is GetAllSchoolError) {
                          Fluttertoast.showToast(msg: state.error!);
                        }
                      },
                      builder: (context, state) {
                        return state is GetAllSchoolLoaded
                            ? state.model.isNotEmpty
                                ? CustomDropDown(
                                    hintText: 'Schools',
                                    onChanged: (value) {
                                      print(value);
                                      selectedSchool = value.toString();
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
                                  )
                            : CustomDropDown(
                                hintText: 'Schools',
                                onChanged: (value) {
                                  print(value);
                                  selectedSchool = value.toString();
                                },
                                itemsMap: [].map((e) {
                                  return DropdownMenuItem(
                                    value: e.id,
                                    child: Text(
                                      e.schoolName!,
                                    ),
                                  );
                                }).toList(),
                              );
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomDropDown(
                      hintText: 'Grade',
                      onChanged: (value) {
                        print(value);
                        selectedGrade = value.toString();
                        setState(() {});
                      },
                      itemsMap: country == "US"
                          ? usa.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                ),
                              );
                            }).toList()
                          : uk.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                ),
                              );
                            }).toList(),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 40.h,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return CreateSection();
                                  },
                                ));
                              },
                              child: CustomWidgets.customButton('New Section',
                                  fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            width: 7.w,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return AssignSubjects();
                                  },
                                ));
                              },
                              child: CustomWidgets.customButton(
                                  'Assign Subjects',
                                  fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            width: 7.w,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const CrateNewSubject();
                                  },
                                ));
                              },
                              child: CustomWidgets.customButton(
                                  'Create Subject',
                                  fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<TeacherCreateClassCubit,
                        TeacherCreateClassState>(
                      listener: (context, state) {
                        print(state);
                        if (state is TeacherCreateClassLoading) {
                          LoadingDialog.showLoadingDialog(context);
                        }

                        if (state is TeacherCreateClassError) {
                          Fluttertoast.showToast(msg: state.error!);
                        }
                        if (state is TeacherCreateClassLoaded) {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return TeacherClass();
                            },
                          ));
                        }
                      },
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context.read<TeacherCreateClassCubit>().addClass(
                                  selectedSection,
                                  selectedSchool,
                                  schoolName.text.trim(),
                                  selectedGrade);
                            }
                          },
                          child: CustomWidgets.customButton('Save'),
                        );
                      },
                    ),
                  ]),
                ),
              ))),
    );
  }
}
