import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Controllers/Cubits/ParentCubit/add_child_cubit.dart';
import 'package:school_system/Presentation/BottomBarParent/profile_screens/show_children.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_date_picker.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_dop_down.dart';
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


  final _formKey = GlobalKey<FormState>();

  String? dateVal(v) {
    if (v.trim().isEmpty) {
      return "Birth Date Required";
    }}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const NavigatorPop(),
                  CustomRowWidget(
                    text1: 'Add New Kid!',
                    text2: 'You can add new kids from here.',
                    image: 'images/star_e.webp',
                    height: 70.h,
                    width: 70.w,
                  ),
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () async {
                      var image = await ImagePick.pickImageFromGallery();
                      image1 = image;
                      setState(() {});
                    },
                    child: CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.amber,
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child:  image1 ==null? CircleAvatar(
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
                  SizedBox(height: 15.h,),
                  CustomDropDown(
                    hintText: relation,
                    onChanged: (value) {
                      print(value);
                      relation = value!;
                      setState(() {});
                    },
                    itemsMap: <String>[
                      'Mother',
                      'Father',
                      'Brother',
                      'Sister',
                      'Grand Father',
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
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    controller: firstName,
                    hintText: 'First Name',
                    filledColor: kContainerColor,
                    isRequiredField: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    isRequiredField: true,
                    controller: lastName,
                    hintText: 'Last Name',
                    filledColor: kContainerColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomDatePickerValidateWidget(

                    isBorderRequired: false,
                    hintText: 'Select Birth Date',
                    validationText: 'Date is required',
                    controller: dob,

                    validator: dateVal,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomDropDown(
                    hintText: gender,
                    onChanged: (value) {
                      print(value);
                      gender = value!;
                      setState(() {});
                    },
                    itemsMap:<String>[
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
                  const SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<AddChildCubit, AddChildState>(
                    listener: (context, state) {
                      if (state is AddChildLoading) {
                        Dialogs.loadingDialog(context);
                      }
                      if (state is AddChildError) {
                        Navigator.of(context).pop(true);
                        Fluttertoast.showToast(msg: state.error!);
                      }
                      if (state is AddChildLoaded) {
                        Navigator.pop(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return ShowChildren();
                          },
                        ));
                      }
                    },
                    builder: (context, state) {
                      return CustomWidgets.customButton('Add Child', onTap: () {
                        if(_formKey.currentState!.validate()){
                          if(image1 != null) {
                            context.read<AddChildCubit>().addChild(
                                firstName: firstName.text.trim(),
                                lastName: lastName.text.trim(),
                                relation: relation,
                                dob: dob.text.trim(),
                                gender: gender,
                                image: image1!.path);
                          }else{
                            Fluttertoast.showToast(msg: 'Add Image');
                          }
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

  // validate() {
  //   if (image1 == null) {
  //     Fluttertoast.showToast(msg: 'Add Image');
  //     return false;
  //   } else if (firstName.text.isEmpty) {
  //     Fluttertoast.showToast(msg: 'First name is required');
  //     return false;
  //   } else if (lastName.text.isEmpty) {
  //     Fluttertoast.showToast(msg: 'Last  name is required');
  //     return false;
  //   } else if (gender == 'Gender*') {
  //     Fluttertoast.showToast(msg: 'Select  Gender ');
  //     return false;
  //   } else if (relation == 'Relation') {
  //     Fluttertoast.showToast(msg: 'Select  Relation');
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }
}
