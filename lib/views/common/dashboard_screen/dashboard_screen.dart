import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_system/views/utils/app_images.dart';
import 'package:school_system/views/utils/custom_widget/my_text.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../bottom_bar_techer/prifile_screen/show_class.dart';
import '../../utils/colors.dart';
import 'components/event_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        children: [
          SizedBox(
            height: 10.sp,
          ),
          MyText(
            'Dashboard',
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 4.sp,),
          MyText(
            'View your all your activities here.',
            fontSize: 14.sp,
            color: kDescriptionColor,
            fontWeight: FontWeight.w600,
          ),

      SizedBox(height: 20.sp,),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 6.sp),
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(10.sp),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(80),blurRadius: 2
            )
          ]
        ),
        child: Column(
          children: [
            TableCalendar(



              headerStyle: HeaderStyle(
                leftChevronVisible:false,


                headerMargin: EdgeInsets.only(left: 10.sp),
                rightChevronVisible:false,
                formatButtonVisible: false,
                formatButtonShowsNext:false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,

              calendarFormat: CalendarFormat.week,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
            ),
            Divider(),
            SizedBox(height: 12.sp,),
            const Row(

              children: [
                Expanded(child: MyText('2 Events',fontWeight: FontWeight.bold,)),


                Expanded(child: MyText('See All',color: kDescriptionColor,textAlign: TextAlign.right,)),
              ],
            ),

            const EventCard(cardColor: Color(0xFFD6F4EA),),
            const EventCard(cardColor: Color(0xFFEFE7FD),),


          ],
        ),
      ),
          SizedBox(height: 20.sp,),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const TeacherClass()));
                  },
                  child: Container(

                    height: 136.sp,
                    padding: const EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFE2F4FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex:2,
                          child: SizedBox(
                            width: 64.sp,
                            height: 64.sp,
                            child: Center(child: Image.asset('images/satar.png'),),
                          ),
                        ),
                        const Expanded(
                          child: Center(
                            child: MyText(
                              'My Classes',
                              color: Color(0xFF000600),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.sp,),
              Expanded(
                child: Container(

                  height: 136.sp,
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFE2F4FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Column(

                    children: [
                      Expanded(
                        flex:2,
                        child: SizedBox(
                          width: 64.sp,
                          height: 64.sp,
                          child: Center(child: Image.asset(AppImages.starConfuse),),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: MyText(
                            'News & Events',
                            color: Color(0xFF000600),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}
