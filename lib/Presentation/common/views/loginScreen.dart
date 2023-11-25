import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/login_cubit.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/Presentation/utils/custom_widget/show_star_image.dart';
import 'bottom_bar.dart';
import 'forget_email_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'onboarding_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

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
                    ShowStarsImage(
                      width: 1.sw,
                      height: 150.h,
                      imageUrl: 'images/star_e.webp',
                    ),
                    // Align(
                    //     alignment: Alignment.center,
                    //     child: SizedBox(
                    //         height: 150.h,
                    //         width: 300.w,
                    //         child: Image.asset(
                    //           'images/star_e.jpg',
                    //           fit: BoxFit.contain,
                    //         ),),),
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
                                return const ForgetPasswordEmailScreen();
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
                      if (state is LoginLoading) {
                        Dialogs.loadingDialog(context);
                      }

                      if (state is LoginLoaded) {
                        Navigator.pop(context);

                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return const BottomBarPages(
                              index: 0,
                            );
                          },
                        ));
                      }
                      if (state is LoginError) {
                        Navigator.of(context).pop(true);
                        Fluttertoast.showToast(msg: state.error!);
                      }
                    }, builder: (context, state) {
                      return CustomWidgets.customButton('Login', onTap: () {
                        if (formKey.currentState!.validate()) {
                          context
                              .read<LoginCubit>()
                              .loginUser(email.text.trim(), pass.text.trim());
                        }

                      });
                    }),
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
