import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_app_bar.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/views/bottom_bar_techer/calendar_view/teacher_meeting_request.dart';
import 'package:school_system/views/bottom_bar_techer/calendar_view/teacher_secdule_meeting.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

// class TeacherCalendarView {
//   String title;
//   String description;
//
//   TeacherCalendarView({required this.title, required this.description});
// }

class Event {
  String title;
  String date;

  Event({required this.title, required this.date});
}

class TeacherCalendarView extends StatefulWidget {
  @override
  State<TeacherCalendarView> createState() => _TeacherCalendarViewState();
}

class _TeacherCalendarViewState extends State<TeacherCalendarView> {
  // final List<TeacherCalendarView> newsList = [
  //   TeacherCalendarView(
  //     title: 'News 1',
  //     description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  //   ),
  //   TeacherCalendarView(
  //     title: 'News 2',
  //     description:
  //     'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  //   ),
  //   TeacherCalendarView(
  //     title: 'News 3',
  //     description:
  //     'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
  //   ),
  // ];

  final List<Event> eventList = [
    Event(
      title: 'Event 1',
      date: 'July 15, 2023',
    ),
    Event(
      title: 'Event 2',
      date: 'July 16, 2023',
    ),
    Event(
      title: 'Event 3',
      date: 'July 17, 2023',
    ),
    Event(
      title: 'Event 4',
      date: 'July 18, 2023',
    ),
    Event(
      title: 'Event 5',
      date: 'July 19, 2023',
    ),
    Event(
      title: 'Event 6',
      date: 'July 20, 2023',
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
    return Scaffold(
      appBar: CustomAppBar(),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 80.sp),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TeacherScheduleMeeting()));
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

          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TeacherMeetingRequest()));
              },
              child: MyText(
                'View Meeting Requests',
                textAlign: TextAlign.right,
                color: Color(0xFF3DAEF5),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 10.sp,
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

          // Calenddar===========================

          Container(
            height: 0.55.sh,
            child: DayView(
              controller: eventController,
              eventTileBuilder: (date, events, boundry, start, end) {
                // Return your widget to display as event tile.
                return Container(
                  height: 30.sp,
                  color: Colors.red,
                );
              },
              fullDayEventBuilder: (events, date) {
                // Return your widget to display full day event view.
                return Container(
                  height: 40.sp,
                  color: Colors.red,
                );
              },
              showVerticalLine: true, // To display live time line in day view.
              showLiveTimeLineInAllDays:
                  true, // To display live time line in all pages in day view.
              minDay: DateTime(1990),
              maxDay: DateTime(2050),
              initialDay: DateTime.now(),
              heightPerMinute: 1, // height occupied by 1 minute time span.
              eventArranger:
                  SideEventArranger(), // To define how simultaneous events will be arranged.
              onEventTap: (events, date) => print(events),
              onDateLongPress: (date) => print(date),
            ),
          )
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