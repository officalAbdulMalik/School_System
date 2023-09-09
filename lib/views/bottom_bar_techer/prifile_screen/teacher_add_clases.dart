import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/controllers/global_list.dart';
import 'package:school_system/views/common/loginScreen.dart';
import 'package:school_system/views/bottom_bar_techer/prifile_screen/show_class.dart';
import 'package:school_system/views/utils/colors.dart';
import 'package:school_system/views/utils/custom_widget/container_decoration.dart';
import 'package:school_system/views/utils/custom_widget/custom_dop_down.dart';
import 'package:school_system/views/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/views/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/views/utils/custom_widget/my_text_field.dart';

import '../../../controllers/apis_repo/teacher_apis/teacher_create_class.dart';
import '../../utils/shade_prefrence.dart';

class TeacherAddClass extends StatefulWidget {
  TeacherAddClass({Key? key, required this.sectionId, required this.schoolId})
      : super(key: key);

  String sectionId;
  String schoolId;

  @override
  State<TeacherAddClass> createState() => _TeacherAddClassState();
}

ValueNotifier<bool> loading = ValueNotifier(false);

String country = 'United Kingdomw';

String selectedGrade = 'Select Grade';
String selectedSection = 'Select Section';
String selectedSubject = 'Select Subject';

String language = 'English';

TextEditingController schoolName = TextEditingController();

List<String> uk = [
  "Nursery",
  "Reception",
  "Kindergarten",
  "Year 1",
  "Year 2",
  "Year 3",
  "Year 4",
  "Year 5",
  "Year 6",
  "Year 7",
  "Year 8",
  "Year 9",
  "Year 5",
  "Other",
];
List<String> usa = [
  "Nursery",
  "Pre School",
  "Kindergarten",
  "1st Grade",
  "2nd Grade",
  "3rd Grade",
  "4th Grade",
  " 5th Grade",
  "6th Grade",
  "7th Grade",
  " 8th Grade",
  "9th Grade",
  "10th Grade",
  "Other",
];

List<String> subject = [
  "Maths",
  "English",
  "History",
  "Science",
  "English",
  "Gerontocracy",
  "Other",
];

List<String> section = [
  'section1',
  'section2',
  'section3',
  'section4',
];

final formKey = GlobalKey<FormState>();

class _TeacherAddClassState extends State<TeacherAddClass> {
  var country = LoginApiShadePreference.preferences!.get('country');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomRowWidget(
                      text1: 'Add New Class',
                      text2: 'Inspire students through a newly added class.',
                      image: 'add_s_star.png',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    MyTextField(
                      hintText: 'Class Name',
                      controller: schoolName,
                      filledColor: kContainerColor,
                      isRequiredField: true,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.sp),
                      height: 40.h,
                      width: 340.w,
                      decoration: BoxDecoration(
                        color: kContainerColor,
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                selectedGrade,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                          const Spacer(
                            flex: 1,
                          ),
                          Expanded(
                            flex: 2,
                            child: DropdownButton<String>(
                              underline: SizedBox(),
                              items: country == 'US'
                                  ? usa.map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList()
                                  : uk.map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                              onChanged: (value) {
                                selectedGrade = value!;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.sp),
                      height: 40.h,
                      width: 340.w,
                      decoration: BoxDecoration(
                        color: kContainerColor,
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Text(
                                selectedSubject,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                          const Spacer(
                            flex: 1,
                          ),
                          Expanded(
                            flex: 2,
                            child: DropdownButton<String>(
                              underline: SizedBox(),
                              items: subject.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (value) {
                                selectedSubject = value!;
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
                    const SizedBox(height: 20),
                    ValueListenableBuilder(
                      valueListenable: loading,
                      builder: (context, value, child) {
                        if (value == false) {
                          return InkWell(
                            onTap: () {
                              print(schoolName.text);
                              if (schoolName.text.isNotEmpty &&
                                  selectedGrade != 'Select Grade') {
                                loading.value = true;
                                TeacherCreateClass.createClass(
                                        widget.sectionId,
                                        widget.schoolId,
                                        schoolName.text.trim(),
                                        selectedGrade)
                                    .then((value) {
                                  loading.value = false;
                                  if (value == 200) {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return TeacherClass();
                                      },
                                    ));
                                  }
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'All Fields are Required');
                              }
                            },
                            child: CustomWidgets.customButton('Save'),
                          );
                        } else {
                          return CustomWidgets.loadingIndicator();
                        }
                      },
                    ),
                  ]),
                ),
              ))),
    );
  }
}
