import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:school_system/controllers/cubits/common_cubit/login_cubit.dart';

import '../../../Data/Repository/auth_apis.dart';
import 'bottom_bar.dart';
import 'forget_email_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'onboarding_screen.dart';

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

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            height: 150.h,
                            width: 300.w,
                            child: Image.asset(
                              'images/satar.png',
                              fit: BoxFit.contain,
                            ))),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: Text(
                        ' Let’s Get You Signed In',
                        style: GoogleFonts.poppins(
                          color: kPrimaryColor,
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
                        'Connecting Parents and Teachers\nWorld Wide.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: kDescriptionColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    MyTextField(
                      controller: email,
                      filledColor: kContainerColor,
                      isRequiredField: true,
                      hintText: 'Email',
                      //  prefixIcon: Icon(Icons.abc),
                      // decoration: textFieldIconDecoration(
                      //     Icons.alternate_email, 'service@gmail.com', null),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // buildTextFieldLabel('Password'),
                    MyTextField(
                      controller: pass,
                      filledColor: kContainerColor,
                      isRequiredField: true,
                      isPasswordField: true,
                      hintText: 'Password',
                      // decoration: textFieldIconDecoration(
                      //     Icons.alternate_email, 'service@gmail.com', null),
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
                            'Forget Password ?',
                            style: GoogleFonts.poppins(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                        print(state);

                        if (state is LoginLoaded) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return LoginApiShadePreference.preferences!
                                          .getString('role') ==
                                      'parent'
                                  ? BottomBarPages()
                                  : BottomBarPages();
                            },
                          ));
                        }
                        if (state is LoginError) {
                          Fluttertoast.showToast(msg: state.error!);
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: kPrimaryColor,
                            ),
                          );
                        } else {
                          return InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                context.read<LoginCubit>().loginUser(
                                    email.text.trim(), pass.text.trim());
                              }
                            },
                            child: CustomWidgets.customButton('Login'),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No have Account  ',
                          style: GoogleFonts.poppins(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
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
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
