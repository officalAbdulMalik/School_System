import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/views/bottom_bar_techer/metting_screen.dart';
import 'package:school_system/views/utils/colors.dart';
import 'package:school_system/views/utils/custom_widget/container_decoration.dart';
import 'package:school_system/views/common/otp_screen.dart';
import 'package:school_system/views/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/views/utils/shade_prefrence.dart';

import '../../controllers/apis_repo/add_school_api.dart';
import '../../controllers/image_picking.dart';
import '../utils/custom_widget/custom_widgets.dart';
import '../utils/custom_widget/navigator_pop.dart';
import 'all_school_screen.dart';

class AddSchoolScreen extends StatefulWidget {
  const AddSchoolScreen({Key? key}) : super(key: key);

  @override
  State<AddSchoolScreen> createState() => _AddSchoolScreenState();
}

class _AddSchoolScreenState extends State<AddSchoolScreen> {
  String? country = LoginApiShadePreference.preferences!.getString('country');

  ValueNotifier<bool> loading = ValueNotifier(false);

  File? image1;

  TextEditingController schName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NavigatorPop(),
                CustomRowWidget(
                  text1: 'Add New School',
                  text2: 'You can add new school from here...',
                ),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () async {
                      var image = await ImagePick.pickImageFromGallery();
                      if (image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          'Image is Not select',
                          style: CustomWidgets.textStyle(
                              color: Colors.black,
                              size: 11.0,
                              weight: FontWeight.w500),
                        )));
                      } else {
                        image1 = image;
                        setState(() {});
                      }
                    },
                    child: CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.amber,
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 28.sp,
                          backgroundColor: Colors.white,
                          backgroundImage: image1 == null
                              ? AssetImage('images/camra.png')
                              : FileImage(image1!) as ImageProvider,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                DecoratedContainer(
                  child: TextFormField(
                    style: CustomWidgets.style(),
                    controller: schName,
                    decoration: InputDecoration(
                      hintText: 'School Name',
                      hintStyle: CustomWidgets.style(),
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
                DecoratedContainer(
                  child: TextFormField(
                    style: CustomWidgets.style(),
                    controller: address,
                    decoration: InputDecoration(
                      hintText: country == 'United Kingdom'
                          ? 'Number and Street Name'
                          : 'Address',
                      hintStyle: CustomWidgets.style(),
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
                DecoratedContainer(
                  child: TextFormField(
                    style: CustomWidgets.style(),
                    controller: city,
                    decoration: InputDecoration(
                      hintText:
                          country == 'United Kingdom' ? 'Locality' : 'City',
                      hintStyle: CustomWidgets.style(),
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
                DecoratedContainer(
                  child: TextFormField(
                    style: CustomWidgets.style(),
                    controller: state,
                    decoration: InputDecoration(
                      hintText:
                          country == 'United Kingdom' ? 'Post Town' : 'State',
                      hintStyle: CustomWidgets.style(),
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
                DecoratedContainer(
                  child: TextFormField(
                    style: CustomWidgets.style(),
                    controller: zipCode,
                    decoration: InputDecoration(
                      hintText: country == 'United Kingdom'
                          ? 'Post code'
                          : 'Zip code',
                      hintStyle: CustomWidgets.style(),
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
                DecoratedContainer(
                  child: TextFormField(
                    style: CustomWidgets.style(),
                    controller: email,
                    decoration: InputDecoration(
                      hintText: 'Email Address (optional)',
                      hintStyle: CustomWidgets.style(),
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
                DecoratedContainer(
                  child: TextFormField(
                    style: CustomWidgets.style(),
                    controller: phone,
                    decoration: InputDecoration(
                      hintText: 'Phone Number (optional)',
                      hintStyle: CustomWidgets.style(),
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
                DecoratedContainer(
                  child: TextFormField(
                    style: CustomWidgets.style(),
                    controller: website,
                    decoration: InputDecoration(
                      hintText: 'Website (optional)',
                      hintStyle: CustomWidgets.style(),
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
                InkWell(
                  onTap: () async {
                    bool value = vailidate();
                    if (value == true) {
                      if (image1 != null) {
                        loading.value = true;
                        AddSchoolApi.addSchool(
                                context: context,
                                scName: schName.text.trim(),
                                email: email.text.trim(),
                                id: country,
                                address: address.text.trim(),
                                phNo: phone.text.trim(),
                                web: website.text.trim(),
                                local: city.text.trim(),
                                zip: zipCode.text.trim(),
                                postCode: state.text.trim(),
                                image: image1)
                            .then((value) {
                          if (value == 200) {
                            loading.value = false;
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return SchoolListScreen();
                              },
                            ));
                          }
                        });
                      } else {
                        Fluttertoast.showToast(msg: 'Image is Required');
                      }
                    }
                  },
                  child: ValueListenableBuilder(
                    valueListenable: loading,
                    builder: (context, value, child) {
                      if (value != true) {
                        return CustomWidgets.customButton('Continue');
                      } else {
                        return CustomWidgets.loadingIndicator();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool vailidate() {
    if (schName.text.isNotEmpty &&
        state.text.isNotEmpty &&
        zipCode.text.isNotEmpty &&
        address.text.isNotEmpty &&
        city.text.isNotEmpty) {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fill The From Correctly')));
      return false;
    }
  }
}
