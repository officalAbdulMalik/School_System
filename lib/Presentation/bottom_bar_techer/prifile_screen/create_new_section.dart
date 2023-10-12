import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_dop_down.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/controllers/cubits/common_cubit/add_metting_cubit.dart';
import 'package:school_system/controllers/cubits/common_cubit/get_parents_teachers_cubit.dart';
import 'package:school_system/controllers/cubits/teacher_cubit/add_section_cubit.dart';

import '../../../Data/Repository/teacher_add_section.dart';
import '../../../controllers/cubits/common_cubit/get_all_school_cubit.dart';
import '../../common/views/loginScreen.dart';
import '../../utils/custom_widget/custom_widgets.dart';

class CreateSection extends StatefulWidget {
  CreateSection({Key? key}) : super(key: key);

  @override
  State<CreateSection> createState() => _CreateSectionState();
}

class _CreateSectionState extends State<CreateSection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController sectionName = TextEditingController();

  String selectedSchool = '';
  final formKey = GlobalKey<FormState>();

  ValueNotifier<bool> loading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
          children: [
            SizedBox(
              height: 30.h,
            ),
            CustomRowWidget(
              text1: 'Add New Section',
              text2: 'Add New section to over school',
              image: 'add_s_star.png',
            ),
            SizedBox(
              height: 20.h,
            ),
            MyTextField(
              hintText: 'Section Name',
              controller: sectionName,
              filledColor: kContainerColor,
              isRequiredField: true,
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 10.sp),
              height: 40.h,
              width: 340.w,
              decoration: BoxDecoration(
                color: kContainerColor,
                borderRadius: BorderRadius.circular(15.sp),
              ),
              child: BlocBuilder<GetAllSchoolCubit, GetAllSchoolState>(
                builder: (context, state) {
                  if (state is GetAllSchoolLoaded) {
                    print(state.model.data!.length);
                    return state.model.data!.isNotEmpty
                        ? CustomDropDown(
                            hintText: 'Schools',
                            onChanged: (value) {
                              print(value);
                              selectedSchool = value.toString();
                            },
                            itemsMap: state.model.data!.map((e) {
                              return DropdownMenuItem(
                                value: e.id,
                                child: Text(
                                  e.schoolName!,
                                ),
                              );
                            }).toList(),
                          )
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'School not found',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                  } else if (state is GetAllSchoolError) {
                    return Text(state.error!);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            BlocConsumer<AddSectionCubit, AddSectionState>(
              listener: (context, state) {
                if (state is AddSectionError) {
                  Fluttertoast.showToast(msg: state.error!);
                }
                if (state is AddSectionLoaded) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is AddSectionLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AddSectionCubit>().addSection(
                            sectionName.text.trim(), selectedSchool);
                      }
                    },
                    child: CustomWidgets.customButton('Save'),
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
