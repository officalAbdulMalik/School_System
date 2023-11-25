import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/new_password_cubit.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'complete_screen.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key, required this.email}) : super(key: key);

 final String email;

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final ValueNotifier<bool> loading = ValueNotifier(false);

  final ValueNotifier<bool> showPassword = ValueNotifier(false);
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();

  bool iconVis = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 150.h,
                      width: 400.w,
                      child: Image.asset(
                        'images/star_e.webp',
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Set New Password',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 22.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Must be at least 8 characters.',
                      style: GoogleFonts.poppins(
                        color: kDescriptionColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  MyTextField(
                    controller: password,
                    hintText: 'Password',
                    filledColor: kContainerColor,
                    isRequiredField: true,
                    isPasswordField: true,
                    // decoration: textFieldIconDecoration(
                    //     Icons.alternate_email, 'service@gmail.com', null),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // buildTextFieldLabel('Password'),
                  MyTextField(
                    controller: confirm,
                    hintText: 'Confirm Password',
                    filledColor: kContainerColor,
                    isRequiredField: true,
                    isPasswordField: true,
                    // decoration: textFieldIconDecoration(
                    //     Icons.alternate_email, 'service@gmail.com', null),
                  ),
                  SizedBox(
                    height: 130.h,
                  ),
                  BlocConsumer<NewPasswordCubit, NewPasswordState>(
                    listener: (context, state) {
                      if (state is NewPasswordLoading) {
                        Dialogs.loadingDialog(context);
                      }
                      if (state is NewPasswordError) {
                        Navigator.of(context).pop(true);
                        Fluttertoast.showToast(msg: state.error!);
                        // Navigator.of(context).pop(true);
                      }
                      if (state is NewPasswordLoaded) {
                        Navigator.of(context).pop(true);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const CompleteScreen();
                          },
                        ));
                      }
                    },
                    builder: (context, state) {
                      return CustomWidgets.customButton('Reset Password', onTap: () {
                        if (password.text.isNotEmpty &&
                            confirm.text == confirm.text) {
                          context.read<NewPasswordCubit>().sendOtpTOEmail(
                              password.text.trim(),
                              confirm.text.trim(),
                              widget.email);
                        } else {
                          Fluttertoast.showToast(msg: 'check Your Password');
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
