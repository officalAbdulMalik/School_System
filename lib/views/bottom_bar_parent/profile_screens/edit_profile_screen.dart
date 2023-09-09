import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/views/utils/app_images.dart';
import 'package:school_system/views/utils/custom_widget/my_text_field.dart';
import 'package:school_system/views/utils/shade_prefrence.dart';

import '../../../controllers/apis_repo/update_profile.dart';
import '../../../controllers/image_picking.dart';
import '../../../models/user_data_model.dart';
import '../../utils/colors.dart';
import '../../utils/custom_widget/container_decoration.dart';
import '../../utils/custom_widget/custom_widgets.dart';
import '../../utils/custom_widget/my_text.dart';

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

  final formKey = GlobalKey<FormState>();
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
    dob = widget.data!.dob ?? "";
    about = widget.data!.hearAboutUs ?? "";
    image1 = widget.data!.image!;
    gender = widget.data!.gender ?? "Select Gender";
    print('===================== this is title  ${title}');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              'Edit My Profile',
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(
                              height: 3.sp,
                            ),
                            const MyText(
                              'Edit your profile details here.',
                              color: Color(0xFF6B7280),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                          width: 86.sp,
                          height: 86.sp,
                          child: Image.asset('images/satar.png')),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(2.sp),
                      width: 85.sp,
                      height: 85.sp,
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: OvalBorder(
                          side: BorderSide(width: 1, color: Color(0xFFF7D55C)),
                        ),
                      ),
                      child: Stack(
                        children: [
                          showImage == null
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
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                shape: BoxShape.circle),
                          ),
                          Center(
                              child: InkWell(
                                  onTap: () async {
                                    final image =
                                    await ImagePick.pickImageFromGallery();
                                    if (image != null) {
                                      setState(() {
                                        image1 = image.path;
                                        showImage = image;
                                      });
                                    } else {
                                      Fluttertoast.showToast(msg: 'Image Is Empty');
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    AppImages.cameraIcon,
                                    color: Colors.white,
                                  ))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    height: 44.sp,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF3F4F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: MyText(
                              title,
                              color: Colors.black,
                              fontSize: 14.sp,
                            )),
                        SizedBox(
                          width: 30.w,
                        ),
                        Expanded(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: SizedBox(),
                            icon: const Icon(Icons.keyboard_arrow_down_outlined),
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MyTextField(
                    filledColor: const Color(0xFFF3F4F6),
                    isRequiredField: true,
                    hintText: 'First Name',
                    controller: firsName,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    filledColor: const Color(0xFFF3F4F6),
                    isRequiredField: true,
                    hintText: 'Last Name',
                    controller: secondName,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    filledColor: const Color(0xFFF3F4F6),
                    isRequiredField: true,
                    hintText: 'Email',
                    controller: email,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    height: 44.sp,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF3F4F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: MyText(
                            language,
                            color: Colors.black, fontSize: 14.sp,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              icon: const Icon(Icons.keyboard_arrow_down_outlined),
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

                  SizedBox(
                    height: 20.h,
                  ),

                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.sp),
              child: Row(
                children: [

                  Expanded(child: InkWell(
                    onTap: (){
                      FocusScope.of(context).unfocus();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 44.sp,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF6B7280),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Center(
                        child: MyText(
                          'Cancel',
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,

                        ),
                      ),
                    ),
                  )),
                  SizedBox(width: 8.sp,),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: loading,
                      builder: (context, value, child) {
                        if (value == false) {
                          return InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate() &&showImage != null ) {
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
                              }else{
                                validate();
                              }
                            },
                            child: Container(

                              height: 44.sp,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF3DAEF5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Center(
                                child: MyText(
                                  'Save',
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),

                              ),
                            ),
                          );
                        } else {
                          return CustomWidgets.loadingIndicator();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
             SizedBox(
              height: 15.sp,
            ),
          ],
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
