import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Presentation/bottom_bar_parent/scedule_meeting/calnder_screen.dart';
import 'package:school_system/Presentation/bottom_bar_parent/show_report_sreen.dart';
import 'package:school_system/Presentation/bottom_bar_techer/report_screen/teacher_report_screen.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../../../controllers/cubits/common_cubit/get_user_data_cubit.dart';
import '../../utils/custom_widget/custom_app_bar.dart';
import 'dashboard_screen/dashboard_screen.dart';
import 'menu_screen.dart';
import 'chat_screens/chat_screen.dart';
import '../../bottom_bar_parent/class_screen.dart';
import 'events_scren.dart';

ValueNotifier indexListener = ValueNotifier(0);

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
  void initState() {
    context.read<GetUserDataCubit>().getParentsTeachers('');

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? type = LoginApiShadePreference.preferences!.getString('role');

    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          bottomIndex = 0;
          setState(() {});
          return Future.value(true);
        },
        child: Scaffold(
          appBar: CustomAppBar(),
          extendBody: true,
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(top: 5.sp),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.grey.withAlpha(60),
                  blurRadius: 5,
                  offset: Offset(5, 0))
            ]),
            height: 75.sp,
            child: Row(
              children: [
                BottomNavItems(
                  pageController: controller,
                  icon: AppImages.homeIcon,
                  index: 0,
                  title: 'Home',
                ),
                BottomNavItems(
                  pageController: controller,
                  icon: AppImages.calenderIcon,
                  index: 1,
                  title: 'Calendar',
                ),
                BottomNavItems(
                  pageController: controller,
                  icon: AppImages.chatIcon,
                  index: 2,
                  title: 'Chat',
                ),
                BottomNavItems(
                  pageController: controller,
                  icon: AppImages.reportIcon,
                  index: 3,
                  title: 'Reports',
                ),
              ],
            ),
          ),
          body: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: controller,
                    children: [
                      DashboardScreen(),
                      CalenderScreen(),
                      ChatScreen(),
                      type != 'parent'
                          ? ReportCardScreen()
                          : TeacherReportScreen(),
                      MenuScreen(),
                      ClassScreen(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavItems extends StatelessWidget {
  final int index;
  final String title;
  final String icon;
  final PageController pageController;

  const BottomNavItems(
      {Key? key,
      required this.pageController,
      required this.icon,
      required this.index,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
          valueListenable: indexListener,
          builder: (context, value, child) {
            return InkWell(
              onTap: () {
                pageController.jumpToPage(index);
                indexListener.value = index;
              },
              child: Column(
                children: [
                  Expanded(
                      child: SvgPicture.asset(
                    icon,
                    color: index == value ? Colors.blue : Colors.grey,
                  )),
                  Expanded(
                      child: MyText(
                    title,
                    color: index == value ? Colors.blue : Colors.grey,
                  ))
                ],
              ),
            );
          }),
    );
  }
}

//    return WillPopScope(
//       onWillPop: () {
//         bottomIndex = 0;
//         setState(() {});
//         return Future.value(true);
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           actions: [
//             bottomIndex == 0
//                 ? Padding(
//                     padding: EdgeInsets.only(right: 18.0.sp),
//                     child: Center(
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.push(context, MaterialPageRoute(
//                             builder: (context) {
//                               return const NotificationScreen();
//                             },
//                           ));
//                         },
//                         child: Icon(
//                           Icons.notifications,
//                           size: 30.sp,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   )
//                 : SizedBox(),
//           ],
//           automaticallyImplyLeading: false,
//           centerTitle: true,
//           backgroundColor: kButtonColor,
//           title: Text(
//             bottomIndex == 0
//                 ? 'Meetings Screen'
//                 : bottomIndex == 1
//                     ? "Chats"
//                     : bottomIndex == 2
//                         ? "History"
//                         : bottomIndex == 3
//                             ? "Events"
//                             : bottomIndex == 4
//                                 ? "View Report"
//                                 : bottomIndex == 5
//                                     ? "History"
//                                     : 'Menu',
//             style: GoogleFonts.acme(
//               color: Colors.white,
//               fontWeight: FontWeight.w700,
//               fontSize: 18,
//             ),
//           ),
//         ),
//         extendBody: true,
//         bottomNavigationBar: BottomBarInspiredOutside(
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(20), topLeft: Radius.circular(20)),
//           items: items,
//           backgroundColor: kButtonColor,
//           elevation: 0,
//           height: 50.h,
//           curve: Curves.fastEaseInToSlowEaseOut,
//           sizeInside: 50,
//           color: Colors.white,
//           colorSelected: Colors.white,
//           indexSelected: bottomIndex,
//           onTap: (int index) => setState(() {
//             controller.jumpToPage(index);
//             bottomIndex = index;
//           }),
//           chipStyle: const ChipStyle(
//               convexBridge: false,
//               color: Colors.white,
//               background: kButtonColor),
//           top: -32,
//           animated: true,
//           itemStyle: ItemStyle.circle,
//         ),
//         body: Scaffold(
//           backgroundColor: kPrimaryColor,
//           body: PageView(
//             controller: controller,
//             children: [
//               MettingsScreen(),
//               ClassScreen(),
//               ChatScreen(),
//               NewsEventsPage(),
//               ReportCardScreen(),
//               MeetingHistoryPage(),
//               MenuScreen(),
//             ],
//           ),
//         ),
//       ),
//     );
