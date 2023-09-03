import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/views/bottom_bar_techer/metting_screen.dart';
import 'package:school_system/views/utils/colors.dart';
import 'package:school_system/views/utils/custom_widget/container_decoration.dart';
import 'package:school_system/views/common/verify_email_screen.dart';

import '../../controllers/apis_repo/add_school_api.dart';
import '../../controllers/image_picking.dart';
import 'all_school_screen.dart';

class AddSchoolScreen extends StatefulWidget {
  const AddSchoolScreen({Key? key}) : super(key: key);

  @override
  State<AddSchoolScreen> createState() => _AddSchoolScreenState();
}

class _AddSchoolScreenState extends State<AddSchoolScreen> {
  String country = 'United Kingdom';

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
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kButtonColor,
        title: Text(
          'Add Your School',
          style: GoogleFonts.acme(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 21.sp),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () async {
                          var image = await ImagePick.pickImageFromGallery();
                          if (image == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Image is Not select')));
                          } else {
                            image1 = image;
                            setState(() {});
                          }
                        },
                        child: CircleAvatar(
                          radius: 50.sp,
                          backgroundImage: image1 == null
                              ? const AssetImage('images/white.png')
                              : FileImage(image1!) as ImageProvider,
                          child: image1 == null
                              ? Center(
                                  child: Text(
                                  'Select Image',
                                  style: GoogleFonts.acme(
                                    color: Colors.black,
                                  ),
                                ))
                              : SizedBox(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 50.h,
                      width: 340.w,
                      decoration: ContinerDecoration.continerDecoration(),
                      child: ListTile(
                        leading: SizedBox(
                          height: 30.h,
                          width: 30.w,
                          child: Image.asset(country == 'United Kingdom'
                              ? 'images/un.png'
                              : 'images/us.png'),
                        ),
                        title: Text(
                          country,
                          style: GoogleFonts.acme(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: DropdownButton<String>(
                          underline: SizedBox(),
                          items: <String>[
                            'United Kingdom',
                            'United State',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            country = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 50.h,
                      width: 340.w,
                      decoration: ContinerDecoration.continerDecoration(),
                      child: TextFormField(
                        controller: schName,
                        decoration: InputDecoration(
                          hintText: 'School Name',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 12.sp),
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
                        controller: address,
                        decoration: InputDecoration(
                          hintText: country == 'United Kingdom'
                              ? 'Number and Street Name'
                              : 'Address',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 12.sp),
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
                      padding: EdgeInsets.only(left: 10),
                      height: 50.h,
                      width: 340.w,
                      decoration: ContinerDecoration.continerDecoration(),
                      child: TextFormField(
                        controller: city,
                        decoration: InputDecoration(
                          hintText:
                              country == 'United Kingdom' ? 'Locality' : 'City',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 12.sp),
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
                        controller: state,
                        decoration: InputDecoration(
                          hintText: country == 'United Kingdom'
                              ? 'Post Town'
                              : 'State',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 12.sp),
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
                        controller: zipCode,
                        decoration: InputDecoration(
                          hintText: country == 'United Kingdom'
                              ? 'Post code'
                              : 'Zip code',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 12.sp),
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
                        decoration: InputDecoration(
                          hintText: 'Email Address (optional)',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 12.sp),
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
                        controller: phone,
                        decoration: const InputDecoration(
                          hintText: 'Phone Number (optional)',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 12),
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
                        controller: website,
                        decoration: InputDecoration(
                          hintText: 'Website (optional)',
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 12.sp),
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
                        }
                      },
                      child: ValueListenableBuilder(
                        valueListenable: loading,
                        builder: (context, value, child) {
                          if (value != true) {
                            return Container(
                              height: 50.h,
                              width: 340.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.sp),
                                gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF2A3B5D),
                                      const Color(0xFF3D529B),
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(1.0, 0.0),
                                    stops: [0.1, 1.0],
                                    tileMode: TileMode.decal),
                              ),
                              child: Center(
                                  child: Text(
                                'Continue',
                                style: GoogleFonts.acme(
                                    color: Colors.white, fontSize: 20.sp),
                              )),
                            );
                          } else {
                            return Center(
                                child: LoadingAnimationWidget.fallingDot(
                              color: Colors.white,
                              size: 50.sp,
                            ));
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
          ],
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
