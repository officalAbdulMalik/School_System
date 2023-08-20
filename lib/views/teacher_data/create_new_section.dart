import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/views/loginScreen.dart';
import 'package:school_system/views/utils/colors.dart';

import '../../controllers/apis_repo/teacher_apis/teacher_add_section.dart';
import '../../controllers/cubits/common_cubit/get_all_school_cubit.dart';
import '../utils/custom_widget/custom_widgets.dart';

class CreateSection extends StatefulWidget {
  CreateSection({Key? key, required this.schoolId, required this.sectionId})
      : super(key: key);

  String schoolId;
  String sectionId;

  @override
  State<CreateSection> createState() => _CreateSectionState();
}

class _CreateSectionState extends State<CreateSection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController sectionName = TextEditingController();

  ValueNotifier<bool> loading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xFF2A3B5D),
          centerTitle: true,
          title: Text(
            'Create Section',
            style: GoogleFonts.acme(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
        resizeToAvoidBottomInset: false,
        body: ListView(
          padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
          children: [
            SizedBox(
              height: 30.h,
            ),
            CustomWidgets.customTextField(
                hintText: 'Section Name', controller: sectionName),
            SizedBox(
              height: 20.h,
            ),
            ValueListenableBuilder(
              valueListenable: loading,
              builder: (context, value, child) {
                if (value == false) {
                  return InkWell(
                    onTap: () {
                      if (sectionName.text.isNotEmpty) {
                        loading.value = true;
                        TeacherAddSection.addSection(
                                sectionName.text.trim(), widget.schoolId)
                            .then((value) {
                          if (value == 200) {
                            loading.value = false;
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return LogInScreen();
                              },
                            ));
                          }
                        });
                      } else {
                        Fluttertoast.showToast(msg: 'All Fields are Required');
                      }
                    },
                    child: CustomWidgets.customButton('Save'),
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
          ],
        ));
  }
}
