import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/views/onboarding_screen.dart';
import 'package:school_system/views/sign_up_screen.dart';
import 'package:school_system/views/terms_condation.dart';
import 'package:school_system/views/utils/colors.dart';
import 'package:school_system/views/utils/custom_widget/container_decoration.dart';
import 'package:school_system/views/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/views/utils/shade_prefrence.dart';
import '../controllers/apis_repo/auth_apis.dart';
import 'bottom_bar_parent/bottom_bar_parent.dart';
import 'bottom_bar_techer/bottom_bar_teacher.dart';
import 'forget_email_screen.dart';
import 'forget_password_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final ValueNotifier<bool> loading = ValueNotifier(false);

  final ValueNotifier<bool> showPassword = ValueNotifier(false);

  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset('images/satar.png')),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ' Let\'s Sign In',
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
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome Back,\nYou\'ve been missed',
                    style: GoogleFonts.acme(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
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
                  decoration: ContinerDecoration.continerDecoration(),
                  child: ValueListenableBuilder(
                    valueListenable: showPassword,
                    builder: (context, value, child) {
                      return TextFormField(
                        obscureText: showPassword.value,
                        controller: pass,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              showPassword.value = !value;
                            },
                            child: value != true
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          ),
                          hintText: 'Password',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 12.sp),
                          border: InputBorder.none,
                        ),
                        cursorColor: kPrimaryColor,
                        // decoration: textFieldIconDecoration(
                        //     Icons.alternate_email, 'service@gmail.com', null),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0.sp),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ForgetPasswordEmailScreen();
                          },
                        ));
                      },
                      child: Text(
                        'Forget Password',
                        style: GoogleFonts.acme(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
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
                      return InkWell(
                        onTap: () {
                          if (email.text.isNotEmpty && pass.text.isNotEmpty) {
                            print('if');
                            loading.value = true;
                            LoginApi.createUser(email.text.trim(),
                                    pass.text.trim(), context)
                                .then((value) {
                              loading.value = false;
                              if (value == 200) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return LoginApiShadePreference.preferences!
                                                .getString('role') ==
                                            'parents'
                                        ? BottomBarPages()
                                        : TeacherBottomBar();
                                  },
                                ));
                              }
                            });
                          } else {
                            Fluttertoast.showToast(msg: 'All Fields Required');
                            print('else');
                          }
                        },
                        child: CustomWidgets.customButton('Login'),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return TermsCondation();
                        },
                      ));
                    },
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'By Loging you agree with',
                              style: GoogleFonts.acme(
                                color: Colors.white,
                              )),
                          TextSpan(
                              text: ' Terms and condition ',
                              style: GoogleFonts.acme(
                                color: kButtonColor,
                              )),
                          TextSpan(
                              text: '& ',
                              style: GoogleFonts.acme(
                                color: Colors.white,
                              )),
                          TextSpan(
                              text: '\nPrivacy Police',
                              style: GoogleFonts.acme(
                                color: kButtonColor,
                              ))
                        ])),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No have Account  ',
                      style: GoogleFonts.acme(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return OnboardingScreen();
                          },
                        ));
                      },
                      child: Text(
                        'Sign up here!',
                        style: GoogleFonts.acme(
                          color: Color(0xFF2A3B5D),
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 50.h,
                    width: 50.w,
                    child: Image.asset('images/satar.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
