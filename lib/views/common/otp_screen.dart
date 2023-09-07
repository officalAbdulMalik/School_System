import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:school_system/views/common/loginScreen.dart';
import 'package:school_system/views/bottom_bar_techer/prifile_screen/teacher_add_clases.dart';
import 'package:school_system/views/utils/colors.dart';
import 'package:school_system/views/utils/shade_prefrence.dart';

import '../../controllers/apis_repo/forget_password_api.dart';
import '../utils/custom_widget/custom_row_widget.dart';
import '../utils/custom_widget/custom_widgets.dart';
import '../utils/custom_widget/navigator_pop.dart';
import 'all_school_screen.dart';
import 'complete_screen.dart';
import 'forget_password_screen.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key, required this.firstTime}) : super(key: key);

  bool firstTime;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otpCode = '';
  ValueNotifier<bool> loading = ValueNotifier(false);

  OtpFieldController otp = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 39.h,
              ),
              const NavigatorPop(),
              SizedBox(
                height: 20.h,
              ),
              CustomRowWidget(
                text1: 'Choice Your Country',
                text2: 'Select Your country from here...',
                image: 'sch_star.png',
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 150,
                  width: 400,
                  child: Image.asset(
                    'images/satar.png',
                    height: 150,
                    fit: BoxFit.contain,
                  ),
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
                    enabledBorderColor: Colors.grey,
                  ),
                  onCompleted: (String verificationCode) {
                    otpCode = verificationCode;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
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
                      style: GoogleFonts.poppins(
                        color: kDescriptionColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                            text: ' Resend It',
                            style: GoogleFonts.poppins(
                              color: kPrimaryColor,
                              fontSize: 18.sp,
                            )),
                      ]),
                ),
              ),
              SizedBox(
                height: 150.h,
              ),
              ValueListenableBuilder(
                valueListenable: loading,
                builder: (context, value, child) {
                  if (value == false) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return widget.firstTime == true
                                ? ForgetPassword()
                                : CompleteScreen();
                          },
                        ));
                        if (otpCode.isNotEmpty) {
                          loading.value = true;

                          ForgetPasswordApi.verifyOtp(otpCode).then((value) {
                            otp.clear();
                            loading.value = false;

                            String message = value['message'];
                            print(message);
                            if (message != 'Invalid Pincode') {
                              print(value);
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return ForgetPassword();
                                },
                              ));
                            } else {
                              Fluttertoast.showToast(msg: message);
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
                      child: CustomWidgets.customButton('Verify Email'),
                    );
                  } else {
                    return CustomWidgets.loadingIndicator();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
