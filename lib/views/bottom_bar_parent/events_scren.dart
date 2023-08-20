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

class NewsEventsPage extends StatelessWidget {
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
        padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent Events',
                  style: GoogleFonts.acme(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 120.h,
                width: 500.w,
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      height: 130.h,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage('images/education.png'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 90.h,
                          ),
                          Text('Events')
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: 700.0.h,
                height: 800.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 110.h,
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        trailing: Container(
                          height: 70,
                          width: 80,
                          child: Image.asset(
                            'images/forget.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(newsList[index].title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(newsList[index].description),
                            SizedBox(height: 4.0),
                            Text(
                              'Time: 30/30',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Date: 12/3/2000',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
