import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/controllers/cubits/common_cubit/get_parents_teachers_cubit.dart';
import 'package:school_system/controllers/cubits/parent_cubit/get_school_teacher_cubit.dart';
import 'package:school_system/models/teacher_parents_data_model.dart';

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
    context.read<GetSchoolTeacherCubit>().getTeacher(widget.schoolId);
    // TODO: implement initState
    super.initState();
  }

  var selectedSchool;

  List<bool>? checkboxStates;
  List? list;

  var myValue = false;

  List<String> listofParticipent = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: BlocConsumer<GetSchoolTeacherCubit, GetSchoolTeacherState>(
          listener: (context, state) {
            if (state is GetSchoolTeacherLoaded) {
              list = state.teachers.data!.map((e) => e.id).toList();
              print(list);
              checkboxStates = List.generate(list!.length, (index) => false);
            }
          },
          builder: (context, state) {
            if (state is GetSchoolTeacherLoading) {
              print('loding call');
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.blue,
              ));
            } else if (state is GetSchoolTeacherLoaded) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      height: 10.h,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            'Select All Participant',
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          MyText(
                            '${state.teachers.data!.length} Participants',
                            color: Color(0xFF6B7280),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.right,
                          ),
                        ]),
                    SizedBox(
                      height: 10.h,
                    ),
                    state.teachers.data!.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: state.teachers.data!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 343,
                                    height: 52,
                                    padding: const EdgeInsets.all(8),
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
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
                                              mainAxisSize: MainAxisSize.min,
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
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Checkbox(
                                                          value:
                                                              checkboxStates![
                                                                  index],
                                                          onChanged: (val) {
                                                            checkboxStates![
                                                                    index] =
                                                                !checkboxStates![
                                                                    index];

                                                            print(list![index]);

                                                            if (listofParticipent
                                                                .contains(list![
                                                                        index]
                                                                    .toString())) {
                                                              listofParticipent
                                                                  .remove(list![
                                                                          index]
                                                                      .toString());
                                                            } else {
                                                              listofParticipent
                                                                  .add(list![
                                                                          index]
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
                                                                        .teachers
                                                                        .data?[
                                                                            index]
                                                                        .image !=
                                                                    null
                                                                ? NetworkImage(
                                                                    state
                                                                        .teachers
                                                                        .data![
                                                                            index]
                                                                        .image!)
                                                                : AssetImage(
                                                                        AppImages
                                                                            .profile)
                                                                    as ImageProvider,
                                                            fit: BoxFit.fill,
                                                          ),
                                                          shape:
                                                              const OvalBorder(),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Flexible(
                                                              child: MyText(
                                                                state
                                                                        .teachers
                                                                        .data?[
                                                                            index]
                                                                        .firstName! ??
                                                                    "",
                                                                color: const Color(
                                                                    0xFF000600),
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            Flexible(
                                                              child: MyText(
                                                                state
                                                                        .teachers
                                                                        .data?[
                                                                            index]
                                                                        .lastName! ??
                                                                    "",
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 10.sp,
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
                                }))
                        : Center(
                            child: Text(
                              "No Data Found",
                              style: GoogleFonts.acme(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                    InkWell(
                      onTap: () {
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
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              );
            } else if (state is GetSchoolTeacherError) {
              return const Center(child: Text('error' ?? ''));
            } else {
              return SizedBox();
            }
          },
        ));
  }
}
