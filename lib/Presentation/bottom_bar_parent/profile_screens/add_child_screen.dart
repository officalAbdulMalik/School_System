import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/Presentation/utils/custom_widget/navigator_pop.dart';

import '../../../Data/Repository/add_child_api.dart';
import '../../../Data/image_picking.dart';
import '../../utils/colors.dart';
import '../../utils/custom_widget/container_decoration.dart';
import '../../utils/custom_widget/custom_widgets.dart';

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({super.key});

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  String gender = "Gender*", relation = "Relation";

  TextEditingController lastName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController dob = TextEditingController();

  ValueNotifier<bool> loading = ValueNotifier(false);
  File? image1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                NavigatorPop(),
                CustomRowWidget(
                  text1: 'Add New Kid!',
                  text2: 'You can add new kids from here.',
                  image: 'sign_star.png',
                  flex: 6,
                ),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () async {
                    var image = await ImagePick.pickImageFromGallery();
                    image1 = image;
                    setState(() {});
                  },
                  child: CircleAvatar(
                    radius: 35,
                    child: CircleAvatar(
                      backgroundColor: kButtonColor,
                      backgroundImage: image1 == null
                          ? AssetImage('images/prof.png')
                          : FileImage(image1!) as ImageProvider,
                      radius: 33,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: firstName,
                  hintText: 'First Name',
                  filledColor: kContainerColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: lastName,
                  hintText: 'Last Name',
                  filledColor: kContainerColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: dob,
                  hintText: 'Date Of Birth',
                  filledColor: kContainerColor,
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
                          flex: 1,
                          child: Text(
                            gender,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                      Spacer(
                        flex: 1,
                      ),
                      SizedBox(
                        width: 35,
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: DropdownButton<String>(
                            underline: const SizedBox(),
                            items: <String>[
                              'Male',
                              'Female',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
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
                          flex: 3,
                          child: Text(
                            relation,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: DropdownButton<String>(
                            underline: const SizedBox(),
                            items: <String>[
                              'Mother',
                              'Father',
                              'Brother',
                              'Sister',
                              'Grand Father',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              relation = value!;
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
                ValueListenableBuilder(
                  valueListenable: loading,
                  builder: (context, value, child) {
                    if (value == false) {
                      return InkWell(
                        onTap: () {
                          bool val = validate();
                          if (val == true) {
                            loading.value = true;
                            AddChildRepo.addChild(
                                    context: context,
                                    firstName: firstName.text.trim(),
                                    lastName: lastName.text.trim(),
                                    relation: relation,
                                    dob: dob.text.trim(),
                                    gender: gender,
                                    image: image1!.path)
                                .then((value) {
                              loading.value = false;
                            });
                          }
                        },
                        child: CustomWidgets.customButton('Add Child'),
                      );
                    } else {
                      return CustomWidgets.loadingIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  validate() {
    if (image1 == null) {
      Fluttertoast.showToast(msg: 'Add Image');
      return false;
    } else if (firstName.text.isEmpty) {
      Fluttertoast.showToast(msg: 'First name is required');
      return false;
    } else if (lastName.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Last  name is required');
      return false;
    } else if (gender == 'Gender*') {
      Fluttertoast.showToast(msg: 'Select  Gender ');
      return false;
    } else if (relation == 'Relation') {
      Fluttertoast.showToast(msg: 'Select  Relation');
      return false;
    } else {
      return true;
    }
  }
}
