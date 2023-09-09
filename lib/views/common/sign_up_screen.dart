import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/controllers/cubits/common_cubit/sign_up_cubit.dart';
import 'package:school_system/views/common/loginScreen.dart';
import 'package:school_system/views/bottom_bar_techer/prifile_screen/teacher_add_clases.dart';
import 'package:school_system/views/utils/colors.dart';
import 'package:school_system/views/utils/custom_widget/container_decoration.dart';
import 'package:school_system/views/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/views/utils/custom_widget/my_text_field.dart';
import 'package:school_system/views/utils/shade_prefrence.dart';

import '../../controllers/apis_repo/auth_apis.dart';
import '../utils/custom_widget/custom_row_widget.dart';
import '../utils/custom_widget/navigator_pop.dart';
import 'all_school_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ValueNotifier<bool> loading = ValueNotifier(false);

  final ValueNotifier<bool> showPassword = ValueNotifier(false);
  final ValueNotifier<bool> showCPassword = ValueNotifier(false);

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController occupation = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController dob = TextEditingController();

  String language = 'Language';

  String gender = 'Select Gender';

  String abou = 'How did you hear about us ?';

  String teacherM = 'Select title';

  List<String> parents = [
    'Mother',
    'Father',
    'GrandMother',
    'Legal Guardian',
    'Other'
  ];

  List<String> about = [
    'Parent',
    'Teacher',
    'School',
    'SocialNetwork',
    ' Search Engine',
    'Other'
  ];
  List<String> teacher = [
    'Mr.',
    'Mrs.',
    'Doctor',
    'Ms.',
  ];

  validator() {
    return 'Field is required';
  }

  bool checkBox = false;

  String role = LoginApiShadePreference.preferences!.getString('role')!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: ListView(
          padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
          children: [
            SizedBox(
              height: 20.h,
            ),
            const NavigatorPop(),
            SizedBox(height: 20.h),
            CustomRowWidget(
              text1: 'Create Your New Account!',
              text2: 'Improving Parent & Teacher Communication.',
              image: 'sign_star.png',
              flex: 6,
            ),
            SizedBox(
              height: 20.sp,
            ),
            DecoratedContainer(
              child: Row(
                children: [
                  Expanded(
                      flex: role == 'teacher' ? 2 : 1,
                      child: Text(
                        teacherM,
                        style: CustomWidgets.style(),
                      )),
                  SizedBox(
                    width: 30.w,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      underline: SizedBox(),
                      items: role == 'teacher'
                          ? teacher.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList()
                          : parents.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                      onChanged: (value) {
                        teacherM = value!;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            MyTextField(
              controller: firstName,
              maxLine: 1,
              hintText: 'Firs Name',
              filledColor: kContainerColor,
              isRequiredField: true,
              // decoration: textFieldIconDecoration(
              //     Icons.alternate_email, 'service@gmail.com', null),
            ),
            SizedBox(
              height: 20.h,
            ),
            MyTextField(
              controller: lastName,
              maxLine: 1,
              hintText: 'Last Name',
              filledColor: kContainerColor,
              isRequiredField: true,
              // decoration: textFieldIconDecoration(
              //     Icons.alternate_email, 'service@gmail.com', null),
            ),
            SizedBox(
              height: 20.h,
            ),
            MyTextField(
              controller: email,
              maxLine: 1,
              hintText: 'Email',
              filledColor: kContainerColor,
              isRequiredField: true,
              // decoration: textFieldIconDecoration(
              //     Icons.alternate_email, 'service@gmail.com', null),
            ),
            SizedBox(
              height: 20.h,
            ),
            MyTextField(
              controller: password,
              maxLine: 1,
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
            MyTextField(
              controller: confirmPassword,
              maxLine: 1,
              hintText: 'Confirm Password',
              filledColor: kContainerColor,
              isRequiredField: true,
              isPasswordField: true,
              // decoration: textFieldIconDecoration(
              //     Icons.alternate_email, 'service@gmail.com', null),
            ),
            SizedBox(
              height: role == 'parents' ? 20.h : 0,
            ),
            role == 'parents'
                ? MyTextField(
                    controller: phoneNumber,
                    maxLine: 1,
                    hintText: 'Phone',
                    filledColor: kContainerColor,
                    isRequiredField: true,
                    // decoration: textFieldIconDecoration(
                    //     Icons.alternate_email, 'service@gmail.com', null),
                  )
                : SizedBox(),
            SizedBox(
              height: role == 'parents' ? 20.h : 0,
            ),
            role == 'parents'
                ? MyTextField(
                    controller: dob,
                    maxLine: 1,
                    hintText: 'Date Of Birth',
                    filledColor: kContainerColor,
                    isRequiredField: true,
                    // decoration: textFieldIconDecoration(
                    //     Icons.alternate_email, 'service@gmail.com', null),
                  )
                : SizedBox(),
            SizedBox(
              height: 20.h,
            ),
            MyTextField(
              controller: occupation,
              maxLine: 1,
              hintText: role == 'teacher' ? 'qualification' : 'occupation',
              filledColor: kContainerColor,
              isRequiredField: true,
              // decoration: textFieldIconDecoration(
              //     Icons.alternate_email, 'service@gmail.com', null),
            ),
            SizedBox(
              height: 20.h,
            ),
            // buildTextFieldLabel('Password'),
            DecoratedContainer(
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        language,
                        style: CustomWidgets.style(),
                      )),
                  SizedBox(
                    width: 30.sp,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0.sp),
                      child: DropdownButton<String>(
                        underline: SizedBox(),
                        items: <String>[
                          'English',
                          'Scots',
                          'Welsh',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          language = value!;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            DecoratedContainer(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      gender,
                      style: CustomWidgets.style(),
                    ),
                  ),
                  SizedBox(
                    width: 30.sp,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0.sp),
                      child: DropdownButton<String>(
                        underline: SizedBox(),
                        items: <String>[
                          'Male',
                          'Female',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          gender = value!;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            // buildTextFieldLabel('Password'),
            DecoratedContainer(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      abou,
                      style: CustomWidgets.style(),
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0.sp),
                      child: DropdownButton<String>(
                        underline: SizedBox(),
                        items: about.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (value) {
                          abou = value!;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Checkbox(
                  activeColor: kPrimaryColor,
                  splashRadius: 0.0,
                  value: checkBox,
                  onChanged: (bool? value) {
                    checkBox = value!;
                    setState(() {});
                  },
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'i am agree to receive emails and notifications ',
                    style: GoogleFonts.poppins(
                      color: kDescriptionColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            BlocConsumer<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state is SignUpLoaded) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return SchoolListScreen();
                    },
                  ));
                }
              },
              builder: (context, state) {
                if (state is SignUpLoading) {
                  return CustomWidgets.loadingIndicator();
                } else {
                  return InkWell(
                    onTap: () async {
                      LoginApiShadePreference.preferences!
                          .setString('email', email.text);

                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SchoolListScreen();
                        },
                      ));
                      // bool validate = checkSignupValidation();
                      // if (validate == true) {
                      //   print(validate);
                      //
                      //   context
                      //       .read<SignUpCubit>()
                      //       .createUser(
                      //           firstName.text.trim(),
                      //           lastName.text.trim(),
                      //           email.text.trim(),
                      //           password.text.trim(),
                      //           teacherM,
                      //           language,
                      //           abou,
                      //           occupation.text.trim(),
                      //           phoneNumber.text.trim(),
                      //           gender,
                      //           dob.text.trim(),
                      //           context)
                      //       .then((value) {});
                      // } else {
                      //   Fluttertoast.showToast(
                      //       msg:
                      //           'Please check all required fields or password is incorrect');
                      // }
                    },
                    child: CustomWidgets.customButton('Sign Up'),
                  );
                }
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You have accoun,  ',
                  style: GoogleFonts.poppins(
                    color: kDescriptionColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return LogInScreen();
                      },
                    ));
                  },
                  child: Text(
                    'Login here!',
                    style: GoogleFonts.poppins(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }

  bool isEmailValid(String email) {
    // Regular expression pattern for validating email
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegex.hasMatch(email);
  }

  checkSignupValidation() {
    if (firstName.text.isEmpty &&
        lastName.text.isEmpty &&
        email.text.isEmpty &&
        password.text.isEmpty &&
        password != confirmPassword) {
      print('false');
      return false;
    } else {
      print('this the true');

      return true;
    }
  }
}
