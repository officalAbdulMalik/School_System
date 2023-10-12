import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Presentation/bottom_bar_techer/teacher_report_card/teacher_report_card_screen.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_dop_down.dart';
import 'package:school_system/controllers/cubits/teacher_cubit/get_querters_cubit.dart';
import 'package:school_system/controllers/cubits/teacher_cubit/get_sessions_cubit.dart';
import 'package:school_system/controllers/cubits/teacher_cubit/get_teacher_subject_cubit.dart';
import 'package:school_system/controllers/cubits/teacher_cubit/show_teacher_class_cubit.dart';

import '../../utils/app_images.dart';
import '../../utils/custom_widget/my_text.dart';

class TeacherAddReport extends StatefulWidget {
  TeacherAddReport({Key? key, required this.id, required this.className})
      : super(key: key);

  String id;
  String className;

  @override
  State<TeacherAddReport> createState() => _TeacherAddReportState();
}

class _TeacherAddReportState extends State<TeacherAddReport> {
  String selectedSubject = '';
  String year = '';
  String term = '';

  List<String> classes = [
    "Nursery",
    "Pre School",
    "Kindergarten",
    "1st Grade",
    "2nd Grade",
    "3rd Grade",
    "4th Grade",
    " 5th Grade",
    "6th Grade",
    "7th Grade",
    " 8th Grade",
    "9th Grade",
    "10th Grade",
    "Other",
  ];
  List<String> years = [];
  List<String> terms = [
    "Term 1",
    "Term 2",
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<GetTeacherSubjectCubit>().getSubject(widget.id);
    context.read<GetQuertersCubit>().getQuarters();
    context.read<GetSessionsCubit>().getSessions();

    int currentYear = DateTime.now().year;

    // Populate the list with the next 15 years
    for (int i = currentYear - 5; i <= currentYear + 5; i++) {
      years.add(i.toString());
    }

    print(years);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                'Create Report Card',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                height: 3.sp,
                              ),
                              const MyText(
                                'You can create student report cards share',
                                color: Color(0xFF6B7280),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            width: 86.sp,
                            height: 86.sp,
                            child: Image.asset(AppImages.glassesStarBig)),
                      ],
                    ),
                    SizedBox(
                      height: 39.sp,
                    ),
                    BlocBuilder<GetTeacherSubjectCubit, GetTeacherSubjectState>(
                      builder: (context, state) {
                        if (state is GetTeacherSubjectLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          );
                        } else if (state is GetTeacherSubjectLoaded) {
                          return state.subjects.data!.isNotEmpty
                              ? CustomDropDown(
                                  hintText: 'Subject',
                                  onChanged: (value) {
                                    print(value);
                                    selectedSubject = value.toString();
                                    setState(() {});
                                  },
                                  itemsMap: state.subjects.data!.map((e) {
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
                                    'Subject  not found',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                        } else if (state is GetTeacherSubjectError) {
                          return Text(state.error!);
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    SizedBox(
                      height: 16.sp,
                    ),
                    BlocBuilder<GetQuertersCubit, GetQuertersState>(
                      builder: (context, state) {
                        if (state is GetQuertersLoaded) {
                          return Row(
                            children: [
                              // Expanded(
                              //     child: CustomDropDown(
                              //   hintText: 'Year',
                              //   onChanged: (value) {
                              //     print(value);
                              //     year = value.toString();
                              //     setState(() {});
                              //   },
                              //   itemsMap: years.map((e) {
                              //     return DropdownMenuItem(
                              //       value: e,
                              //       child: Text(
                              //         e,
                              //       ),
                              //     );
                              //   }).toList(),
                              // )),

                              // issue in api
                              Expanded(
                                child: BlocBuilder<GetSessionsCubit,
                                    GetSessionsState>(
                                  builder: (context, state) {
                                    if (state is GetSessionsLoaded) {
                                      return CustomDropDown(
                                        hintText: 'Year',
                                        onChanged: (value) {
                                          print(value);
                                          year = value.toString();
                                        },
                                        itemsMap: state.data!.map((e) {
                                          return DropdownMenuItem(
                                            value: e.id,
                                            child: Text(
                                              e.name!,
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 8.sp,
                              ),
                              Expanded(
                                child: CustomDropDown(
                                  hintText: 'Quarter',
                                  onChanged: (value) {
                                    print(value);
                                    term = value.toString();
                                    setState(() {});
                                  },
                                  itemsMap: state.list!.map((e) {
                                    return DropdownMenuItem(
                                      value: e.id,
                                      child: Text(
                                        e.name!,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return TeacherReportCardScreen(
                          querter: term,
                          sesion: year,
                          className: widget.className,
                          id: widget.id,
                          subjectId: selectedSubject,
                        );
                      },
                    ));
                  }
                },
                child: Container(
                  width: 1.sw,
                  height: 45.sp,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3DAEF5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: MyText(
                    'Continue',
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 32.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
