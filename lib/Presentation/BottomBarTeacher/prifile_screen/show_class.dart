import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/show_teacher_class_cubit.dart';
import 'package:school_system/Controllers/Services/AdsServices/show_ads.dart';
import 'package:school_system/Presentation/BottomBarParent/profile_screens/show_children.dart';
import 'package:school_system/Presentation/BottomBarTeacher/prifile_screen/teacher_add_clases.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

import 'class_details_screen.dart';

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

  String? role = LoginApiShadePreference.preferences!.getString('role');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff3DAEF5),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return TeacherAddClass();
            },
          ));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      'My Classes',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 3.sp,
                    ),
                    const MyText(
                      'Unleash the potential of students through your classes.',
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
                  child: Image.asset(AppImages.starConfuse)),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          const ShowAds(),
          SizedBox(
            height: 10.h,
          ),
          BlocConsumer<ShowTeacherClassCubit, ShowTeacherClassState>(
            listener: (context, state) {
              if (state is ShowTeacherClassLoading) {
                Dialogs.loadingDialog(context);
              }
              if (state is ShowTeacherClassError) {
                Navigator.pop(context);
                Fluttertoast.showToast(msg: state.error!);
              }
              if (state is ShowTeacherClassLoaded) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is ShowTeacherClassLoaded) {
                return state.clasess.isNotEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: 400.w,
                        child: ListView.separated(
                          padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.clasess.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return role == 'parent'
                                        ? ShowChildren()
                                        : ClassDeatailsScreen(
                                            data: state.clasess,
                                            index: index,
                                          );
                                  },
                                ));
                              },
                              child: Container(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 10.sp),
                                margin:
                                    EdgeInsets.only(bottom: 10.sp, top: 10.sp),
                                height: 120.h,
                                width: double.infinity,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFE2F4FF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 86,
                                      height: 86,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage(AppImages.starConfuse),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: SizedBox(
                                        height: double.infinity,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              height: 81,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8,
                                                        vertical: 2),
                                                    decoration: ShapeDecoration(
                                                      color: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                    ),
                                                    child: Row(
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
                                                                    .clasess
                                                                    [
                                                                        index]
                                                                    .grade ??
                                                                "",
                                                            //'Grade 6',
                                                            color: const Color(
                                                                0xFF3DAEF5),
                                                            fontSize: 14.sp,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Flexible(
                                                    child: MyText(
                                                      // 'Class A',
                                                      state.clasess[index]
                                                              .name ??
                                                          "",

                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: const Color(
                                                          0xFF000600),
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: 50.h,
                                                      width: 0.35.sw,
                                                      child: ListView.builder(
                                                        itemCount: state
                                                            .clasess
                                                            [index]
                                                            .allSubjects!
                                                            .length,
                                                        itemBuilder:
                                                            (context, ind) {
                                                          return Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                width: 6,
                                                                height: 6,
                                                                decoration:
                                                                    ShapeDecoration(
                                                                  color: const Color(
                                                                      0xFF6B7280),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 4),
                                                              Flexible(
                                                                child: MyText(
                                                                  state
                                                                          .clasess
                                                                          [
                                                                              index]
                                                                          .allSubjects?[
                                                                              ind]
                                                                          .subject!
                                                                          .name ??
                                                                      "",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: Color(
                                                                      0xFF6B7280),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            SizedBox(
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 16,
                                                        height: 16,
                                                        child: Stack(
                                                          children: [
                                                            Positioned(
                                                              left: 1.33,
                                                              top: 1.33,
                                                              child: Container(
                                                                width: 13.33,
                                                                height: 13.33,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                    image: AssetImage(
                                                                        AppImages
                                                                            .userImage),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      MyText(
                                                        state.clasess
                                                            [index]
                                                            .classSection!
                                                            .studentsCount
                                                            .toString(),
                                                        color:
                                                            Color(0xFF000600),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox();
                          },
                        ),
                      )
                    : Center(
                        child: MyText(
                          'No have any class',
                          color: Colors.black,
                          fontSize: 20.sp,
                        ),
                      );
              } else if (state is ShowTeacherClassError) {
                return Center(child: Text(state.error!));
              } else {
                return SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}
