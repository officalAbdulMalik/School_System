import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:school_system/views/forget_password_screen.dart';
import 'package:school_system/views/loginScreen.dart';
import 'package:school_system/views/teacher_data/teacher_add_clases.dart';
import 'package:school_system/views/utils/colors.dart';
import 'package:school_system/views/utils/shade_prefrence.dart';

import '../controllers/apis_repo/forget_password_api.dart';
import 'all_school_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  String otpCode = '';
  ValueNotifier<bool> loading = ValueNotifier(false);

  OtpFieldController otp = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: kButtonColor,
        title: Text(
          'Verify Email',
          style: GoogleFonts.acme(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 39.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 180.h,
                width: 180.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Image.asset('images/verfy_email.png'),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Verification code send to your email\nenter code and verify account',
              textAlign: TextAlign.center,
              style: GoogleFonts.acme(
                color: Colors.white,
                fontSize: 20.sp,
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            SizedBox(
              height: 60.h,
              width: 500.w,
              child: OTPTextField(
                controller: otp,
                fieldWidth: 45.sp,
                length: 5,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 15,
                otpFieldStyle: OtpFieldStyle(
                  disabledBorderColor: Colors.black,
                  enabledBorderColor: Colors.white,
                ),
                onCompleted: (String verificationCode) {
                  otpCode = verificationCode;
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            InkWell(
              onTap: () async {
                await ForgetPasswordApi.resendOtp();
                otpCode = '';
                otp.clear();
                setState(() {});
              },
              child: RichText(
                text: TextSpan(
                    text: 'Don\'t Receive The Otp?',
                    style: GoogleFonts.acme(
                      color: Colors.white,
                      fontSize: 17.sp,
                    ),
                    children: [
                      TextSpan(
                          text: ' Resend It',
                          style: GoogleFonts.acme(
                            color: kButtonColor,
                            fontSize: 18.sp,
                          )),
                    ]),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ValueListenableBuilder(
              valueListenable: loading,
              builder: (context, value, child) {
                if (value == false) {
                  return InkWell(
                    onTap: () {
                      if (otpCode.isNotEmpty) {
                        loading.value = true;
                        ForgetPasswordApi.verifyOtp(otpCode).then((value) {
                          otp.clear();
                          loading.value = false;
                          if (value == 200) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ForgetPassword();
                              },
                            ));
                          }
                        });
                      } else {
                        Fluttertoast.showToast(msg: 'Enter Otp Code');
                      }

                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) {
                      //     return LoginApiShadePreference.preferences!
                      //                 .getString('role') ==
                      //             'teacher'
                      //         ? TeacherAddSchool()
                      //         : SchoolListScreen();
                      //   },
                      // ));
                    },
                    child: Container(
                      height: 50.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.sp),
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
                        'Verify Email',
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
    );
  }
}
