import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/get_class_student_cubit.dart';
import 'package:school_system/Controllers/Services/AdsServices/show_ads.dart';
import 'package:school_system/Presentation/BottomBarParent/profile_screens/report_detail_parent.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/models/get_class_student_model.dart';
import '../../common/resources/loading_dialog.dart';
import '../../utils/app_images.dart';
import '../../utils/custom_widget/my_text.dart';

class ReportCardScreen extends StatefulWidget {
  @override
  State<ReportCardScreen> createState() => _ReportCardScreenState();
}

class _ReportCardScreenState extends State<ReportCardScreen> {
  TextEditingController controller = TextEditingController();

  List<ClassStudents>? allData = [];
  List<ClassStudents>? searchList = [];

  @override
  void initState() {
    context
        .read<GetClassStudentCubit>()
        .getStudent('/api/students?class_id=&last_name=&first_name=');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
        children: [
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      'Reports',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 3.sp,
                    ),
                    const MyText(
                      'View all your kids reports here.',
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
          MyTextField(
            controller: controller,
            filledColor: kContainerColor,
            hintText: 'Search',
            prefixIcon: const Icon(Icons.search),
            onCanaged: (val) {
              if (val.isNotEmpty) {
                searchList = searchList!
                    .where((player) => player.firstName!
                        .toLowerCase()
                        .contains(val.toLowerCase()))
                    .toList();
              } else {
                searchList = allData;
              }
              setState(() {});
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          BlocConsumer<GetClassStudentCubit, GetClassStudentState>(
            listener: (context, state) {
              if (state is GetClassStudentLoading) {
                LoadingDialog.showLoadingDialog(context);
              }
              if (state is GetClassStudentLoaded) {
                Navigator.pop(context);
                allData = state.model!;
                searchList = state.model!;
              }
              if (state is GetClassStudentError) {
                Navigator.of(context).pop(true);
                Fluttertoast.showToast(msg: state.error!);
              }
            },
            builder: (context, state) {
              if (state is GetClassStudentLoaded) {
                return searchList!.isNotEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: 400.w,
                        child: ListView.separated(
                          itemCount: searchList!.length,
                          // itemCount: state.model.data!.length,
                          itemBuilder: (context, index) {
                            return ReportCard(
                              id: searchList![index].id.toString(),
                              studentName:
                                  "${searchList?[index].firstName ?? ""} ${searchList?[index].lastName ?? ""}",
                              className: searchList?[index].gender ?? "",
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 0.h,
                            );
                          },
                        ))
                    : Center(
                        child: Text(
                          'No Student Found',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
              } else if (state is GetClassStudentError) {
                return Center(
                  child: Text(state.error!),
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String studentName;
  final String className;
  final String id;
  // final Color color;
  // final Map<String, String> subjectGrades;

  ReportCard({
    super.key,
    required this.studentName,
    required this.className,
    required this.id,
    // required this.subjectGrades,
    // required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ReportDetailParent(
            stdId: id,
            studentName: studentName,
            className: className,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15.sp),
        height: 96.sp,
        padding: EdgeInsets.all(16.sp),
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
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.userImage),
                  fit: BoxFit.fill,
                ),
                shape: const OvalBorder(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: MyText(
                        studentName,
                        color: Color(0xFF000600),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: ShapeDecoration(
                            color: Color(0xFF6B7280),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Harward School',
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.75,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: ShapeDecoration(
                color: Color(0xFFF3F4F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: MyText(
                className,
                color: Color(0xFF3DAEF5),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Color _getGradeColor(String grade) {
  //   switch (grade) {
  //     case 'A+':
  //       return Colors.green;
  //     case 'A':
  //       return Colors.blue;
  //     case 'A-':
  //       return Colors.lightBlue;
  //     case 'B+':
  //       return Colors.yellow;
  //     case 'B':
  //       return Colors.orange;
  //     case 'C':
  //       return Colors.red;
  //     default:
  //       return Colors.grey;
  //   }
  // }
}
