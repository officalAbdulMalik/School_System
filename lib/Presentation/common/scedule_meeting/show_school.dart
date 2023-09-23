import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Presentation/common/views/shool_addInInfo.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/controllers/cubits/common_cubit/get_all_school_cubit.dart';

import '../../utils/custom_widget/custom_row_widget.dart';
import '../../utils/custom_widget/navigator_pop.dart';
import 'add_participant_screen.dart';

class SchoolListScreen extends StatefulWidget {
  SchoolListScreen({Key? key}) : super(key: key);

  @override
  State<SchoolListScreen> createState() => _SchoolListScreenState();
}

class _SchoolListScreenState extends State<SchoolListScreen> {
  final ValueNotifier<bool> showPassword = ValueNotifier(false);

  String type = '';

  @override
  void initState() {
    context
        .read<GetAllSchoolCubit>()
        .getAllSchool('/api/get/teacher/schools?name=');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const NavigatorPop(),
                SizedBox(height: 5.h),
                CustomRowWidget(
                  text1: 'Find Your School',
                  text2: 'Select Your school from here...',
                  image: 'add_s_star.png',
                ),
                SizedBox(
                  height: 15.h,
                ),
                BlocBuilder<GetAllSchoolCubit, GetAllSchoolState>(
                  builder: (context, state) {
                    if (state is GetAllSchoolLoaded) {
                      return SizedBox(
                        height: 500.h,
                        width: 500.w,
                        child: state.model.data!.isNotEmpty
                            ? ListView.separated(
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
                                          return AddParticipantScreen(
                                            schoolId: state
                                                .model.data![index].id
                                                .toString(),
                                          );
                                        },
                                      ));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius:
                                            BorderRadius.circular(15.sp),
                                      ),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              state.model.data![index].image ??
                                                  ''),
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
        ),
      ),
    );
  }
}
