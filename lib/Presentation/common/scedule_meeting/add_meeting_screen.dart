import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_system/Presentation/common/scedule_meeting/show_school.dart';
import 'package:school_system/Presentation/common/views/all_school_screen.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_date_picker.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_time_picker.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/controllers/cubits/common_cubit/add_metting_cubit.dart';
import 'package:school_system/controllers/firebase_repos/firebase_notification.dart';

import '../../utils/app_images.dart';
import '../../utils/custom_widget/my_text.dart';
import 'add_participant_screen.dart';

class AddMeetingScreen extends StatefulWidget {
  AddMeetingScreen({Key? key, this.ids}) : super(key: key);

  List<String>? ids;

  @override
  State<AddMeetingScreen> createState() => _AddMeetingScreenState();
}

class _AddMeetingScreenState extends State<AddMeetingScreen> {
  TextEditingController meetingName = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController sTimeController = TextEditingController();
  TextEditingController eTimeController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  var isChecked = false;
  final formKey = GlobalKey<FormState>();

  static String? dateVal(v) {
    if (v.trim().isEmpty) {
      return "Date Required";
    }

    return null;
  }

  static String? startTVal(v) {
    if (v.trim().isEmpty) {
      return "Date Required";
    }

    return null;
  }

  static String? endTVal(v) {
    if (v.trim().isEmpty) {
      return "Date Required";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 22.sp),
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
                    isRequiredField: true,
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ShowSchool()));
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
                    padding: EdgeInsets.symmetric(
                        horizontal: 15.sp, vertical: 15.sp),
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
                            Expanded(
                                flex: 2,
                                child: MyText(
                                  'Select Date',
                                  color: Color(0xff6B7280),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                )),
                            Expanded(
                                flex: 2,
                                child: SizedBox(
                                  child: CustomDatePickerValidateWidget(
                                    hintText: 'Select Date',
                                    validationText: 'Date is required',
                                    validator: dateVal,
                                    controller: dateController,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 16.sp,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: MyText(
                              'Start Time',
                              fontSize: 14.sp,
                            )),
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                                child: MyText(
                              'End Time',
                              fontSize: 14.sp,
                              textAlign: TextAlign.left,
                            ))
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTimePickerWithValidation(
                                hintText: 'Start Time',
                                validator: startTVal,
                                controller: sTimeController,
                                validationText: 'Start Time is required',
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                              child: CustomTimePickerWithValidation(
                                hintText: 'End Time',
                                validator: endTVal,
                                controller: eTimeController,
                                validationText: 'End Time is required',
                              ),
                            ),
                          ],
                        ),
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
                    isRequiredField: true,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  if (widget.ids!.isNotEmpty) {
                    print(meetingName.text);

                    print('false');
                    context.read<AddMettingCubit>().addMeetings(
                        title: meetingName.text.trim(),
                        id: widget.ids ?? [],
                        stdId: '',
                        date: dateController.text.trim(),
                        sTime: sTimeController.text.trim(),
                        eTime: eTimeController.text.trim(),
                        desc: descriptionController.text.trim());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Add Participation please')));
                  }
                }
              },
              child: BlocConsumer<AddMettingCubit, AddMettingState>(
                listener: (context, state) {
                  if (state is AddMettingError) {
                    Fluttertoast.showToast(msg: state.error!);
                  }

                  if (state is AddMettingLoaded) {
                    FirebaseNotificationsService().showNotification(
                        1, meetingName.text, 'Meeting Create Successful');
                  }
                },
                builder: (context, state) {
                  if (state is AddMettingLoading) {
                    return const CircularProgressIndicator(
                      color: kPrimaryColor,
                    );
                  } else {
                    return Container(
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
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 32.sp,
            ),
          ],
        ),
      ),
    );
  }
}
