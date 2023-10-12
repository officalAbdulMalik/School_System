import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/navigator_pop.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/custom_widget/my_text.dart';

class EventScreeen {
  String title;
  String description;

  EventScreeen({required this.title, required this.description});
}

class Event {
  String title;
  String date;

  Event({required this.title, required this.date});
}

class NewsEventsPage extends StatefulWidget {
  @override
  State<NewsEventsPage> createState() => _NewsEventsPageState();
}

class _NewsEventsPageState extends State<NewsEventsPage> {
  final List<EventScreeen> newsList = [
    EventScreeen(
      title: 'Children\'s Day Celebration',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    EventScreeen(
      title: 'International Day of Education',
      description:
          'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    EventScreeen(
      title: 'Children\'s Day Celebration',
      description:
          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
    ),
  ];

  EventController eventController = EventController();
  SideEventArranger slideEvent = SideEventArranger();

  @override
  void initState() {
    // eventController.add(CalendarEventData(
    //   date: DateTime.now().add(Duration(hours: 1)),
    //   endDate: DateTime.now().add(Duration(hours: 2)),
    //   event: "Class A", title: 'Parents Teachers meeting',
    // ));
    //slideEvent.arrange(events: eventController.events, height: 100, width: 1.sw, heightPerMinute: 100);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          children: [
            SizedBox(
              height: 20.h,
            ),
            const NavigatorPop(),
            SizedBox(
              height: 20.sp,
            ),
            MyText(
              'News & Events',
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 4.sp,
            ),
            MyText(
              'View your all events here.',
              fontSize: 14.sp,
              color: kDescriptionColor,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 20.sp,
            ),
            containerWidget(newsList),
          ],
        ),
      ),
    );
  }
}

Container containerWidget(List<EventScreeen> events) {
  return Container(
    height: events.length * 200.h,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.sp),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.sp),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 15.h,
          );
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getText(events[index].title, 16, FontWeight.w500, Colors.black),
              getText(
                  events[index].description, 14, FontWeight.w400, Colors.grey),
              Image.asset('images/event1.png'),
            ],
          );
        },
      ),
    ),
  );
}

getText(String title, int fontSize, FontWeight weight, Color color) {
  return MyText(
    title,
    color: color,
    fontSize: fontSize.sp,
    fontWeight: weight,
  );
}
// body: Padding(
//   padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
//   child: SingleChildScrollView(
//     child: Column(
//       children: [
//         SizedBox(
//           height: 20.h,
//         ),
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Text(
//             'Recent Events',
//             style: GoogleFonts.acme(
//               color: Colors.white,
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10.h,
//         ),
//         SizedBox(
//           height: 120.h,
//           width: 500.w,
//           child: PageView.builder(
//             itemBuilder: (context, index) {
//               return Container(
//                 height: 130.h,
//                 width: 200,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   image: DecorationImage(
//                       image: AssetImage('images/education.png'),
//                       fit: BoxFit.cover),
//                   borderRadius: BorderRadius.circular(20.sp),
//                 ),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 90.h,
//                     ),
//                     Text('Events')
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         SizedBox(
//           height: 20.h,
//         ),
//         Container(
//           width: 700.0.h,
//           height: 800.w,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: ListView.separated(
//             separatorBuilder: (context, index) {
//               return SizedBox(
//                 height: 10.h,
//               );
//             },
//             itemCount: 3,
//             itemBuilder: (BuildContext context, int index) {
//               return Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 height: 110.h,
//                 width: MediaQuery.of(context).size.width,
//                 child: ListTile(
//                   trailing: Container(
//                     height: 70,
//                     width: 80,
//                     child: Image.asset(
//                       'images/forget.png',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   title: Text(newsList[index].title),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(newsList[index].description),
//                       SizedBox(height: 4.0),
//                       Text(
//                         'Time: 30/30',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         'Date: 12/3/2000',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
