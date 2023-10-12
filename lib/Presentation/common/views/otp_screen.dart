import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:school_system/controllers/cubits/common_cubit/verify_otp_cubit.dart';

import '../../../Data/Repository/forget_password_api.dart';
import '../../utils/custom_widget/custom_row_widget.dart';
import '../../utils/custom_widget/custom_widgets.dart';
import '../../utils/custom_widget/navigator_pop.dart';
import 'all_school_screen.dart';
import 'complete_screen.dart';
import 'forget_password_screen.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key, required this.firstTime, required this.email})
      : super(key: key);

  bool firstTime;
  String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otpCode = '';
  ValueNotifier<bool> loading = ValueNotifier(false);

  OtpFieldController otp = OtpFieldController();

  String? email = LoginApiShadePreference.preferences!.getString('email');

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
                text1: 'OTP Verification',
                text2: 'Please type the verification code sent to email.',
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
                  await ForgetPasswordApi.sendEmail(widget.email);
                  otpCode = '';
                  otp.clear();
                  setState(() {});
                },
                child: RichText(
                  text: TextSpan(
                      text: 'Don\'t Receive The Otp?',
                      style: GoogleFonts.poppins(
                        color: kDescriptionColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                            text: ' Resend It',
                            style: GoogleFonts.poppins(
                              color: kPrimaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            )),
                      ]),
                ),
              ),
              SizedBox(
                height: 150.h,
              ),
              BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
                listener: (context, state) {
                  if (state is VerifyOtpLoading) {
                    LoadingDialog.showLoadingDialog(context);
                  }
                  if (state is VerifyOtpError) {
                    Navigator.of(context).pop(true);
                    Fluttertoast.showToast(msg: state.error!);
                  }
                  if (state is VerifyOtpLoaded) {
                    Navigator.of(context).pop(true);
                    if (widget.firstTime == true) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ForgetPassword(
                            email: widget.email,
                          );
                        },
                      ));
                    } else {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const CompleteScreen();
                        },
                      ));
                    }
                  }
                },
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ForgetPassword(
                            email: widget.email,
                          );
                        },
                      ));

                      if (otpCode.isNotEmpty) {
                        context
                            .read<VerifyOtpCubit>()
                            .verifyOTp(otpCode, widget.email);
                        otpCode = "";

                        otp.clear();
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
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
