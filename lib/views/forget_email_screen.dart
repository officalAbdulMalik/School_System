import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/views/forget_password_screen.dart';
import 'package:school_system/views/utils/colors.dart';
import 'package:school_system/views/utils/custom_widget/container_decoration.dart';
import 'package:school_system/views/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/views/verify_email_screen.dart';

import '../controllers/apis_repo/forget_password_api.dart';

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
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kButtonColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Forget Password',
          style: GoogleFonts.acme(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
        children: [
          SizedBox(
            height: 50.sp,
          ),
          SizedBox(
            height: 150.h,
            width: 300.w,
            child: Image.asset('images/forget_email.png'),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Text(
            'Enter your email to verify your account and\nreset your password',
            style: GoogleFonts.acme(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 40.sp,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            height: 50.h,
            width: 340.w,
            decoration: ContinerDecoration.continerDecoration(),
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.black, fontSize: 12.sp),
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
          ValueListenableBuilder(
            valueListenable: loading,
            builder: (context, value, child) {
              if (value == true) {
                return Center(
                    child: LoadingAnimationWidget.fallingDot(
                  color: Colors.white,
                  size: 50.sp,
                ));
              } else {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                  child: InkWell(
                    onTap: () {
                      if (email.text.isNotEmpty) {
                        loading.value = true;
                        ForgetPasswordApi.sendEmail(email.text.trim())
                            .then((value) {
                          loading.value = false;
                          if (value == 200) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return VerifyEmailScreen();
                              },
                            ));
                          }
                        });
                      } else {
                        Fluttertoast.showToast(msg: 'Enter Your Email');
                      }
                    },
                    child: CustomWidgets.customButton('Send Code'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
