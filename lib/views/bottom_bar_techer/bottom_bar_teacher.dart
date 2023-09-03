import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/views/bottom_bar_techer/scudel_meetings_teach.dart';
import 'package:school_system/views/utils/colors.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../bottom_bar_parent/events_scren.dart';
import '../bottom_bar_parent/history_screen.dart';
import '../common/menu_screen.dart';
import 'add_report_screen.dart';
import 'chat_screen.dart';
import 'events_screen.dart';
import 'library_screen.dart';
import 'metting_screen.dart';
import 'notification_screen.dart';

class TeacherBottomBar extends StatefulWidget {
  const TeacherBottomBar({Key? key}) : super(key: key);

  @override
  State<TeacherBottomBar> createState() => _TeacherBottomBarState();
}

int bottomIndex = 0;

PageController controller = PageController();

bool photos = false;

int slectIndex = 0;
int visit = 0;

List<TabItem> items = [
  const TabItem(
    icon: Icons.meeting_room,
    title: 'Home',
  ),
  const TabItem(
    icon: Icons.photo_album,
    title: 'Meetings',
  ),
  const TabItem(
    icon: Icons.chat,
    title: 'Chats',
  ),
  const TabItem(
    icon: Icons.report_gmailerrorred,
    title: 'Report',
  ),
  const TabItem(
    icon: Icons.photo_album,
    title: 'Events',
  ),
  const TabItem(
    icon: Icons.history,
    title: 'History',
  ),
  const TabItem(
    icon: Icons.menu,
    title: 'Menu',
  ),
];

class _TeacherBottomBarState extends State<TeacherBottomBar> {
  @override
  void initState() {
    visit = 0;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: kButtonColor,
        actions: [
          visit == 0
              ? Padding(
                  padding: EdgeInsets.only(right: 18.0.sp),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const NotificationScreen();
                          },
                        ));
                      },
                      child: Icon(
                        Icons.notifications,
                        size: 30.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
        title: Text(
          visit == 0
              ? 'Home'
              : visit == 1
                  ? "Meetings"
                  : visit == 2
                      ? "Chat"
                      : visit == 3
                          ? "Reports"
                          : visit == 4
                              ? "Events"
                              : visit == 5
                                  ? "History"
                                  : "Menu",
          style: GoogleFonts.acme(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 15.sp,
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: BottomBarInspiredOutside(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        items: items,
        backgroundColor: kButtonColor,
        elevation: 0,
        height: 50.h,
        curve: Curves.fastEaseInToSlowEaseOut,
        sizeInside: 50,
        color: Colors.white,
        colorSelected: Colors.white,
        indexSelected: visit,
        onTap: (int index) => setState(() {
          controller.jumpToPage(index);
          visit = index;
        }),
        chipStyle: const ChipStyle(
            convexBridge: false, color: Colors.white, background: kButtonColor),
        top: -32,
        animated: true,
        itemStyle: ItemStyle.circle,
      ),
      body: Scaffold(
        backgroundColor: kPrimaryColor,
        body: PageView(
          controller: controller,
          children: [
            MettingsScreen(),
            ShcudleMetteingsTeachers(),
            ChatScreenTeacher(),
            ClassListScreen(),
            NewsEventsPage(),
            MeetingHistoryPage(),
            MenuScreen(),
          ],
        ),
      ),
    );
  }
}
