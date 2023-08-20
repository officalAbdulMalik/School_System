import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/views/utils/colors.dart';

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

class NewsEventsPage1 extends StatelessWidget {
  final List<EventScreeen> newsList = [
    EventScreeen(
      title: 'News 1',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    EventScreeen(
      title: 'News 2',
      description:
          'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    EventScreeen(
      title: 'News 3',
      description:
          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
    ),
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
        child: Column(
          children: [
            SizedBox(
              height: 30.sp,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Events',
                style: GoogleFonts.acme(color: Colors.black, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 150.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: eventList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 150.0,
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Card(
                        color: Colors.white,
                        child: Image.asset(
                          'images/even.jpg',
                          fit: BoxFit.contain,
                        )),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'News',
                style: GoogleFonts.acme(color: Colors.black, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 110.h,
                    child: Card(
                      color: Colors.white,
                      child: Image.asset(
                        'images/news.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
