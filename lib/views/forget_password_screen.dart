import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/views/loginScreen.dart';
import 'package:school_system/views/onboarding_screen.dart';
import 'package:school_system/views/sign_up_screen.dart';
import 'package:school_system/views/utils/colors.dart';

import '../controllers/apis_repo/forget_password_api.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
              ),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 60.r,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 59.r,
                    backgroundImage: AssetImage('images/forget.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Change Password',
                  style: GoogleFonts.acme(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 33.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Enter New password to change your password',
                  style: GoogleFonts.acme(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 21.sp),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 49.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.sp),
                        height: 50.h,
                        width: 340.w,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15.r),
                          gradient: LinearGradient(
                              colors: [
                                const Color(0xFFC7CEF1),
                                const Color(0xFF8C9BE3),
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.1, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 12.sp),
                            border: InputBorder.none,
                          ),
                          cursorColor: kPrimaryColor,
                          // decoration: textFieldIconDecoration(
                          //     Icons.alternate_email, 'service@gmail.com', null),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      // buildTextFieldLabel('Password'),
                      Container(
                        padding: EdgeInsets.only(left: 10.sp),
                        height: 50.h,
                        width: 340.w,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15.sp),
                          gradient: LinearGradient(
                              colors: [
                                const Color(0xFFC7CEF1),
                                const Color(0xFF8C9BE3),
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.1, 1.0],
                              tileMode: TileMode.decal),
                        ),
                        child: TextFormField(
                          controller: confirm,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 12.sp),
                            border: InputBorder.none,
                          ),
                          cursorColor: kPrimaryColor,
                          // decoration: textFieldIconDecoration(
                          //     Icons.alternate_email, 'service@gmail.com', null),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
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
                                          return LogInScreen();
                                        },
                                      ));
                                    }
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'check Your Password');
                                }
                              },
                              child: Container(
                                height: 50.h,
                                width: 300.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFF2A3B5D),
                                        const Color(0xFF3D529B),
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 0.0),
                                      stops: [0.1, 1.0],
                                      tileMode: TileMode.decal),
                                ),
                                child: Center(
                                    child: Text(
                                  'Change Password',
                                  style: GoogleFonts.acme(
                                      color: Colors.white, fontSize: 20.sp),
                                )),
                              ),
                            );
                          } else {
                            return Center(
                                child: LoadingAnimationWidget.fallingDot(
                              color: Colors.white,
                              size: 50.sp,
                            ));
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
