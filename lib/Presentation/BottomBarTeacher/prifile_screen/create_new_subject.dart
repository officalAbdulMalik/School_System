import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/create_subjects_cubit.dart';
import 'package:school_system/Controllers/Cubits/TeacherCubit/show_teacher_class_cubit.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/container_decoration.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_dop_down.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';

import '../../utils/custom_widget/custom_widgets.dart';

class CrateNewSubject extends StatefulWidget {
  const CrateNewSubject({Key? key}) : super(key: key);

  @override
  State<CrateNewSubject> createState() => _CrateNewSubjectState();
}

class _CrateNewSubjectState extends State<CrateNewSubject> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List types = ['Practical', 'Theory'];

  List code = ['MA', 'SC', 'EN', 'PT', 'HN'];

  String slectedClass = '';
  String selectedType = '';
  String codeT = '';

  TextEditingController nameController = TextEditingController();

  final key = GlobalKey<FormState>();

  ValueNotifier<bool> loading = ValueNotifier(false);

  @override
  void dispose() {
    nameController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Form(
        key: key,
        child: ListView(
          padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
          children: [
            SizedBox(
              height: 30.h,
            ),
            CustomRowWidget(
              text1: 'Add New Subject',
              text2: 'You can add new subject from here...',
              image: 'add_s_star.png',
            ),
            SizedBox(
              height: 20.h,
            ),
            DecoratedContainer(
              child: MyTextField(
                controller: nameController,
                filledColor: kContainerColor,
                hintText: 'Subject Name',
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            BlocBuilder<ShowTeacherClassCubit, ShowTeacherClassState>(
              builder: (context, state) {
                if (state is ShowTeacherClassLoaded) {
                  print(state.clasess.length);
                  return state.clasess.isNotEmpty
                      ? CustomDropDown(
                          hintText: 'Classes',
                          onChanged: (value) {
                            print(value);
                            slectedClass = value.toString();
                          },
                          itemsMap: state.clasess.map((e) {
                            return DropdownMenuItem(
                              value: e.id,
                              child: Text(
                                e.name!,
                              ),
                            );
                          }).toList(),
                        )
                      : Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Class not found',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                } else if (state is ShowTeacherClassError) {
                  return Text(state.error!);
                } else {
                  return const SizedBox();
                }
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomDropDown(
              hintText: 'Type',
              onChanged: (value) {
                selectedType = value.toString();
              },
              itemsMap: types.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomDropDown(
              hintText: 'Code',
              onChanged: (value) {
                codeT = value.toString();
              },
              itemsMap: code.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 20.h,
            ),
            BlocConsumer<CreateSubjectsCubit, CreateSubjectsState>(
              listener: (context, state) {
                if (state is CreateSubjectsError) {
                  Fluttertoast.showToast(msg: state.error!);
                }
                if (state is CreateSubjectsLoaded) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is CreateSubjectsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return CustomWidgets.customButton('Save', onTap: () {
                    if (key.currentState!.validate()) {
                      context.read<CreateSubjectsCubit>().addSubjectToClass(
                        slectedClass,
                        nameController.text.trim(),
                        selectedType,
                        codeT,
                      );
                    }
                  });
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
