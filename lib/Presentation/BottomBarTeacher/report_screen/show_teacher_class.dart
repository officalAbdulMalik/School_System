import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/show_teacher_class_cubit.dart';
import 'package:school_system/Controllers/Services/AdsServices/show_ads.dart';
import 'package:school_system/Presentation/BottomBarTeacher/report_screen/report_detail/show_class_reports.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_app_bar.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';

class TeacherReportScreen extends StatefulWidget {
  TeacherReportScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TeacherReportScreen> createState() => _TeacherReportScreenState();
}

class _TeacherReportScreenState extends State<TeacherReportScreen> {
  @override
  void initState() {
    context.read<ShowTeacherClassCubit>().getClasses();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        children: [
          MyText(
            'Reports',
            color: const Color(0xFF000600),
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
          MyText(
            'Manage all your reports here',
            color: const Color(0xFF6B7280),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
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
                Dialogs.showLoadingDialog(context);
              }
              if (state is ShowTeacherClassLoaded) {
                Navigator.pop(context);
              }
              if (state is ShowTeacherClassError) {
                Fluttertoast.showToast(msg: state.error!);
              }
            },
            builder: (context, state) {
              if (state is ShowTeacherClassLoaded) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: MyText(
                            'My Classes',
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: MyText(
                            state.model.data?.length.toString() ?? "0",
                            color: const Color(0xFF6B7280),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.right,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    state.model.data!.isNotEmpty
                        ? SizedBox(
                            height: 0.75.sh,
                            width: 1.sw,
                            child: GridView.builder(
                                itemCount: state.model.data!.length,
                                shrinkWrap: true,
                                primary: false,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 15.sp,
                                        crossAxisSpacing: 15.sp),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return TeacherReportDetail(
                                            id: state.model.data?[index].id
                                                    .toString() ??
                                                "",
                                            className: state
                                                    .model.data?[index].name
                                                    .toString() ??
                                                "",
                                          );
                                        },
                                      ));
                                    },
                                    child: Container(
                                      width: 163.50,
                                      height: 135,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 16),
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFE2F4FF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'images/satar.png'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: MyText(
                                              state.model.data?[index].name! ??
                                                  "",
                                              color: Colors.black,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Flexible(
                                            child: MyText(
                                              state.model.data?[index].grade ??
                                                  "",
                                              color: const Color(0xFF6B7280),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.75,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )
                        : Center(
                            child: Center(
                              child: MyText(
                                'Class Not Found',
                                fontSize: 18.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                  ],
                );
              } else if (state is ShowTeacherClassError) {
                return Center(
                    child: MyText(
                  state.error!,
                  fontSize: 18.sp,
                  color: Colors.black,
                ));
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
