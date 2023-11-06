import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/notifications_cubit.dart';
import 'package:school_system/Data/Repository/notification_repo.dart';
import 'package:school_system/Data/app_const.dart';
import 'package:school_system/Presentation/common/resources/Extension/extension.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_row_widget.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/navigator_pop.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    context.read<NotificationsCubit>().getNotifications();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15.0.sp),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const NavigatorPop(),
                SizedBox(height: 5.h),
                CustomRowWidget(
                  text1: 'Notifications',
                  text2: 'You can view your all notification from here...',
                  image: 'add_s_star.png',
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 0.75.sh,
                  child: BlocConsumer<NotificationsCubit, NotificationsState>(
                    listener: (context, state) {
                      if (state is NotificationsLoading) {
                        Dialogs.loadingDialog(context);
                      }
                      if (state is NotificationsLoaded) {
                        if (state.loading == null) {
                          Navigator.of(context).pop(true);
                        }
                      }
                      if (state is NotificationsError) {
                        Fluttertoast.showToast(msg: state.error!);
                      }
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is NotificationsLoaded) {
                        return state.notifications!.isNotEmpty
                            ? ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 10.h,
                                  );
                                },
                                shrinkWrap: true,
                                itemCount: state.notifications!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () async {
                                      await Notifications.readNotification(
                                              state.notifications![index].id!)
                                          .then((value) {
                                        context
                                            .read<NotificationsCubit>()
                                            .getNotifications(loading: false);
                                      });
                                    },
                                    child: NotificationsTile(
                                      title: "Title ",
                                      dateTime:
                                          state.notifications![index].createdAt,
                                      des:
                                          state.notifications![index].message ??
                                              "",
                                      read: state.notifications![index].read,
                                    ),
                                  );
                                },
                              )
                            : CustomWidgets.errorText(noDataString);
                      } else if (state is NotificationsError) {
                        return CustomWidgets.errorText(state.error!);
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationsTile extends StatelessWidget {
  const NotificationsTile(
      {super.key,
      this.read,
      required this.title,
      this.dateTime,
      required this.des});

  final String title;
  final String des;
  final DateTime? dateTime;
  final int? read;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: ShapeDecoration(
        color: read == 0 ? const Color(0xFFE2F4FF) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dateTime!.timeAgo(numericDates: false),
            style: GoogleFonts.poppins(
              color: kDescriptionColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18.sp,
                backgroundColor: kCardBLColor,
                child: const Center(
                  child: Icon(
                    Icons.notifications_none,
                    color: kDescriptionColor,
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      des,
                      style: GoogleFonts.poppins(
                        color: kDescriptionColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              dateTime!.humanReadableDate ?? "",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
