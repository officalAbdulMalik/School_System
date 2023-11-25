import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Controllers/firebase_repos/firebase_notifications.dart';
import 'package:school_system/Presentation/common/views/select_country.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/show_star_image.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final ValueNotifier<bool> loading = ValueNotifier(false);

  final ValueNotifier<bool> showPassword = ValueNotifier(false);

  String type = '';

  getToken() async {
    String token = await NotificationServices().getDeviceToken();
    LoginApiShadePreference.preferences!.setString('device_token', token);
  }

  @override
  void initState() {
    getToken();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                ShowStarsImage(
                  width: 1.sw,
                  height: 140.h,
                  imageUrl: 'images/star_c.webp',
                ),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Parent Teacher Mobile ',
                    style: GoogleFonts.poppins(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21.sp),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Connecting Parents and Teachers Worldwide ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.amber,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 55.h,
                ),
                InkWell(
                  onTap: () async {
                    LoginApiShadePreference.preferences!
                        .setString('role', 'Teacher');
                    type = 'Teacher';

                    setState(() {});
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return SelectCountry();
                      },
                    ));
                    String token =
                        await NotificationServices().getDeviceToken();
                    LoginApiShadePreference.preferences!
                        .setString('device_token', token);
                  },
                  child: Container(
                    height: 50.h,
                    width: 340.w,
                    decoration: BoxDecoration(
                      color: kBorderColor.withOpacity(0.2),
                      border: type == "Teacher"
                          ? Border.all(color: kPrimaryColor)
                          : Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    child: Center(
                      child: Text(
                        'I\'m a Teacher',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                // buildTextFieldLabel('Password'),
                InkWell(
                  onTap: () async {
                    LoginApiShadePreference.preferences!
                        .setString('role', 'Parents');
                    type = 'Parents';
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return SelectCountry();
                      },
                    ));

                    setState(() {});
                  },
                  child: Container(
                    height: 50.h,
                    width: 340.w,
                    decoration: BoxDecoration(
                      color: kBorderColor.withOpacity(0.2),
                      border: type == "Parents"
                          ? Border.all(color: kPrimaryColor)
                          : Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    child: Center(
                      child: Text(
                        '  I\'m a Parent',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
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
