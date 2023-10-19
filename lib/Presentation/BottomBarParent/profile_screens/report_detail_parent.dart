import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/students_reports_cubit.dart';
import 'package:school_system/Presentation/BottomBarParent/profile_screens/show_report_sreen.dart';
import 'package:school_system/Presentation/common/resources/loading_dialog.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/models/students_reports.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/app_images.dart';
import '../../utils/custom_widget/my_text.dart';

class ReportDetailParent extends StatefulWidget {
  const ReportDetailParent(
      {Key? key, this.stdId, this.className, this.studentName})
      : super(key: key);

  final String? stdId;
  final String? studentName;
  final String? className;

  @override
  State<ReportDetailParent> createState() => _ReportDetailParentState();
}

class _ReportDetailParentState extends State<ReportDetailParent> {
  @override
  void initState() {
    context.read<StudentsReportsCubit>().getReports(widget.stdId!);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocConsumer<StudentsReportsCubit, StudentsReportsState>(
        listener: (context, state) {
          if (state is StudentsReportsLoading) {
            LoadingDialog.showLoadingDialog(context);
          }
          if (state is StudentsReportsLoaded) {
            Navigator.pop(context);
          }
          if (state is StudentsReportsError) {
            Navigator.pop(context);
            Fluttertoast.showToast(msg: state.error!);
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is StudentsReportsLoaded) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      'Reports Details',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 3.sp,
                    ),
                    const MyText(
                      'View your kids reports details.',
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
                SizedBox(
                  height: 32.sp,
                ),
                ReportCard(
                  studentName: widget.studentName ?? "",
                  className: widget.className ?? "",
                  id: '',
                ),
                SizedBox(
                  height: 20.sp,
                ),
                state.reports!.isNotEmpty
                    ? Container(
                        height: 34.sp,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.sp, vertical: 8.sp),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF3F4F6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: MyText(
                                state.reports?[0].quarter?.name ?? " ",
                                color: Color(0xFF000600),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: MyText(
                                state.reports?[0].sessionYear ?? "",
                                color: Color(0xFF000600),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                SizedBox(
                  height: 10.h,
                ),
                state.reports!.isNotEmpty
                    ? Container(
                        padding: EdgeInsets.only(top: 10.sp),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x19303133),
                              blurRadius: 30,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(
                            labelRotation: -95,
                            arrangeByIndex: true,
                          ),
                          series: <ChartSeries<AllReports, String>>[
                            ColumnSeries<AllReports, String>(
                              dataSource: state.reports!,
                              xValueMapper: (AllReports mark, _) =>
                                  mark.subject!.name,
                              yValueMapper: (AllReports mark, _) =>
                                  int.parse(mark.points!),
                              name: 'Marks',
                              pointColorMapper: (AllReports mark, _) {
                                // Customize the color based on the marks here
                                if (int.parse(mark.points!) >= 90) {
                                  return kIndex5Color; // Color for marks >= 90
                                } else if (int.parse(mark.points!) >= 80) {
                                  return kPrimaryColor; // Color for marks >= 70
                                } else if (int.parse(mark.points!) >= 70) {
                                  return kIndex2Color; // Color for marks < 70
                                } else if (int.parse(mark.points!) >= 60) {
                                  return kIndex4Color; // Color for marks < 70
                                } else if (int.parse(mark.points!) >= 50) {
                                  return kIndex5Color;
                                } else {
                                  return kIndex3Color;
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: MyText(
                          'Reports Not found',
                          fontSize: 18.sp,
                        ),
                      ),
                SizedBox(
                  height: 10.h,
                ),
                state.reports!.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: kIndex3Color,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: const Center(
                                child: MyText(
                              '>50% \n1',
                              textAlign: TextAlign.center,
                              color: Colors.white,
                            )),
                          ),
                          Container(
                            height: 40.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: kIndex2Color,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: const Center(
                                child: MyText(
                              '>50 - 60% \n1',
                              textAlign: TextAlign.center,
                              color: Colors.white,
                            )),
                          ),
                          Container(
                            height: 40.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: kIndex4Color,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: const Center(
                                child: MyText(
                              '60 - 75% \n1',
                              textAlign: TextAlign.center,
                              color: Colors.white,
                            )),
                          ),
                          Container(
                            height: 40.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: kIndex5Color,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: const Center(
                                child: MyText(
                              '75 - 85% \n1',
                              textAlign: TextAlign.center,
                              color: Colors.white,
                            )),
                          ),
                          Container(
                            height: 40.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: const Center(
                                child: MyText(
                              '>85% \n4',
                              textAlign: TextAlign.center,
                              color: Colors.white,
                            )),
                          ),
                        ],
                      )
                    : SizedBox(),
                SizedBox(
                  height: 10.h,
                ),
                for (int i = 0; i < state.reports!.length; i++)
                  ReportDetailCard(
                    marks: state.reports?[i].points ?? "",
                    subject: state.reports?[i].subject?.name ?? "",
                    grade: state.reports?[i].grade ?? "",
                  )
              ],
            );
          } else if (state is StudentsReportsError) {
            return Center(
              child: MyText(
                state.error!,
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
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

class ReportDetailCard extends StatelessWidget {
  final String subject;
  final String marks;
  final String grade;

  const ReportDetailCard(
      {Key? key,
      required this.marks,
      required this.subject,
      required this.grade})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.sp,
      child: Row(
        children: [
          Container(
            width: 32.sp,
            height: 32.sp,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.bookIcon),
                fit: BoxFit.fill,
              ),
              shape: OvalBorder(),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: MyText(
                          subject,
                          color: Color(0xFF000600),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Flexible(
                        child: MyText(
                          'Arman Malik',
                          color: Colors.black,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20.sp,
                        height: 20.sp,
                        child: SvgPicture.asset(AppImages.report),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 20.sp,
                        height: 20.sp,
                        child: SvgPicture.asset(AppImages.chatComment),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 100.sp,
                height: 26.sp,
                padding:
                    const EdgeInsets.only(top: 4, left: 4, right: 8, bottom: 4),
                decoration: ShapeDecoration(
                  color: const Color(0xFFE2F4FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: MyText(
                        marks,
                        color: const Color(0xFF6B7280),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.75,
                      ),
                    ),
                    Flexible(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 16.sp,
                          height: 16.sp,
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: OvalBorder(),
                          ),
                          child: Center(
                            child: Text(
                              'A',
                              style: TextStyle(
                                color: const Color(0xFF000600),
                                fontSize: 12.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.75,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
