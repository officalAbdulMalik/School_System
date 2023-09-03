import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/views/common/loginScreen.dart';
import 'package:school_system/views/bottom_bar_techer/prifile_screen/show_class.dart';
import 'package:school_system/views/utils/colors.dart';
import 'package:school_system/views/utils/custom_widget/container_decoration.dart';
import 'package:school_system/views/utils/custom_widget/custom_dop_down.dart';
import 'package:school_system/views/utils/custom_widget/custom_widgets.dart';

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

String selectedData = 'Select Grade';

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

class _TeacherAddClassState extends State<TeacherAddClass> {
  var country = LoginApiShadePreference.preferences!.get('country');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: kButtonColor,
          title: Text(
            'Add Class',
            style: GoogleFonts.acme(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 20.h,
                ),
                CustomWidgets.customTextField(
                    hintText: 'Class Name', controller: schoolName),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.sp),
                  height: 50.h,
                  width: 340.w,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15.r),
                    gradient: LinearGradient(
                        colors: [
                          const Color(0xFFC7CEF1),
                          const Color(0xFF8C9BE3),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.1, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            selectedData,
                            style: GoogleFonts.acme(
                              color: Colors.black,
                              fontSize: 12.sp,
                            ),
                          )),
                      Spacer(
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
                            selectedData = value!;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ValueListenableBuilder(
                  valueListenable: loading,
                  builder: (context, value, child) {
                    if (value == false) {
                      return Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: InkWell(
                            onTap: () {
                              print(schoolName.text);
                              if (schoolName.text.isNotEmpty &&
                                  selectedData != 'Select Grade') {
                                loading.value = true;
                                TeacherCreateClass.createClass(
                                        widget.sectionId,
                                        widget.schoolId,
                                        schoolName.text.trim(),
                                        selectedData)
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
                          ));
                    } else {
                      return CustomWidgets.loadingIndicator();
                    }
                  },
                ),
              ]),
            )));
  }
}
