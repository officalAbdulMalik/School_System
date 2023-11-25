
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:pinput/pinput.dart';
import '../../../Controllers/Cubits/CommonCubit/verify_otp_cubit.dart';
import '../../../Data/Repository/forget_password_api.dart';
import '../../utils/custom_widget/custom_row_widget.dart';
import '../../utils/custom_widget/custom_widgets.dart';
import '../../utils/custom_widget/navigator_pop.dart';
import 'all_school_screen.dart';
import 'complete_screen.dart';
import 'forget_password_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.firstTime, required this.email})
      : super(key: key);

  final bool firstTime;
  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  ValueNotifier<bool> loading = ValueNotifier(false);

 TextEditingController otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


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
                image: 'images/star_s.webp',
                height: 70.h,
                width: 70.w,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 150.h,
                  width: 400.w,
                  child: Image.asset(
                    'images/star_e.webp',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              PinCodeField(formKey: _formKey,controller: otpController,),
              SizedBox(
                height: 15.h,
              ),
              InkWell(
                onTap: () async {
                  await ForgetPasswordApi.sendEmail(widget.email);
                  otpController.clear();
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
                    Dialogs.loadingDialog(context);
                  }
                  if (state is VerifyOtpError) {
                    Navigator.of(context).pop(true);
                    Fluttertoast.showToast(msg: state.error!);
                  }
                  if (state is VerifyOtpLoaded) {
                    Navigator.of(context).pop(true);
                    if (widget.firstTime == false) {
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
                          return SchoolListScreen();
                        },
                      ));
                    }
                  }
                },
                builder: (context, state) {
                  return CustomWidgets.customButton('Verify Email', onTap: () {

                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return SchoolListScreen();
                      },
                    ));

                    if (_formKey.currentState!.validate()) {
                      if(otpController.text.length < 5){
                        Fluttertoast.showToast(msg: 'Otp Not correct');

                      }else{
                        context
                            .read<VerifyOtpCubit>()
                            .verifyOTp(otpController.text.trim(), widget.email);
                      }
                    } else {
                      Fluttertoast.showToast(msg: 'Enter Otp Code');
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
class PinCodeField extends StatefulWidget {
  const PinCodeField({Key? key, this.controller, this.formKey})
      : super(key: key);

  final TextEditingController? controller;
  final GlobalKey? formKey;

  @override
  State<PinCodeField> createState() => _PinCodeFieldState();
}

class _PinCodeFieldState extends State<PinCodeField> {
  final focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = kPrimaryColor;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);

    final defaultPinTheme = PinTheme(
      width: 77.w,
      height: 60.h,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 12,
              offset: Offset(0, 6),
              spreadRadius: 0,
            )
          ]),
    );

    /// Optionally you can use form to validate the Pinput
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            // Specify direction if desired
            textDirection: TextDirection.ltr,
            child: Pinput(
              length: 5,
              controller: widget.controller,
              focusNode: focusNode,
              androidSmsAutofillMethod:
              AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,

              separatorBuilder: (index) => const SizedBox(width: 8),
              validator: (value) {
                if (value!.isEmpty) {
                  return '';
                }
              },
              // onClipboardFound: (value) {
              //   debugPrint('onClipboardFound: $value');
              //   pinController.setText(value);
              // },
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) {
                debugPrint('onCompleted: $pin');
              },
              onChanged: (value) {
                debugPrint('onChanged: $value');
              },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme,
              submittedPinTheme: defaultPinTheme,
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
