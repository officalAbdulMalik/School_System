import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/Presentation/bottom_bar_parent/kids_details.dart';
import 'package:school_system/Presentation/bottom_bar_parent/profile_screens/show_parent_school.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/Presentation/utils/custom_widget/navigator_pop.dart';
import 'package:school_system/controllers/cubits/teacher_cubit/get_class_student_cubit.dart';

import '../../../controllers/cubits/teacher_cubit/show_teacher_class_cubit.dart';
import 'add_child_screen.dart';

class ShowChildren extends StatefulWidget {
  ShowChildren({Key? key, required this.classId}) : super(key: key);

  String classId;

  @override
  State<ShowChildren> createState() => _ShowChildrenState();
}

class _ShowChildrenState extends State<ShowChildren> {
  @override
  void initState() {
    context.read<GetClassStudentCubit>().getStudent(widget.classId);
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
              prefixIcon: Icon(Icons.search),
            ),
            SizedBox(
              height: 20.h,
            ),
            BlocBuilder<GetClassStudentCubit, GetClassStudentState>(
              builder: (context, state) {
                if (state is GetClassStudentLoading) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomWidgets.loadingIndicator(),
                    ],
                  );
                } else if (state is GetClassStudentLoaded) {
                  return state.model.data!.isNotEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: 400.w,
                          child: ListView.separated(
                            itemCount: state.model.data!.length,
                            // itemCount: state.model.data!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return KidsDetailsScreen(
                                        data: state.model.data!,
                                        index: index,
                                      );
                                    },
                                  ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kContainerColor,
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 40.sp,
                                      backgroundImage:
                                          state.model.data?[index].image != null
                                              ? NetworkImage(state.model
                                                      .data?[index].image ??
                                                  '')
                                              : AssetImage('images/prof.png')
                                                  as ImageProvider,
                                    ),
                                    title: Text(state
                                            .model.data?[index].firstName
                                            .toString() ??
                                        ""),
                                    subtitle: Text(state
                                            .model.data?[index].lastName
                                            .toString() ??
                                        ""),
                                    trailing: Text(state.model.data?[index].id
                                            .toString() ??
                                        ""),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 10.h,
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
                  return Text('Data Issue');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
