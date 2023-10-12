import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/Presentation/bottom_bar_parent/profile_screens/show_children.dart';
import 'package:school_system/Presentation/common/views/add_school_screen.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/controllers/cubits/common_cubit/get_all_school_cubit.dart';
import 'package:school_system/models/get_all_school_model.dart';

import '../../utils/custom_widget/custom_widgets.dart';
import 'add_child_screen.dart';
import 'show_teacher.dart';

class ShowParentSchool extends StatefulWidget {
  const ShowParentSchool({
    super.key,
    required this.studentId,
  });

  final String studentId;

  @override
  State<ShowParentSchool> createState() => _ShowParentSchoolState();
}

class _ShowParentSchoolState extends State<ShowParentSchool> {
  final ValueNotifier<bool> showPassword = ValueNotifier(false);

  String type = '';

  @override
  void initState() {
    context.read<GetAllSchoolCubit>().getAllSchool('/api/parent/schools?name=');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
          children: [
            SizedBox(height: 20.h),
            CustomRowWidget(
              text1: 'Find Your Kids School',
              text2: 'Select Your school from here...',
              image: 'add_s_star.png',
            ),
            SizedBox(
              height: 20.h,
            ),
            BlocBuilder<GetAllSchoolCubit, GetAllSchoolState>(
              builder: (context, state) {
                if (state is GetAllSchoolLoaded) {
                  print(state.model.data![0].image);
                  return SizedBox(
                    height: 500.h,
                    width: 500.w,
                    child: state.model.data!.isNotEmpty
                        ? ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 10.h,
                              );
                            },
                            itemCount: state.model.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(15.sp),
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 15.sp),
                                  height: 80.sp,
                                  padding: EdgeInsets.all(16.sp),
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                        color: Color(0x19303133),
                                        blurRadius: 0,
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        child: state.model.data![index].image!
                                                .isNotEmpty
                                            ? Image.network(state
                                                    .model.data![index].image ??
                                                "")
                                            : const Icon(Icons.school),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: MyText(
                                                  state.model.data?[index]
                                                          .schoolName ??
                                                      "",
                                                  color:
                                                      const Color(0xFF000600),
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 8,
                                                    height: 8,
                                                    decoration: ShapeDecoration(
                                                      color: Color(0xFF6B7280),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    state.model.data![index]
                                                            .address ??
                                                        "",
                                                    style: const TextStyle(
                                                      color: Color(0xFF6B7280),
                                                      fontSize: 14,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      letterSpacing: 0.75,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return SchoolTeacher(
                                                  schoolId: state
                                                      .model.data![index].id
                                                      .toString(),
                                                  studentId: widget.studentId,
                                                );
                                              },
                                            ));
                                          },
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              'No School found',
                              style: GoogleFonts.acme(
                                  color: kPrimaryColor, fontSize: 20.sp),
                            ),
                          ),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
