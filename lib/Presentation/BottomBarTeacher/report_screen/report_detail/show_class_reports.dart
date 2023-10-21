import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/class_reports_cubit.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/get_teacher_subject_cubit.dart';
import 'package:school_system/Presentation/BottomBarTeacher/add_report/teacher_subject_select.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_app_bar.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/Presentation/utils/custom_widget/navigator_pop.dart';

class TeacherReportDetail extends StatefulWidget {
  const TeacherReportDetail(
      {Key? key, required this.id, required this.className})
      : super(key: key);

  final String? id;
  final String className;

  @override
  State<TeacherReportDetail> createState() => _TeacherReportDetailState();
}

class _TeacherReportDetailState extends State<TeacherReportDetail> {
  @override
  void initState() {
    context.read<ClassReportsCubit>().getReports(widget.id!);

    // TODO: implement initState
    super.initState();
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return TeacherAddReport(
                id: widget.id!,
                className: widget.className,
              );
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<ClassReportsCubit, ClassReportsState>(
        listener: (context, state) {
          if (state is ClassReportsLoading) {
            LoadingDialog.showLoadingDialog(context);
          }
          if (state is ClassReportsLoaded) {
            Navigator.pop(context);
          }
          if (state is ClassReportsError) {
            Fluttertoast.showToast(msg: state.error!);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is ClassReportsLoaded) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              children: [
                SizedBox(
                  height: 50.h,
                ),
                const NavigatorPop(),
                SizedBox(
                  height: 10.h,
                ),
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
                  height: 15.sp,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 70.sp,
                        padding: const EdgeInsets.all(12),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFD6F4EA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: MyText(
                                      'Total Reports',
                                      color: const Color(0xFF6B7280),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.75,
                                    ),
                                  ),
                                  Flexible(
                                    child: MyText(
                                      '${state.counts ?? ""} Reports',
                                      color: const Color(0xFF000600),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 16.sp,
                              height: 16.sp,
                              child: const Icon(
                                Icons.more_vert,
                                color: Color(0xff6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.sp,
                    ),
                    Expanded(
                      child: Container(
                        height: 70.sp,
                        padding: const EdgeInsets.all(12),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFFEEF5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: MyText(
                                      'Published Reports',
                                      color: const Color(0xFF6B7280),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.75,
                                    ),
                                  ),
                                  Flexible(
                                    child: MyText(
                                      '${state.published ?? ""} Reports',
                                      color: const Color(0xFF000600),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 16.sp,
                              height: 16.sp,
                              child: const Icon(
                                Icons.more_vert,
                                color: Color(0xff6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyTextField(
                        controller: searchController,
                        filledColor: Color(0xFFF3F4F6),
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    SizedBox(
                      width: 6.sp,
                    ),
                    Container(
                      width: 44.sp,
                      height: 44.sp,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF3F4F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(AppImages.setting),
                      ),
                    )
                  ],
                ),
                state.reports!.isNotEmpty
                    ? SizedBox(
                        width: 1.sw,
                        height: 0.50.sh,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.reports!.length,
                          itemBuilder: (context, index) {
                            return ReportTile(
                              published: state.reports![index].points,
                              quarter: state.reports![index].quarter!.name,
                              year: state.reports![index].sessionYear,
                            );
                          },
                        ),
                      )
                    : Center(
                        child: MyText(
                          'Reports not found',
                          fontSize: 18.sp,
                          color: Colors.black,
                        ),
                      ),
              ],
            );
          } else if (state is ClassReportsError) {
            return Center(
              child: MyText(
                state.error!,
                fontSize: 18.sp,
                color: Colors.black,
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class ReportTile extends StatelessWidget {
  const ReportTile({Key? key, this.published, this.quarter, this.year})
      : super(key: key);
  final String? quarter;
  final String? year;
  final String? published;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 10.sp, right: 10.sp, top: 5.sp, bottom: 5.sp),
      margin: EdgeInsets.only(top: 5.sp, bottom: 5.sp),
      height: 65.h,
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.sp),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  year ?? "",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                Icon(
                  Icons.more_vert,
                  size: 22.sp,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  quarter ?? "",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                published != null
                    ? Container(
                        padding: EdgeInsets.only(
                            left: 10.sp, right: 10.sp, bottom: 5.sp, top: 5.sp),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(14.sp),
                        ),
                        child: MyText(
                          'Published',
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
