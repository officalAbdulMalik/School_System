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
import 'package:school_system/views/utils/shade_prefrence.dart';

import '../../controllers/apis_repo/auth_apis.dart';
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

  String role = LoginApiShadePreference.preferences!.getString('role')!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        resizeToAvoidBottomInset: false,
        body: ListView(
          padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
          children: [
            SizedBox(
              height: 10.h,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Image.asset('images/satar.png')),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Let\'s Get You Sign up',
                style: GoogleFonts.acme(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 22.sp,
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Welcome Back,\nYou\'ve been missed!',
                style: GoogleFonts.acme(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 17.sp,
                ),
              ),
            ),
            SizedBox(
              height: 13.sp,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.sp),
              height: 50.h,
              width: 340.sp,
              decoration: ContinerDecoration.continerDecoration(),
              child: Row(
                children: [
                  Expanded(
                      flex: role == 'teacher' ? 2 : 1,
                      child: Text(
                        teacherM,
                        style: GoogleFonts.acme(
                            color: Colors.black, fontSize: 11.sp),
                      )),
                  SizedBox(
                    width: 30.w,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0.sp),
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
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.sp),
              height: 50.h,
              width: 340.w,
              decoration: ContinerDecoration.continerDecoration(),
              child: TextFormField(
                controller: firstName,
                style: GoogleFonts.acme(color: Colors.black, fontSize: 11.sp),
                decoration: InputDecoration(
                  hintText: 'First Name',
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
            Container(
              padding: EdgeInsets.only(left: 10.sp),
              height: 50.h,
              width: 340.w,
              decoration: ContinerDecoration.continerDecoration(),
              child: TextFormField(
                controller: lastName,
                style: GoogleFonts.acme(color: Colors.black, fontSize: 11.sp),
                decoration: InputDecoration(
                  hintText: 'Last Name',
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
            Container(
              padding: EdgeInsets.only(left: 10.sp),
              height: 50.h,
              width: 340.w,
              decoration: ContinerDecoration.continerDecoration(),
              child: TextFormField(
                controller: email,
                style: GoogleFonts.acme(color: Colors.black, fontSize: 11.sp),
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.black, fontSize: 11.sp),
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
            Container(
              padding: EdgeInsets.only(left: 10.sp),
              height: 50.h,
              width: 340.w,
              decoration: ContinerDecoration.continerDecoration(),
              child: Center(
                child: ValueListenableBuilder(
                  valueListenable: showPassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: password,
                      style: GoogleFonts.acme(
                          color: Colors.black, fontSize: 11.sp),
                      obscureText: showPassword.value,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: InkWell(
                            onTap: () {
                              showPassword.value = !value;
                            },
                            child: value != true
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
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
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.sp),
              height: 50.h,
              width: 340.w,
              decoration: ContinerDecoration.continerDecoration(),
              child: Center(
                child: ValueListenableBuilder(
                  valueListenable: showCPassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: confirmPassword,
                      style: GoogleFonts.acme(
                          color: Colors.black, fontSize: 11.sp),
                      obscureText: showCPassword.value,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        suffixIcon: InkWell(
                            onTap: () {
                              showCPassword.value = !value;
                            },
                            child: value != true
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
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
            ),
            SizedBox(
              height: role == 'parents' ? 20.h : 0,
            ),
            role == 'parents'
                ? Container(
                    padding: EdgeInsets.only(left: 10.sp),
                    height: 50.h,
                    width: 340.w,
                    decoration: ContinerDecoration.continerDecoration(),
                    child: TextFormField(
                      controller: phoneNumber,
                      style: GoogleFonts.acme(
                          color: Colors.black, fontSize: 11.sp),
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        hintStyle:
                            TextStyle(color: Colors.black, fontSize: 11.sp),
                        border: InputBorder.none,
                      ),
                      cursorColor: kPrimaryColor,
                      // decoration: textFieldIconDecoration(
                      //     Icons.alternate_email, 'service@gmail.com', null),
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: role == 'parents' ? 20.h : 0,
            ),
            role == 'parents'
                ? Container(
                    padding: EdgeInsets.only(left: 10.sp),
                    height: 50.h,
                    width: 340.w,
                    decoration: ContinerDecoration.continerDecoration(),
                    child: TextFormField(
                      controller: dob,
                      style: GoogleFonts.acme(
                          color: Colors.black, fontSize: 11.sp),
                      decoration: InputDecoration(
                        hintText: 'Date Of Birth',
                        hintStyle:
                            TextStyle(color: Colors.black, fontSize: 11.sp),
                        border: InputBorder.none,
                      ),
                      cursorColor: kPrimaryColor,
                      // decoration: textFieldIconDecoration(
                      //     Icons.alternate_email, 'service@gmail.com', null),
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: 20.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.sp),
              height: 50.h,
              width: 340.w,
              decoration: ContinerDecoration.continerDecoration(),
              child: TextFormField(
                controller: occupation,
                style: GoogleFonts.acme(color: Colors.black, fontSize: 11.sp),
                decoration: InputDecoration(
                  hintText: role == 'teacher' ? 'qualification' : 'occupation',
                  hintStyle: TextStyle(color: Colors.black, fontSize: 11.sp),
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
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        language,
                        style: GoogleFonts.acme(
                            color: Colors.black, fontSize: 11.sp),
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
            Container(
              padding: EdgeInsets.only(left: 10.sp),
              height: 50.h,
              width: 340.w,
              decoration: ContinerDecoration.continerDecoration(),
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        gender,
                        style: GoogleFonts.acme(
                            color: Colors.black, fontSize: 11.sp),
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
            Container(
              padding: EdgeInsets.only(left: 10.sp),
              height: 50.h,
              width: 340.w,
              decoration: ContinerDecoration.continerDecoration(),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        abou,
                        style: GoogleFonts.acme(
                            color: Colors.black, fontSize: 11.sp),
                      )),
                  SizedBox(
                    width: 30.sp,
                  ),
                  Expanded(
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
              height: 15.h,
            ),
            Row(
              children: [
                Container(
                  height: 20.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: Checkbox(
                    value: true,
                    onChanged: (bool? value) {},
                  ),
                ),
                SizedBox(
                  width: 10.h,
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'i am agree to receive emails and notifications ',
                    style: GoogleFonts.acme(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.h,
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
                  return Center(
                      child: LoadingAnimationWidget.fallingDot(
                    color: Colors.white,
                    size: 50.sp,
                  ));
                } else {
                  return InkWell(
                    onTap: () async {
                      bool validate = checkSignupValidation();
                      if (validate == true) {
                        print(validate);

                        context
                            .read<SignUpCubit>()
                            .createUser(
                                firstName.text.trim(),
                                lastName.text.trim(),
                                email.text.trim(),
                                password.text.trim(),
                                teacherM,
                                language,
                                abou,
                                occupation.text.trim(),
                                phoneNumber.text.trim(),
                                gender,
                                dob.text.trim(),
                                context)
                            .then((value) {});
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                'Please check all required fields or password is incorrect');
                      }
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
                  'You have account  ',
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
                        return LogInScreen();
                      },
                    ));
                  },
                  child: Text(
                    'Login here!',
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
            SizedBox(
              height: 10.h,
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
