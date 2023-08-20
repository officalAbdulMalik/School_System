import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/views/bottom_bar_parent/profile_screens/menu_screen.dart';
import 'package:school_system/views/bottom_bar_parent/show_report_sreen.dart';
import 'package:school_system/views/utils/colors.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../bottom_bar_techer/metting_screen.dart';
import '../bottom_bar_techer/notification_screen.dart';
import 'chat_screen.dart';
import 'class_screen.dart';
import 'history_screen.dart';
import 'events_scren.dart';

class BottomBarPages extends StatefulWidget {
  const BottomBarPages({Key? key}) : super(key: key);

  @override
  State<BottomBarPages> createState() => _BottomBarPagesState();
}

int bottomIndex = 0;

PageController controller = PageController();

bool photos = false;

int slectIndex = 0;
int visit = 0;

List<TabItem> items = [
  const TabItem(
    icon: Icons.home,
    title: 'Home',
  ),
  const TabItem(
    icon: Icons.meeting_room,
    title: 'Meeting',
  ),
  const TabItem(
    icon: Icons.chat,
    title: 'Chats',
  ),
  const TabItem(
    icon: Icons.photo_album,
    title: 'Events',
  ),
  const TabItem(
    icon: Icons.report,
    title: 'Report',
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

class _BottomBarPagesState extends State<BottomBarPages> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        bottomIndex = 0;
        setState(() {});
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            bottomIndex == 0
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
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: kButtonColor,
          title: Text(
            bottomIndex == 0
                ? 'Meetings Screen'
                : bottomIndex == 1
                    ? "Chats"
                    : bottomIndex == 2
                        ? "History"
                        : bottomIndex == 3
                            ? "Events"
                            : bottomIndex == 4
                                ? "View Report"
                                : bottomIndex == 5
                                    ? "History"
                                    : 'Menu',
            style: GoogleFonts.acme(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
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
          indexSelected: bottomIndex,
          onTap: (int index) => setState(() {
            controller.jumpToPage(index);
            bottomIndex = index;
          }),
          chipStyle: const ChipStyle(
              convexBridge: false,
              color: Colors.white,
              background: kButtonColor),
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
              ClassScreen(),
              ChatScreen(),
              NewsEventsPage(),
              ReportCardScreen(),
              MeetingHistoryPage(),
              MenuScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
