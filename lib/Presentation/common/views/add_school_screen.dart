import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/add_new_school_cubit.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

import '../../../Data/Repository/add_school_api.dart';
import '../../../Data/image_picking.dart';
import '../../utils/custom_widget/custom_widgets.dart';
import '../../utils/custom_widget/navigator_pop.dart';
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

  final _formKey = GlobalKey<FormState>();

  TextEditingController schName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state1 = TextEditingController();
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const NavigatorPop(),
                  CustomRowWidget(
                    text1: 'Add New School',
                    text2: 'You can add new school from here...',
                    image: 'images/star_c.webp',
                    height: 80.h,
                    width: 80.w,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        var image = await ImagePick.pickImageFromGallery();
                        if (image == null) {
                          Fluttertoast.showToast(msg: 'Image not select');
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
                          child:  image1==null? CircleAvatar(
                            radius: 28.sp,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset('images/add_image.svg',height: 30.sp),
                          ):CircleAvatar(
                            radius: 33.sp,
                            backgroundColor: Colors.white,
                            backgroundImage: FileImage(image1!),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MyTextField(
                    controller: schName,
                    maxLine: 1,
                    hintText: 'School Name',
                    filledColor: kContainerColor,
                    isRequiredField: true,
                    // decoration: textFieldIconDecoration(
                    //     Icons.alternate_email, 'service@gmail.com', null),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MyTextField(
                    controller: address,
                    maxLine: 1,
                    hintText: country == 'United Kingdom'
                        ? 'Number and Street Name'
                        : 'Address',
                    filledColor: kContainerColor,
                    isRequiredField: true,
                    // decoration: textFieldIconDecoration(
                    //     Icons.alternate_email, 'service@gmail.com', null),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MyTextField(
                    controller: city,
                    maxLine: 1,
                    hintText: country == 'United Kingdom' ? 'Locality' : 'City',
                    filledColor: kContainerColor,
                    isRequiredField: true,
                    // decoration: textFieldIconDecoration(
                    //     Icons.alternate_email, 'service@gmail.com', null),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MyTextField(
                    controller: state1,
                    isRequiredField: true,
                    filledColor: kContainerColor,
                    hintText:
                        country == 'United Kingdom' ? 'Post Town' : 'State',
                    // decoration: textFieldIconDecoration(
                    //     Icons.alternate_email, 'service@gmail.com', null),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MyTextField(
                    controller: zipCode,
                    maxLine: 1,
                    hintText:
                        country == 'United Kingdom' ? 'Post code' : 'Zip code',
                    filledColor: kContainerColor,
                    isRequiredField: true,
                    // decoration: textFieldIconDecoration(
                    //     Icons.alternate_email, 'service@gmail.com', null),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MyTextField(
                    controller: email,
                    maxLine: 1,
                    hintText: 'Email Address (optional)',
                    filledColor: kContainerColor,
                    isRequiredField: true,
                    // decoration: textFieldIconDecoration(
                    //     Icons.alternate_email, 'service@gmail.com', null),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MyTextField(
                    controller: phone,
                    maxLine: 1,
                    hintText: 'Phone Number (optional)',
                    filledColor: kContainerColor,
                    isRequiredField: true,
                    // decoration: textFieldIconDecoration(
                    //     Icons.alternate_email, 'service@gmail.com', null),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MyTextField(
                    controller: website,
                    maxLine: 1,
                    hintText: 'Website (optional)',
                    filledColor: kContainerColor,
                    isRequiredField: true,
                    // decoration: textFieldIconDecoration(
                    //     Icons.alternate_email, 'service@gmail.com', null),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BlocConsumer<AddNewSchoolCubit,AddNewSchoolState>(
                   listener: (context, state) {
if(state is AddNewSchoolLoading){
  Dialogs.loadingDialog(context);
}if(state is AddNewSchoolLoaded){
  Navigator.of(context).pop(true);
}if(state is AddNewSchoolError){
  Navigator.of(context).pop(true);
  Fluttertoast.showToast(msg: state.error??"error");
}
                   },
                    builder: (context,  state) {
                     return CustomWidgets.customButton('Continue', onTap: () {
                        if (_formKey.currentState!.validate()) {
                          loading.value = true;


                          Map<String,String> data = {
                            'country_id': country.toString(),
                            'website': website.text.trim(),
                            'school_name': schName.text.trim(),
                            "email":email.text.trim(),

                            'address':address.text.trim(),
                            "phone":phone.text.trim(),
                            "web":website.text.trim(),
                            'locality': city.text.trim(),
                            'post_town': zipCode.text.trim(),
                            'post_code': state1.text.trim(),
                          };
                          context.read<AddNewSchoolCubit>().addSchool(data, image1);}
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.h,
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
