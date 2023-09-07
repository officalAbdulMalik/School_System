import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/views/utils/colors.dart';
import 'package:school_system/views/utils/custom_widget/container_decoration.dart';
import 'package:school_system/views/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/views/common/otp_screen.dart';

import '../../controllers/apis_repo/forget_password_api.dart';
import '../utils/custom_widget/custom_row_widget.dart';
import '../utils/custom_widget/navigator_pop.dart';

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
                  fontWeight: FontWeight.w700,
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
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                ),
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
              height: 130.h,
            ),
            ValueListenableBuilder(
              valueListenable: loading,
              builder: (context, value, child) {
                if (value == true) {
                  return Center(child: CustomWidgets.loadingIndicator());
                } else {
                  return InkWell(
                    onTap: () {
                      if (email.text.isNotEmpty) {
                        loading.value = true;
                        ForgetPasswordApi.sendEmail(email.text.trim())
                            .then((value) {
                          loading.value = false;
                          if (value == 200) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return OtpScreen(
                                  firstTime: true,
                                );
                              },
                            ));
                          }
                        });
                      } else {
                        Fluttertoast.showToast(msg: 'Enter Your Email');
                      }
                    },
                    child: CustomWidgets.customButton('Send Code'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
