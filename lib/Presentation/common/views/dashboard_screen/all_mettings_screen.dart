import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/Models/get_all_mettings.dart';
import 'package:school_system/Presentation/common/views/dashboard_screen/components/event_card.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/Presentation/utils/custom_widget/navigator_pop.dart';

class MeetingAllScreen extends StatefulWidget {
  const MeetingAllScreen({Key? key, this.meetings}) : super(key: key);

  final List<AllMeetings>? meetings;

  @override
  State<MeetingAllScreen> createState() => _MeetingAllScreenState();
}

class _MeetingAllScreenState extends State<MeetingAllScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 4, vsync: this); // Set the number of tabs
  }

  @override
  void dispose() {
    _tabController
        .dispose(); // Dispose of the tab controller when no longer needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(">>>>>>>>>>>>>>>>>>>>>>>${widget.meetings![0].status}");

    List<AllMeetings>? newMeetings = widget.meetings
        ?.where(
          (e) => e.status == 'new',
        )
        .toList();
    List<AllMeetings>? accepted = widget.meetings
        ?.where(
          (e) => e.status == 'accepted',
        )
        .toList();
    List<AllMeetings>? rejected = widget.meetings
        ?.where(
          (e) => e.status == 'rejected',
        )
        .toList();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              const NavigatorPop(),
              SizedBox(
                height: 10.h,
              ),
              CustomRowWidget(
                text1: 'Meeting Requests',
                text2: 'You can respond your all meeting requests here.',
                image: 'sign_star.png',
                flex: 3,
              ),
              Expanded(
                child: TabBar(
                  indicatorColor: Colors.blue,
                  controller: _tabController,
                  isScrollable: true,
                  tabs: [
                    Tab(
                      child: MyText(
                        'All',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Tab(
                      child: MyText(
                        'Pending',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Tab(
                      child: MyText(
                        'Approved',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Tab(
                      child: MyText(
                        'Rejected',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                flex: 6,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                      itemCount: widget.meetings!.isEmpty
                          ? 1
                          : widget.meetings!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return MeetingCard(
                          meetings: widget.meetings,
                          index: index,
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: newMeetings!.isEmpty ? 1 : newMeetings.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        print('Meetings call pending');
                        return MeetingCard(
                          meetings: newMeetings,
                          index: index,
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: accepted!.isEmpty ? 1 : accepted.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return MeetingCard(
                          meetings: accepted,
                          index: index,
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: rejected!.isEmpty ? 1 : rejected.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return MeetingCard(
                          meetings: rejected,
                          index: index,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
