import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/get_all_school_cubit.dart';
import 'package:school_system/Controllers/Services/AdsServices/show_ads.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';

import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/Presentation/utils/custom_widget/navigator_pop.dart';
import 'package:school_system/models/get_all_school_model.dart';

import 'show_teacher.dart';

class ShowParentSchool extends StatefulWidget {
  const ShowParentSchool({
    super.key,
    required this.studentId,
  });

  final String studentId;

  @override
  State<ShowParentSchool> createState() => _ShowParentSchoolState();
}

class _ShowParentSchoolState extends State<ShowParentSchool> {
  final ValueNotifier<bool> showPassword = ValueNotifier(false);

  String type = '';

  TextEditingController searchController = TextEditingController();

  List<Schools>? searchList = [];
  List<Schools>? dataList = [];

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
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const NavigatorPop(),
                SizedBox(height: 5.h),
                 CustomRowWidget(
                  text1: 'Find Your Kids School',
                  text2: 'Select Your school from here...',
                  image: 'images/star_s.webp',
                  height: 60.h,
                  width: 60.w,
                ),
                SizedBox(
                  height: 10.h,
                ),
                const ShowAds(),
                SizedBox(
                  height: 10.h,
                ),
                MyTextField(
                  controller: searchController,
                  filledColor: kContainerColor,
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  onCanaged: (val) {
                    if (val.isNotEmpty) {
                      searchList = searchList!
                          .where((player) => player.schoolName!
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
                  height: 15.h,
                ),
                BlocConsumer<GetAllSchoolCubit, GetAllSchoolState>(
                  listener: (context, state) {
                    if (state is GetAllSchoolLoading) {
                      Dialogs.loadingDialog(context);
                    }
                    if (state is GetAllSchoolLoaded) {
                      searchList = state.model;
                      dataList = state.model;
                      Navigator.pop(context);
                    }
                    if (state is GetAllSchoolError) {
                      Fluttertoast.showToast(msg: state.error!);
                    }
                  },
                  builder: (context, state) {
                    if (state is GetAllSchoolLoaded) {
                      return searchList!.isNotEmpty
                          ? ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 10.h,
                                );
                              },
                              itemCount: searchList!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 5.sp),
                                  height: 70.sp,
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
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          searchList![index].image ?? ''),
                                    ),
                                    title: Text(
                                      searchList![index].schoolName!,
                                      style: CustomWidgets.textStyle(
                                          color: Colors.black,
                                          size: 16,
                                          weight: FontWeight.w600),
                                    ),
                                    subtitle: Text(
                                      searchList![index].address!,
                                      style: CustomWidgets.textStyle(
                                          color: kDescriptionColor,
                                          size: 15,
                                          weight: FontWeight.w500),
                                    ),
                                    trailing: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return SchoolTeacher(
                                                schoolId: state
                                                    .model[index].id
                                                    .toString(),
                                                studentId: widget.studentId,
                                              );
                                            },
                                          ));
                                        },
                                        child: Center(
                                          child: Icon(
                                            Icons.add,
                                            size: 25.sp,
                                            color: kDescriptionColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: CustomWidgets.errorText("Data Not Found"),
                            );
                    } else {
                      return const SizedBox();
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
