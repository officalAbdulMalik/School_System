import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/get_class_student_cubit.dart';
import 'package:school_system/Presentation/BottomBarParent/profile_screens/show_parent_school.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/Presentation/utils/custom_widget/navigator_pop.dart';
import 'package:school_system/models/get_class_student_model.dart';

import 'add_child_screen.dart';
import 'kids_details.dart';

class ShowChildren extends StatefulWidget {
  ShowChildren({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowChildren> createState() => _ShowChildrenState();
}

class _ShowChildrenState extends State<ShowChildren> {
  // These two list is user for searching
  List<ClassStudents>? dataList = [];
  List<ClassStudents>? searchList = [];

  @override
  void initState() {
    context
        .read<GetClassStudentCubit>()
        .getStudent('', '/api/students?class_id=&last_name=&first_name=');
    // TODO: implement initState
    super.initState();
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return AddChildScreen();
              },
            ));
          },
        ),
        backgroundColor: Colors.white,
        body: ListView(
          padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
          children: [
            SizedBox(
              height: 20.h,
            ),
            NavigatorPop(),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        'My Kids',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 3.sp,
                      ),
                      const MyText(
                        'View all your kids details here.',
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
              height: 20.h,
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
                  searchList = dataList;
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
                  searchList = state.model;
                  dataList = state.model;
                }
                if (state is GetClassStudentError) {
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
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return KidsDetailsScreen(
                                      data: searchList!,
                                      index: index,
                                    );
                                  }));
                                },
                                child: CardTile(
                                  id: searchList?[index].id.toString() ?? "",
                                  profileImage: searchList?[index].image ?? "",
                                  studentName:
                                      "${searchList?[index].firstName ?? ""} ${searchList?[index].lastName ?? ""}",
                                  className: searchList?[index].gender ?? "",
                                  schoolName: searchList?[index].type ?? "",
                                ),
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
                } else {
                  return SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class CardTile extends StatelessWidget {
  final String studentName;
  final String className;
  final String profileImage;
  final String schoolName;
  final String id;
  // final Color color;
  // final Map<String, String> subjectGrades;

  CardTile({
    super.key,
    required this.studentName,
    required this.className,
    required this.id,
    required this.profileImage,
    required this.schoolName,
    // required this.subjectGrades,
    // required this.color,
  });

  @override
  Widget build(BuildContext context) {
    print(profileImage);

    return Container(
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
                image: profileImage.isNotEmpty
                    ? NetworkImage(profileImage)
                    : AssetImage(AppImages.userImage) as ImageProvider,
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
                      Text(
                        className,
                        style: const TextStyle(
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
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return ShowParentSchool(
                    studentId: id,
                  );
                },
              ));
            },
            child: Container(
              width: 80.w,
              height: 30.h,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: ShapeDecoration(
                color: kContainerColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Center(
                child: MyText(
                  'Assign to class ',
                  color: Colors.black,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A+':
        return Colors.green;
      case 'A':
        return Colors.blue;
      case 'A-':
        return Colors.lightBlue;
      case 'B+':
        return Colors.yellow;
      case 'B':
        return Colors.orange;
      case 'C':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
