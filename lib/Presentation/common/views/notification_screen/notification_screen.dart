import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15.0.sp),
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
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(''),
            ),
            title: Text(
              'searchList![index].schoolName!',
              style: CustomWidgets.textStyle(
                  color: Colors.black, size: 16, weight: FontWeight.w600),
            ),
            subtitle: Text(
              'searchList![index].address!',
              style: CustomWidgets.textStyle(
                  color: kDescriptionColor, size: 15, weight: FontWeight.w500),
            ),
            trailing: SizedBox(
              height: 30,
              width: 30,
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 25.sp,
                  color: kDescriptionColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
