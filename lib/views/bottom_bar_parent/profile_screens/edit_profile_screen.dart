import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/views/utils/shade_prefrence.dart';

import '../../../controllers/apis_repo/update_profile.dart';
import '../../../controllers/image_picking.dart';
import '../../../models/user_data_model.dart';
import '../../utils/colors.dart';
import '../../utils/custom_widget/container_decoration.dart';
import '../../utils/custom_widget/custom_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key, required this.data});

  User? data;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool check = false;

  TextEditingController firsName = TextEditingController();
  TextEditingController secondName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController occupation = TextEditingController();
  String language = '';
  String gender = '';
  String image1 = '';
  ValueNotifier<bool> loading = ValueNotifier(false);

  String title = '';
  String dob = '';
  String about = '';
  File? showImage;

  List<String> teacher = [
    'Mr.',
    'Mrs.',
    'Doctor',
    'Ms.',
  ];

  @override
  void initState() {
    firsName.text = widget.data!.firstName! ?? "";
    secondName.text = widget.data!.lastName! ?? "";
    email.text = widget.data!.email! ?? "";
    language = widget.data!.language ?? "Preferred Language ";
    title = widget.data!.title ?? "";
    title = widget.data!.dob ?? "";
    title = widget.data!.hearAboutUs ?? "";
    image1 = widget.data!.image!;
    gender = widget.data!.gender ?? "Select Gender";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: kButtonColor,
        title: Text(
          'Your Profile ',
          style: GoogleFonts.acme(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () async {
                  final image = await ImagePick.pickImageFromGallery();
                  if (image != null) {
                    setState(() {
                      image1 = image.path;
                      showImage = image;
                    });
                  } else {
                    Fluttertoast.showToast(msg: 'Image Is Empty');
                  }
                },
                child: CircleAvatar(
                  radius: 50,
                  child: showImage == null
                      ? CircleAvatar(
                          foregroundImage: widget.data!.image!.isEmpty
                              ? AssetImage("images/users.png")
                              : NetworkImage(widget.data!.image!)
                                  as ImageProvider,
                          radius: 50,
                        )
                      : CircleAvatar(
                          foregroundImage: FileImage(showImage!),
                          radius: 50,
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.center,
                "Please enter your fullname, email and \n optional profile picture",
                style: GoogleFonts.acme(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 10.sp),
                height: 50.h,
                width: 340.sp,
                decoration: ContinerDecoration.continerDecoration(),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text(
                          title,
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
                          items: teacher.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (value) {
                            title = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                height: 50,
                width: 340,
                decoration: ContinerDecoration.continerDecoration(),
                child: TextFormField(
                  controller: firsName,
                  style: GoogleFonts.acme(color: Colors.black, fontSize: 11.sp),
                  decoration: const InputDecoration(
                    hintText: 'First Name',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 12),
                    border: InputBorder.none,
                  ),
                  cursorColor: kPrimaryColor,
                  // decoration: textFieldIconDecoration(
                  //     Icons.alternate_email, 'service@gmail.com', null),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                height: 50,
                width: 340,
                decoration: ContinerDecoration.continerDecoration(),
                child: TextFormField(
                  controller: secondName,
                  style: GoogleFonts.acme(color: Colors.black, fontSize: 11.sp),
                  decoration: const InputDecoration(
                    hintText: 'Last Name',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 12),
                    border: InputBorder.none,
                  ),
                  cursorColor: kPrimaryColor,
                  // decoration: textFieldIconDecoration(
                  //     Icons.alternate_email, 'service@gmail.com', null),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                height: 50,
                width: 340,
                decoration: ContinerDecoration.continerDecoration(),
                child: TextFormField(
                  controller: email,
                  style: GoogleFonts.acme(color: Colors.black, fontSize: 11.sp),
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.black, fontSize: 12),
                    border: InputBorder.none,
                  ),
                  cursorColor: kPrimaryColor,
                  // decoration: textFieldIconDecoration(
                  //     Icons.alternate_email, 'service@gmail.com', null),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                height: 50,
                width: 340,
                decoration: ContinerDecoration.continerDecoration(),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        language,
                        style: GoogleFonts.acme(
                            color: Colors.black, fontSize: 11.sp),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          items: <String>[
                            'English',
                            'Scots',
                            'Welsh',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
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
              const SizedBox(
                height: 20,
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
                    hintText: LoginApiShadePreference.preferences!
                                .getString('role') ==
                            'teacher'
                        ? 'qualification'
                        : 'occupation',
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Transform.scale(
                      alignment: Alignment.bottomCenter,
                      scale: 1.6,
                      child: Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        checkColor: Colors.white,
                        activeColor: Colors.blue,
                        tristate: false,
                        value: check,
                        onChanged: (value) {
                          check = value!;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 6,
                    child: RichText(
                      text: TextSpan(
                        text: 'I agree to receive emails, about ...',
                        style: GoogleFonts.acme(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: loading,
                builder: (context, value, child) {
                  if (value == false) {
                    return InkWell(
                      onTap: () {
                        bool val = validate();
                        if (val == true) {
                          loading.value = true;
                          UpdateProfile.updateProfile(
                                  context: context,
                                  firstName: firsName.text.trim(),
                                  lastName: secondName.text.trim(),
                                  email: email.text.trim(),
                                  language: language,
                                  title: title,
                                  about: about,
                                  occupation: occupation.text.trim(),
                                  dob: dob,
                                  gender: gender,
                                  image: image1)
                              .then((value) {
                            loading.value = false;
                          });
                        }
                      },
                      child: CustomWidgets.customButton('Update Profile'),
                    );
                  } else {
                    return CustomWidgets.loadingIndicator();
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  validate() {
    if (showImage == null) {
      Fluttertoast.showToast(msg: 'Image is Required');
      return false;
    } else if (firsName.text.isEmpty) {
      Fluttertoast.showToast(msg: 'First name is required');
      return false;
    } else if (secondName.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Second name is required');
      return false;
    } else {
      return true;
    }
  }
}
