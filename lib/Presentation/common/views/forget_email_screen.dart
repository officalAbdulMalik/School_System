import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/send_email_otp_cubit.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'otp_screen.dart';

class ForgetPasswordEmailScreen extends StatefulWidget {
  const ForgetPasswordEmailScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordEmailScreen> createState() =>
      _ForgetPasswordEmailScreenState();
}

class _ForgetPasswordEmailScreenState extends State<ForgetPasswordEmailScreen> {
  TextEditingController email = TextEditingController();

  ValueNotifier<bool> loading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
          children: [
            SizedBox(
              height: 80.sp,
            ),
            SizedBox(
              height: 160.h,
              width: 300.w,
              child: Image.asset(
                'images/satar.png',
                height: 160,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Center(
              child: Text(
                'Forgot Password',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                ' Enter your email account\nto reset password.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: kDescriptionColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 40.sp,
            ),
            MyTextField(
              controller: email,
              isRequiredField: true,
              filledColor: kContainerColor,
              hintText: 'Email',
              // decoration: textFieldIconDecoration(
              //     Icons.alternate_email, 'service@gmail.com', null),
            ),
            SizedBox(
              height: 130.h,
            ),
            BlocConsumer<SendEmailOtpCubit, SendEmailOtpState>(
              listener: (context, state) {
                if (state is SendEmailOtpLoading) {
                  LoadingDialog.showLoadingDialog(context);
                }
                if (state is SendEmailOtpLoaded) {
                  Navigator.of(context).pop(true);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return OtpScreen(
                      firstTime: true,
                      email: email.text,
                    );
                  }));
                }
                if (state is SendEmailOtpError) {
                  Navigator.of(context).pop(true);
                  Fluttertoast.showToast(msg: state.error!);
                }
              },
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    if (email.text.isNotEmpty) {
                      context
                          .read<SendEmailOtpCubit>()
                          .sendOtpTOEmail(email.text.trim());
                    } else {
                      Fluttertoast.showToast(msg: 'Enter Your Email');
                    }
                  },
                  child: CustomWidgets.customButton('Send Code'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
