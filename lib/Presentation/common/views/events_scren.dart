import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/events_newz_cubit.dart';
import 'package:school_system/Presentation/common/resources/loading_dialog.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text_field.dart';
import 'package:school_system/Presentation/utils/custom_widget/navigator_pop.dart';
import 'package:school_system/models/news_events_model.dart';

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
  EventController eventController = EventController();
  SideEventArranger slideEvent = SideEventArranger();

  TextEditingController searchController = TextEditingController();

  List<NewsEvents>? allData = [];
  List<NewsEvents>? searchList = [];

  @override
  void initState() {
    context.read<EventsNewsCubit>().getEventsNews();

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
            MyTextField(
              controller: searchController,
              filledColor: kContainerColor,
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              onCanaged: (val) {
                if (val.isNotEmpty) {
                  searchList = searchList!
                      .where((player) => player.title!
                          .toLowerCase()
                          .contains(val.toLowerCase()))
                      .toList();
                } else {
                  searchList = allData;
                }
                setState(() {});
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            BlocConsumer<EventsNewsCubit, EventsNewsState>(
              listener: (context, state) {
                if (state is EventsNewsLoading) {
                  LoadingDialog.showLoadingDialog(context);
                }
                if (state is EventsNewsLoaded) {
                  Navigator.pop(context);
                  allData = state.newsEvents!;
                  searchList = state.newsEvents!;
                }
                if (state is EventsNewsError) {
                  Fluttertoast.showToast(msg: state.error!);
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is EventsNewsLoaded) {
                  return SizedBox(
                    height: 0.75.sh,
                    width: 1.sw,
                    child: searchList!.isNotEmpty
                        ? ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 15.h,
                              );
                            },
                            itemCount: searchList!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x19303133),
                                      blurRadius: 10,
                                      offset: Offset(2, 2),
                                      spreadRadius: 1,
                                    )
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getText(searchList?[index].title ?? "", 16,
                                        FontWeight.w500, Colors.black),
                                    getText(
                                        searchList?[index].description ?? "",
                                        14,
                                        FontWeight.w400,
                                        Colors.grey),
                                    Container(
                                        padding: EdgeInsets.only(
                                            bottom: 10.sp,
                                            top: 10.sp,
                                            left: 5.sp,
                                            right: 5.sp),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          // boxShadow: const [
                                          //   BoxShadow(
                                          //     color: Color(0x19303133),
                                          //     blurRadius: 30,
                                          //     offset: Offset(2, 4),
                                          //     spreadRadius: 0,
                                          //   )
                                          // ],
                                        ),
                                        child: Image.asset(
                                          'images/event1.png',
                                          fit: BoxFit.contain,
                                        )),
                                  ],
                                ),
                              );
                            },
                          )
                        : Center(
                            child: MyText(
                              'Data not found',
                              fontSize: 18.sp,
                              color: Colors.black,
                            ),
                          ),
                  );
                } else if (state is EventsNewsError) {
                  return Center(
                    child: MyText(
                      state.error!,
                      fontSize: 18.sp,
                      color: Colors.black,
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
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
