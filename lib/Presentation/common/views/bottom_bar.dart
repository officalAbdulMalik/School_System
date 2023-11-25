import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/get_user_data_cubit.dart';
import 'package:school_system/Controllers/Services/Connection/internet_conneection.dart';
import 'package:school_system/Controllers/firebase_repos/firebase_notification_meta.dart';
import 'package:school_system/Presentation/BottomBarParent/profile_screens/show_report_sreen.dart';
import 'package:school_system/Presentation/BottomBarTeacher/report_screen/show_teacher_class.dart';
import 'package:school_system/Presentation/common/Connection/internet_connection_screen.dart';
import 'package:school_system/Presentation/common/scedule_meeting/calnder_screen.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import '../../utils/custom_widget/custom_app_bar.dart';
import 'dashboard_screen/dashboard_screen.dart';
import 'chat_screens/chat_screen.dart';
import 'events_scren.dart';


class BottomBarPages extends StatefulWidget {
  final int index;

  const BottomBarPages({Key? key, required this.index}) : super(key: key);

  @override
  State<BottomBarPages> createState() => _BottomBarPagesState();
}

ValueNotifier indexListener = ValueNotifier(0);

int bottomIndex = 0;

bool photos = false;

// int slectIndex = 0;


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
  final PageController _controller = PageController();

  @override
  void initState() {
    context.read<GetUserDataCubit>().getParentsTeachers('');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationMetaServices.setContext(context);
    });
    initiateAllNotifications();
    bottomIndex = widget.index;
    indexListener.value = 0;

    AppConnectivity.connectionChanged(onDisconnected: () {
      print('disconnect');

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.topToBottom,
              child: const ConnectivityScreen()));
    });

    // TODO: implement initState
    super.initState();
  }

  void initiateAllNotifications() async {
    //print(await NotificationServices.getFcm());
    NotificationMetaServices().messagingInitiation();
    NotificationMetaServices().foregroundNotificationHandler(context: context);
    NotificationMetaServices()
        .backgroundNotificationOnTapHandler(context: context);

    NotificationMetaServices()
        .terminatedFromOnTapStateHandler(context: context, payLoadData: "");
    NotificationMetaServices().notificationPayload(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? type = LoginApiShadePreference.preferences!.getString('type');
    print(type);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          indexListener.value = 0;
          setState(() {});
          return Future.value(true);
        },
        child: Scaffold(
          appBar: const CustomAppBar(),
          extendBody: true,
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(top: 5.sp),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.grey.withAlpha(60),
                  blurRadius: 5,
                  offset: const Offset(5, 0))
            ]),
            height: 75.sp,
            child: Row(
              children: [
                BottomNavItems(
                  pageController: _controller,
                  icon: AppImages.homeIcon,
                  index: 0,
                  title: 'Home',
                ),
                BottomNavItems(
                  pageController: _controller,
                  icon: AppImages.calenderIcon,
                  index: 1,
                  title: 'Calendar',
                ),
                BottomNavItems(
                  pageController: _controller,
                  icon: AppImages.chatIcon,
                  index: 2,
                  title: 'Chat',
                ),
                BottomNavItems(
                  pageController: _controller,
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
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _controller,
                    children: [
                      DashboardScreen(),
                      CalenderScreen(),
                      ChatScreen(),
                      type == 'parent'
                          ? ReportCardScreen()
                          : TeacherReportScreen(),
                      NewsEventsPage(),
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
                    color: value == index ? Colors.blue : Colors.grey,
                  )),
                  Expanded(
                      child: MyText(
                    title,
                    color: value == index ? Colors.blue : Colors.grey,
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
