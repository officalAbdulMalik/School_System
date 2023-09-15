import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:school_system/views/bottom_bar_techer/calendar_view/meeting_request/meeting_list.dart';

import '../../utils/app_images.dart';
import '../../utils/custom_widget/my_text.dart';

ValueNotifier tabIndex = ValueNotifier(0);
class TeacherMeetingRequest extends StatefulWidget {
  const TeacherMeetingRequest({Key? key}) : super(key: key);

  @override
  State<TeacherMeetingRequest> createState() => _TeacherMeetingRequestState();
}

class _TeacherMeetingRequestState extends State<TeacherMeetingRequest> {
  PageController pageController = PageController();
  @override
  void initState() {
    tabIndex.value = 0;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
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
                        'Meeting Requests',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 3.sp,
                      ),
                      const MyText(
                        'You can respond your all meeting requests here.',
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

            SizedBox(height: 20.sp,),
            Row(
              children: [
                MeetingTabItem(title: 'All', controller: pageController, currentIndex: 0,),
                MeetingTabItem(title: 'Pending', controller: pageController, currentIndex: 1,),
                MeetingTabItem(title: 'Approved', controller: pageController, currentIndex: 2,),
                MeetingTabItem(title: 'Rejected', controller: pageController, currentIndex: 3,),
              ],
            ),

            SizedBox(height: 20.sp,),
            Expanded(child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: const [
                MeetingList(),
                MeetingList(),
                MeetingList(),
                MeetingList(),
              ],
            ))

          ],
        ),
      ),
    );
  }
}

class MeetingTabItem extends StatelessWidget {
  final String title;
  final int currentIndex;
  final PageController controller;
  const MeetingTabItem({Key? key,required this.title,required this.controller,required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return                 Expanded(child: ValueListenableBuilder(
      valueListenable: tabIndex,
      builder: (context,value, child) {
        return InkWell(
          onTap: (){

            controller.jumpToPage(currentIndex);
            tabIndex.value = currentIndex;
          },
          child: Column(
            children: [
              MyText(title,fontSize: 14.sp, color: value == currentIndex ? Colors.blue: Color(0xff6B7280)),
              SizedBox(height: 10.sp,),
              Container(
                width: 1.sw,
                height: 2.sp,
                color: value == currentIndex ? Colors.blue: Colors.transparent,
              )
            ],
          ),
        );
      }
    ));
  }
}
