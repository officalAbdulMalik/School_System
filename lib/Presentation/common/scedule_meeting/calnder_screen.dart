import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import 'add_meeting_screen.dart';

class CalenderScreen extends StatefulWidget {
  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
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
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 80.sp),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddMeetingScreen()));
          },
          child: const Icon(Icons.add),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        children: [
          SizedBox(
            height: 10.sp,
          ),
          MyText(
            'Calendar',
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.sp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey.withAlpha(80), blurRadius: 2)
                ]),
            child: Column(
              children: [
                TableCalendar(
                  // headerStyle: HeaderStyle(
                  //   leftChevronVisible: false,
                  //   headerMargin: EdgeInsets.symmetric(horizontal: 20.sp,vertical: 5),
                  //   rightChevronVisible: false,
                  //   formatButtonVisible: false,
                  //   formatButtonShowsNext: false,
                  // ),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarFormat: CalendarFormat.week,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                ),
                Divider(),
                SizedBox(
                  height: 12.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
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
