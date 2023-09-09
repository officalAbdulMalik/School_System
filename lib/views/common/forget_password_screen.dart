import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/views/common/loginScreen.dart';
import 'package:school_system/views/common/onboarding_screen.dart';
import 'package:school_system/views/common/sign_up_screen.dart';
import 'package:school_system/views/utils/colors.dart';
import 'package:school_system/views/utils/custom_widget/container_decoration.dart';
import 'package:school_system/views/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/views/utils/custom_widget/my_text_field.dart';

import '../../controllers/apis_repo/forget_password_api.dart';
import 'complete_screen.dart';
import 'forget_password_screen.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final ValueNotifier<bool> loading = ValueNotifier(false);

  final ValueNotifier<bool> showPassword = ValueNotifier(false);
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();

  bool iconVis = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 150,
                      width: 400,
                      child: Image.asset(
                        'images/add_s_star.png',
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Set New Password',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 22.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Must be at least 8 characters.',
                      style: GoogleFonts.poppins(
                        color: kDescriptionColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 49.h,
                  ),
                  MyTextField(
                    controller: password,
                    hintText: 'Password',
                    filledColor: kContainerColor,
                    isRequiredField: true,
                    isPasswordField: true,
                    // decoration: textFieldIconDecoration(
                    //     Icons.alternate_email, 'service@gmail.com', null),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // buildTextFieldLabel('Password'),
                  MyTextField(
                    controller: confirm,
                    hintText: 'Confirm Password',
                    filledColor: kContainerColor,
                    isRequiredField: true,
                    isPasswordField: true,
                    // decoration: textFieldIconDecoration(
                    //     Icons.alternate_email, 'service@gmail.com', null),
                  ),
                  SizedBox(
                    height: 130.h,
                  ),
                  ValueListenableBuilder(
                    valueListenable: loading,
                    builder: (context, value, child) {
                      if (value == false) {
                        return InkWell(
                          onTap: () {
                            if (password.text.isNotEmpty &&
                                password.text == confirm.text) {
                              loading.value = true;
                              ForgetPasswordApi.setPassword(
                                      password.text, confirm.text)
                                  .then((value) {
                                loading.value = false;
                                if (value == 200) {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return CompleteScreen();
                                    },
                                  ));
                                }
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'check Your Password');
                            }
                          },
                          child: CustomWidgets.customButton('Reset Password'),
                        );
                      } else {
                        return Center(child: CustomWidgets.loadingIndicator());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
