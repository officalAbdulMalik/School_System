import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/models/get_all_school_model.dart';
import 'package:school_system/views/loginScreen.dart';
import 'package:school_system/views/teacher_data/teacher_add_clases.dart';
import 'package:school_system/views/utils/colors.dart';
import 'package:school_system/views/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/views/utils/shade_prefrence.dart';

import '../controllers/apis_repo/school_in_info.dart';

class SchoolAddInInfo extends StatefulWidget {
  SchoolAddInInfo({Key? key, required this.data, required this.index})
      : super(key: key);

  List<Data> data = [];
  int index;

  @override
  State<SchoolAddInInfo> createState() => _SchoolAddInInfoState();
}

class _SchoolAddInInfoState extends State<SchoolAddInInfo> {
  final ValueNotifier<bool> loading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: ListView(
          padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
          children: [
            SizedBox(
              height: 80.h,
            ),
            Container(
              height: 300.h,
              width: 200.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.sp),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 15.sp,
                  ),
                  SizedBox(
                    height: 55.h,
                    width: 55.w,
                    child: CircleAvatar(
                      radius: 55.sp,
                      backgroundImage:
                          NetworkImage(widget.data[widget.index].image!),
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  customShowWidget(
                      widget.data[widget.index].schoolName!, 'School Name'),
                  customShowWidget(
                      widget.data[widget.index].address!, 'Address'),
                  customShowWidget(
                      widget.data[widget.index].country!.name!, 'Country'),
                  customShowWidget(
                      widget.data[widget.index].countryId.toString()!,
                      'Country id'),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            InkWell(
              onTap: () {
                loading.value = true;
                AddSchoolInOverInfo.addSchool(widget.data[widget.index].id!)
                    .then((value) {
                  loading.value = false;
                  if (value == 200) {
                    return Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return LogInScreen();
                      },
                    ));
                  }
                });
              },
              child: ValueListenableBuilder(
                valueListenable: loading,
                builder: (context, value, child) {
                  if (value == false) {
                    return Container(
                      height: 50.h,
                      width: 30.w,
                      margin: EdgeInsets.only(left: 20.sp, right: 20.sp),
                      child: CustomWidgets.customButton('Continue'),
                    );
                  } else {
                    return Center(
                        child: LoadingAnimationWidget.fallingDot(
                      color: Colors.white,
                      size: 50.sp,
                    ));
                  }
                },
              ),
            )
          ],
        ));
  }

  customShowWidget(String text1, String text2) {
    return ListTile(
      leading: Text(
        text2,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Text(
        text1,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
