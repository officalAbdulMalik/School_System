import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/sign_up_cubit.dart';
import 'package:school_system/Data/Repository/forget_password_api.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/common/views/otp_screen.dart';
import 'package:school_system/Presentation/utils/custom_widget/container_decoration.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_date_picker.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import '../../utils/colors.dart';
import '../../utils/custom_widget/custom_dop_down.dart';
import '../../utils/custom_widget/custom_row_widget.dart';
import '../../utils/custom_widget/navigator_pop.dart';
import 'all_school_screen.dart';
import 'loginScreen.dart';

class SignUpScreen extends StatefulWidget {
 const SignUpScreen({Key? key}) : super(key: key);

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

  String? dateVal(v) {
    if (v.trim().isEmpty) {
      return "Birth Date Required";
    }

    return null;
  }

  validator() {
    return 'Field is required';
  }

  final _formKey = GlobalKey<FormState>();

  bool checkBox = false;

  String? role = LoginApiShadePreference.preferences?.getString('role');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: ListView(
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
                image: 'images/star_c.webp',
                flex: 6,
              ),
              SizedBox(
                height: 20.sp,
              ),
              CustomDropDown(
                hintText: 'Select Title',
                onChanged: (value) {
                  print(value);
                  teacherM = value!;
                  setState(() {});
                },
                itemsMap: role == 'Teacher'
                    ? ['Mr.',
                  'Mrs.',
                  'Doctor',
                  'Ms.',
                  ].map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      }).toList()
                    : [
          'Mother',
          'Father',
          'GrandMother',
          'Legal Guardian',
          'Other'
          ].map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      }).toList(),
              ),
              SizedBox(
                height: 15.h,
              ),
              MyTextField(
                controller: firstName,
                maxLine: 1,
                hintText: 'First Name',
                filledColor: kContainerColor,
                isRequiredField: true,
                // decoration: textFieldIconDecoration(
                //     Icons.alternate_email, 'service@gmail.com', null),
              ),
              SizedBox(
                height: 15.h,
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
                height: 15.h,
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
                height: 15.h,
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
                height: 15.h,
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
                height: 15.h ,
              ),
              role != 'Teacher'
                  ? MyTextField(
                      controller: phoneNumber,
                      maxLine: 1,
                      hintText: 'Phone',
                      filledColor: kContainerColor,
                      isRequiredField: true,
                      // decoration: textFieldIconDecoration(
                      //     Icons.alternate_email, 'service@gmail.com', null),
                    )
                  : const SizedBox(),
              SizedBox(
                height:   role != 'Teacher' ? 5.h:0.0,
              ),
              role != 'Teacher'
                  ? CustomDatePickerValidateWidget(

                isBorderRequired: false,
                      hintText: 'Birth Date',
                      validationText: 'Date is required',
                      validator: dateVal,
                      controller: dob,

                    )
                  : const SizedBox(),
              SizedBox(
                height:   role != 'Teacher' ? 10.h:0.0,
              ),
              // buildTextFieldLabel('Password'),
              CustomDropDown(
                hintText: 'Language',
                onChanged: (value) {
                  print(value);
                  // selectedSchool = value.toString();
                },
                itemsMap: [
                  'English',
                  'Scots',
                  'Welsh',
                ].map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 15.h,
              ),
              CustomDropDown(
                hintText: 'Gender',
                onChanged: (value) {
                  print(value);
                  // selectedSchool = value.toString();
                },
                itemsMap: [
                  'Male',
                  'Female',
                ].map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 15.h,
              ),
              // buildTextFieldLabel('Password'),
              CustomDropDown(
                hintText: 'How did you hear about us?',
                onChanged: (value) {
                  print(value);
                  // selectedSchool = value.toString();
                },
                itemsMap: [
                  'Parent',
                  'Teacher',
                  'School',
                  'SocialNetwork',
                  'Search Engine',
                  'Other'
                ].map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: 35.h,
                width: 1.sw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    Text(
                      'I agree to the terms and conditions.',
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                        color: kDescriptionColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,

                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              BlocConsumer<SignUpCubit, SignUpState>(
                listener: (context, state) {
                  if (state is SignUpLoading) {
                    Dialogs.loadingDialog(context);
                  }
                  if (state is SignUpLoaded) {
                    ForgetPasswordApi.sendEmail(email.text.trim());
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return OtpScreen(
                          firstTime: true,
                          email: email.text.trim(),
                        );
                      },
                    ));
                  }
                  if(state is SignUpError){
                    Navigator.of(context).pop(true);
                  }
                },
                builder: (context, state) {
                  return CustomWidgets.customButton('Sign Up', onTap: () async {
    LoginApiShadePreference.preferences!
        .setString('email', email.text);
    if (_formKey.currentState!.validate()) {
    bool valEmail = isEmailValid(email.text);
    if (valEmail == true) {
    if(password.text.trim() == confirmPassword.text.trim()){
    if(checkBox == true){
    context.read<SignUpCubit>().createUser(
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
    context);
    }else{
    Fluttertoast.showToast(
    msg: "Check Required");
    }

    }else{
    Fluttertoast.showToast(
    msg: "The confirmed password does not match");
    }

    } else {
    Fluttertoast.showToast(
    msg: "The email format is not correct.");
    }
    }

    });
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'If You have account, ',
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
      ),
    );
  }

  bool isEmailValid(String email) {
    // Regular expression pattern for validating email
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegex.hasMatch(email);
  }
}
