import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/views/bottom_bar_techer/calendar_view/teacher_add_participants.dart';

class TeacherScheduleMeeting extends StatefulWidget {
  const TeacherScheduleMeeting({Key? key}) : super(key: key);

  @override
  State<TeacherScheduleMeeting> createState() => _TeacherScheduleMeetingState();
}

class _TeacherScheduleMeetingState extends State<TeacherScheduleMeeting> {
  TextEditingController meetingName = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            'Schedule Meeting',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 3.sp,
                          ),
                          const MyText(
                            'You can schedule meeting with teachers here.',
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
                        child: Image.asset(AppImages.glassesStarBig)),
                  ],
                ),
                SizedBox(
                  height: 25.sp,
                ),
                MyTextField(
                  controller: meetingName,
                  hintText: 'Meeting Name',
                  filledColor: const Color(0xFFF3F4F6),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const TeacherAddParticipantScreen()));
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.sp),
                      height: 45.sp,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff3DAEF5)),
                          borderRadius: BorderRadius.circular(12.sp)),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(AppImages.profilePlus),
                            SizedBox(
                              width: 4.sp,
                            ),
                            MyText(
                              'Add Participants',
                              color: Color(0xff3DAEF5),
                              fontSize: 14.sp,
                            ),
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),
                    color: const Color(0xFFF3F4F6),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: MyText(
                              'All Day',
                              color: Color(0xff6B7280),
                              fontSize: 14.sp,
                            ),
                          ),
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                                value: isChecked,
                                onChanged: (value) {
                                  isChecked = value;
                                  setState(() {});
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.sp,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 24.sp,
                          ),
                          Expanded(
                              child: MyText(
                            '29 Aug 2023',
                            fontSize: 14.sp,
                          )),
                          Expanded(
                              child: MyText(
                            '11:30',
                            fontSize: 14.sp,
                            textAlign: TextAlign.right,
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 16.sp,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 24.sp,
                          ),
                          Expanded(
                              child: MyText(
                            '29 Aug 2023',
                            fontSize: 14.sp,
                          )),
                          Expanded(
                              child: MyText(
                            '11:30',
                            fontSize: 14.sp,
                            textAlign: TextAlign.right,
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 16.sp,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: MyText(
                            '29 Aug 2023',
                            fontSize: 14.sp,
                            color: Color(0xff6B7280),
                          )),
                          Expanded(
                              child: MyText(
                            '11:30',
                            fontSize: 14.sp,
                            textAlign: TextAlign.right,
                          ))
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                MyTextField(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLine: 3,
                  filledColor: const Color(0xFFF3F4F6),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.sp),
            height: 45.sp,
            decoration: BoxDecoration(
                color: Color(0xff3DAEF5),
                borderRadius: BorderRadius.circular(12.sp)),
            child: Center(
              child: MyText(
                'Schedule Meeting',
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(
            height: 32.sp,
          ),
        ],
      ),
    );
  }
}
