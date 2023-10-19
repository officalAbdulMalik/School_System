import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/get_all_meetings_cubit.dart';
import 'package:school_system/Presentation/BottomBarParent/profile_screens/show_children.dart';
import 'package:school_system/Presentation/BottomBarTeacher/prifile_screen/show_class.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/common/views/events_scren.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../utils/app_images.dart';
import '../../../utils/colors.dart';
import '../../../utils/custom_widget/my_text.dart';
import 'all_mettings_screen.dart';
import 'components/event_card.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? role = LoginApiShadePreference.preferences!.getString('type');

  DateTime selectedTime = DateTime.now();

  get() async {
    await context.read<GetAllMeetingsCubit>().getAllMettings();
  }

  @override
  void initState() {
    get();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(role);

    return Scaffold(
      body: BlocConsumer<GetAllMeetingsCubit, GetAllMeetingsState>(
        listener: (context, state) {
          print('state is $state');
          if (state is GetAllMeetingsLoading) {
            LoadingDialog.showLoadingDialog(context);
          }
          if (state is GetAllMeetingsError) {
            Navigator.pop(context);
            // CustomDialog.dialog(context, Text(state.error));
            Fluttertoast.showToast(msg: state.error);
          }
          if (state is GetAllMeetingsLoaded) {
            Navigator.pop(context);
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is GetAllMeetingsLoaded) {
            return ListView(
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
                SizedBox(
                  height: 4.sp,
                ),
                MyText(
                  'View your all your activities here.',
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
                        BoxShadow(
                            color: Colors.grey.withAlpha(80), blurRadius: 2)
                      ]),
                  child: Column(
                    children: [
                      TableCalendar(
                        headerStyle: HeaderStyle(
                          leftChevronVisible: true,
                          headerMargin: EdgeInsets.only(left: 10.sp),
                          rightChevronVisible: true,
                          formatButtonVisible: true,
                          formatButtonShowsNext: true,
                        ),
                        onDaySelected: (selectedDay, focusedDay) {
                          selectedTime = selectedDay;
                          print(selectedDay);
                          print(selectedTime);
                          setState(() {});
                        },
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        calendarFormat: CalendarFormat.week,
                        firstDay: DateTime.utc(2010, 10, 16),
                        currentDay: selectedTime,
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: selectedTime,
                      ),
                      Divider(),
                      SizedBox(
                        height: 12.sp,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: MyText(
                            "${state.meetings.length} Events",
                            fontWeight: FontWeight.bold,
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return MeetingAllScreen(
                                    meetings: state.meetings,
                                  );
                                },
                              ));
                            },
                            child: const MyText(
                              'See All',
                              color: kDescriptionColor,
                              textAlign: TextAlign.right,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 200,
                        width: 1.sw,
                        child: state.meetings.isNotEmpty
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.meetings.length == 1 ? 1 : 2,
                                itemBuilder: (context, index) {
                                  return EventCard(
                                    cardColor: kGreenColor,
                                    data: state.meetings[index],
                                  );
                                },
                              )
                            : Center(
                                child: MyText('No have any meeting',
                                    fontSize: 18.sp),
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => role == 'teacher'
                                      ? const TeacherClass()
                                      : ShowChildren()));
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
                                flex: 2,
                                child: SizedBox(
                                  width: 64.sp,
                                  height: 64.sp,
                                  child: Center(
                                    child: Image.asset('images/satar.png'),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: MyText(
                                    role == 'teacher'
                                        ? 'My Classes'
                                        : "My Kids",
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
                    SizedBox(
                      width: 20.sp,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return NewsEventsPage();
                            },
                          ));
                        },
                        child: Container(
                          height: 136.sp,
                          padding: const EdgeInsets.all(16),
                          decoration: ShapeDecoration(
                            color: kGreenColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                  width: 64.sp,
                                  height: 64.sp,
                                  child: Center(
                                    child: Image.asset(AppImages.starConfuse),
                                  ),
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
                    ),
                  ],
                ),
                SizedBox(
                  height: 80.h,
                ),
              ],
            );
          } else if (state is GetAllMeetingsError) {
            print(state.error);
            return Center(
              child: Text(state.error),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
