import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/Presentation/common/views/add_school_screen.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/controllers/cubits/common_cubit/get_all_school_cubit.dart';
import 'package:school_system/models/get_all_school_model.dart';

import '../../utils/custom_widget/custom_widgets.dart';
import 'add_child_screen.dart';
import 'show_teacher.dart';

class ShowParentSchool extends StatefulWidget {
  ShowParentSchool({Key? key}) : super(key: key);

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
        bottomNavigationBar: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return AddSchoolScreen();
              },
            ));
          },
          child: Container(
            margin: EdgeInsets.only(
                left: 10.sp, right: 10.sp, top: 10.sp, bottom: 10.sp),
            height: 50.sp,
            width: 140.sp,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: Center(
                child: Text(
              'if want to add another School ! Click here',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 15.h,
                fontWeight: FontWeight.w400,
              ),
            )),
          ),
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: ListView(
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
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 10.h,
                              );
                            },
                            itemCount: state.model.data!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return AddChildScreen();
                                    },
                                  ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(15.sp),
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          state.model.data![index].image ?? ''),
                                    ),
                                    title: Text(
                                      state.model.data![index].schoolName!,
                                      style: CustomWidgets.textStyle(
                                          color: Colors.black,
                                          size: 16,
                                          weight: FontWeight.w600),
                                    ),
                                    subtitle: Text(
                                      state.model.data![index].address!,
                                      style: CustomWidgets.textStyle(
                                          color: kDescriptionColor,
                                          size: 15,
                                          weight: FontWeight.w500),
                                    ),
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
                  return CustomWidgets.loadingIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
