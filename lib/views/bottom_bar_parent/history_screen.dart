import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:school_system/controllers/cubits/common_cubit/history_mettings_cubit.dart';
import 'package:school_system/views/utils/colors.dart';

import '../utils/custom_widget/custom_widgets.dart';

class Meeting {
  String title;
  String subtitle;
  String time;
  String date;
  String imageUrl;

  Meeting({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.date,
    required this.imageUrl,
  });
}

class MeetingHistoryPage extends StatefulWidget {
  @override
  State<MeetingHistoryPage> createState() => _MeetingHistoryPageState();
}

class _MeetingHistoryPageState extends State<MeetingHistoryPage> {
  @override
  void initState() {
    context.read<HistoryMeetingsCubit>().getMeetingsHistory();
    // TODO: implement initState
    super.initState();
  }

  final List<Meeting> meetings = [
    Meeting(
      title: 'Meeting 1',
      subtitle: 'Discussion about project updates',
      time: '10:00 AM',
      date: 'July 15, 2023',
      imageUrl: 'assets/images/forget.png',
    ),
    Meeting(
      title: 'Meeting 2',
      subtitle: 'Planning for upcoming event',
      time: '2:30 PM',
      date: 'July 16, 2023',
      imageUrl: 'assets/images/forget.png',
    ),
    Meeting(
      title: 'Meeting 3',
      subtitle: 'Team brainstorming session',
      time: '9:00 AM',
      date: 'July 17, 2023',
      imageUrl: 'assets/images/forget.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: BlocBuilder<HistoryMeetingsCubit, HistoryMettingsState>(
        builder: (context, state) {
          if (state is HistoryMettingsLoaded) {
            return state.model.data!.isNotEmpty
                ? ListView.builder(
                    itemCount: state.model.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: 10.0.sp, right: 10.sp, top: 10.sp),
                        child: Container(
                          margin: EdgeInsets.only(top: 5.sp, right: 5.sp),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            leading: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              height: 35.h,
                              width: 35.w,
                              child: Image.network(
                                state.model.data![index].teacher!.image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Column(
                              children: [
                                SizedBox(
                                  height: 10.sp,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.model.data![index].title!,
                                    style: TextStyle(fontSize: 13.sp),
                                  ),
                                ),
                                Text(
                                  state.model.data![index].description!,
                                  style: TextStyle(fontSize: 13.sp),
                                ),
                              ],
                            ),
                            trailing: Column(
                              children: [
                                Text(
                                  'Time: ${state.model.data![index].meetingTime!}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp),
                                ),
                                Text(
                                  'Date:${state.model.data![index].meetingDate!.year}-${state.model.data![index].meetingDate!.month}-${state.model.data![index].meetingDate!.day}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5.sp,
                                ),
                                Container(
                                  height: 20.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    color: state.model.data![index].status ==
                                            'accepted'
                                        ? Colors.green
                                        : Colors.red,
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                  child: Center(
                                    child:
                                        Text(state.model.data![index].status!),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                    'No history data available',
                    style: GoogleFonts.acme(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ));
          } else {
            return CustomWidgets.loadingIndicator();
          }
        },
      ),
    );
  }
}
