import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';

class SubscriptionView extends StatelessWidget {
  const SubscriptionView({Key? key}) : super(key: key);

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
                      child: Container(
                        height: 28.sp,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 6),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF7D55C),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: Center(
                          child: MyText(
                            'Yearly',
                            textAlign: TextAlign.center,
                            color: const Color(0xFF000600),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.06,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.sp,
                    ),
                    Expanded(
                      child: Container(
                        height: 28.sp,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 6),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF9CA3AF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: Center(
                          child: MyText(
                            'Monthly',
                            textAlign: TextAlign.center,
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.06,
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
                      'Yearly Prime',
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
                        'How many children in your family',
                        color: Color(0xFF6B7280),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.75,
                      ),
                      SizedBox(
                        height: 8.sp,
                      ),
                      Container(
                        width: 265,
                        height: 64,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: 36,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 24.sp,
                                      height: 24.sp,
                                      child: const Icon(CupertinoIcons.minus),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6),
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '1 Child',
                                              style: TextStyle(
                                                color: Color(0xFF000600),
                                                fontSize: 15,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                height: 1.60,
                                                letterSpacing: 0.75,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 24.sp,
                                      height: 24.sp,
                                      child: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32.sp,
                      ),
                      MyText(
                        '\$39.99 / Year',
                        textAlign: TextAlign.center,
                        color: Colors.black,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      MyText(
                        'Save 48.65% - \$3.33/MONTH/CHILD',
                        textAlign: TextAlign.center,
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.sp),
                        child: const Divider(
                          color: Color(0xFF3DAEF5),
                        ),
                      ),
                      MyText(
                        'Cancel at anytime, no commitment',
                        textAlign: TextAlign.center,
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 8.sp,
                      ),
                      Container(
                        width: 263.sp,
                        height: 37.sp,
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
                            'Support Klassly by subscribing',
                            color: Color(0xFF000600),
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
                          '5 Star Plan',
                          color: const Color(0xFF000600),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      getFeatures("2500 Video conferencing mobile"
                          "minutes for up to 25 participants"
                          " simultaneously."),
                      getFeatures("Calendar"),
                      getFeatures("Access to Report Cards"),
                      getFeatures("School Notifications"),
                      getFeatures("And so much more"),
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
            color: Color(0xFF131313),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ))
        ],
      ),
    );
  }
}
