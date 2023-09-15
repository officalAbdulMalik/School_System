import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_images.dart';
import '../../utils/custom_widget/my_text.dart';

class TeacherAddParticipantScreen extends StatefulWidget {
  const TeacherAddParticipantScreen({Key? key}) : super(key: key);

  @override
  State<TeacherAddParticipantScreen> createState() => _TeacherAddParticipantScreenState();
}

class _TeacherAddParticipantScreenState extends State<TeacherAddParticipantScreen> {
  var selectedSchool;
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            'Add Participants',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 3.sp,
                          ),
                          const MyText(
                            'You can add meeting participants here.',
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


                SizedBox(height: 25.sp,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  height: 44.sp,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF3F4F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        // flex: 2,
                        child: MyText(
                          selectedSchool ?? 'Select School',
                          color: selectedSchool == null ? Colors.grey:Colors.black, fontSize: 14.sp,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down_outlined),
                            underline: SizedBox(),
                            items: <String>[
                              'Harward School',
                              'Scots',
                              'Welsh',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              selectedSchool = value!;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Container(
            width: 1.sw,
            padding: EdgeInsets.symmetric(horizontal: 20.sp,vertical: 8.sp),
            child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  Flexible(
                    child: MyText(
                      'Select All Teachers',
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Flexible(
                    child: MyText(
                      '35 Participants',
                      color: Color(0xFF6B7280),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.right,
                    ),
                  ),

                ]  ),

          ),

          Expanded(child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),

              itemCount: 5,
              itemBuilder: (context,index){
                return Container(
                  width: 343,
                  height: 52,
                  padding: const EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 36,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MyCheckBox() ,
                              //const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 32,
                                        height: 32,
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(AppImages.userImage),
                                            fit: BoxFit.fill,
                                          ),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: MyText(
                                                  'Dave Jobs',
                                                  color: const Color(0xFF000600),
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,

                                                ),
                                              ),
                                              Flexible(
                                                child: MyText(
                                                  'Arman Malik',
                                                  color: Colors.black,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w400,

                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.more_vert,color: Colors.grey,)
                    ],
                  ),
                );

              })),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.sp),
            height: 45.sp,
            decoration: BoxDecoration(
                color: Color(0xff3DAEF5),
                borderRadius: BorderRadius.circular(12.sp)
            ),
            child: Center(child: MyText('Continue',color: Colors.white,fontSize: 14.sp,),),
          ),
          SizedBox(height: 32.sp,),
        ],
      ),
    );
  }
}


class MyCheckBox extends StatefulWidget {

  const MyCheckBox({Key? key}) : super(key: key);

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  var myValue= false;
  @override
  Widget build(BuildContext context) {
    return                           Checkbox(


        value: myValue, onChanged: (value){
      myValue = value!;
      setState(() {

      });
    });
  }
}

