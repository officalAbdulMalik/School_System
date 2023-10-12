import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({Key? key}) : super(key: key);

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  bool plan = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: 1.sw,
              height: 100.sp,
              clipBehavior: Clip.antiAlias,
              decoration: const ShapeDecoration(
                color: Color(0xFF3DAEF5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                      child: MyText(
                    'Subscription Plans',
                    color: Colors.white,
                    fontSize: 20.sp,
                  )),
                  Positioned(
                    left: 16.sp,
                    top: 0,
                    bottom: 0,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              children: [
                SizedBox(
                  height: 20.sp,
                ),
                MyText(
                  'My Minutes',
                  color: Colors.black,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24.sp,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 144.sp,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        decoration: ShapeDecoration(
                          color: Color(0xFFE2F4FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 48.sp,
                              height: 48.sp,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppImages.calendar),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: MyText(
                                      '30',
                                      color: Colors.black,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Flexible(
                                    child: MyText(
                                      'Total Minutes',
                                      color: Color(0xFF6B7280),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.sp,
                    ),
                    Expanded(
                      child: Container(
                        height: 144.sp,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        decoration: ShapeDecoration(
                          color: Color(0xFFFFEEF5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 48.sp,
                              height: 48.sp,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppImages.calendar),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: MyText(
                                      '15',
                                      color: Colors.black,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Flexible(
                                    child: MyText(
                                      'Minutes Used',
                                      color: Color(0xFF6B7280),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.sp,
                ),
                SizedBox(
                  width: 192.sp,
                  height: 142.sp,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SvgPicture.asset(AppImages.crown),
                            SizedBox(
                              height: 5.sp,
                            ),
                            Container(
                              color: Color(0xFF000600),
                              width: 48.sp,
                              height: 3.sp,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MyText(
                                'Discover our Plans',
                                color: Color(0xFF000600),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(height: 4),
                              MyText(
                                'Choose Your Subscription',
                                color: Color(0xFF000600),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          plan = false;
                          setState(() {});
                        },
                        child: Container(
                          height: 28.sp,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 6),
                          decoration: ShapeDecoration(
                            color: plan == true
                                ? const Color(0xFF9CA3AF)
                                : const Color(0xFFF7D55C),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          child: Center(
                            child: MyText(
                              'Free Trail Plan',
                              textAlign: TextAlign.center,
                              color: const Color(0xFF000600),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.06,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.sp,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          plan = true;
                          setState(() {});
                        },
                        child: Container(
                          height: 28.sp,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 6),
                          decoration: ShapeDecoration(
                            color: plan == false
                                ? const Color(0xFF9CA3AF)
                                : const Color(0xFFF7D55C),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          child: Center(
                            child: MyText(
                              '5 Star Plan',
                              textAlign: TextAlign.center,
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.06,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.sp,
                ),
                Container(
                  width: 327,
                  height: 46,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3DAEF5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.sp),
                        topRight: Radius.circular(24.sp),
                      ),
                    ),
                  ),
                  child: Center(
                    child: MyText(
                      plan == true ? "5 Star Plan" : 'Trail Plan',
                      textAlign: TextAlign.center,
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2F4FF),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24.sp),
                      bottomRight: Radius.circular(24.sp),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.sp,
                      ),
                      MyText(
                        plan == true ? '\$55 / Year' : '5 Days Only',
                        textAlign: TextAlign.center,
                        color: Colors.black,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.sp),
                        child: const Divider(
                          thickness: 1.5,
                          color: Color(0xFF3DAEF5),
                        ),
                      ),
                      MyText(
                        'Cancel at anytime, no commitment',
                        textAlign: TextAlign.center,
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 8.sp,
                      ),
                      Container(
                        width: 263.sp,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: ShapeDecoration(
                          color: Color(0xFFF7D55C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: MyText(
                            'Support Parent Teacher Mobile by Subscribing',
                            textAlign: TextAlign.center,
                            color: const Color(0xFF000600),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25.sp,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.sp,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.sp),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.50, color: Color(0xFFF7D55C)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x14303133),
                        blurRadius: 40,
                        offset: Offset(0, 24),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x0C303133),
                        blurRadius: 1,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.sp),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.sp,
                      ),
                      Container(
                        width: 128.sp,
                        height: 32.sp,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF7D55C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: MyText(
                          plan == true ? '5 Star Plan' : "Trail Plan",
                          color: const Color(0xFF000600),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      getFeatures(plan == true
                          ? "2500 Video conferencing mobile"
                              "minutes for up to 25 participants"
                              " simultaneously."
                          : "30 Free Video conferencing mobile minutes for up to 10 participants simultaneously"),
                      getFeatures(
                          plan == true ? "Calendar" : 'Access to Report Cards'),
                      plan == true
                          ? getFeatures("Access to Report Cards")
                          : SizedBox(),
                      plan == true
                          ? getFeatures("School Notifications")
                          : SizedBox(),
                      plan == true
                          ? getFeatures("And so much more")
                          : SizedBox(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 70.sp,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  getFeatures(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.star,
            color: Color(0xffF7D55C),
          ),
          SizedBox(
            width: 8.sp,
          ),
          Flexible(
              child: MyText(
            title,
            color: const Color(0xFF131313),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ))
        ],
      ),
    );
  }
}
