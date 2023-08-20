import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/views/sign_up_screen.dart';
import 'package:school_system/views/utils/colors.dart';
import 'package:school_system/views/utils/custom_widget/container_decoration.dart';
import 'package:school_system/views/utils/shade_prefrence.dart';

import '../controllers/firebase_repos/firebase_notification.dart';

class SelectCountry extends StatefulWidget {
  SelectCountry({Key? key}) : super(key: key);

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  final ValueNotifier<bool> loading = ValueNotifier(false);

  final ValueNotifier<bool> showPassword = ValueNotifier(false);

  String type = '';

  getToken() async {
    String token = await FirebaseNotificationsService().getDeviceToken();
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
        backgroundColor: kPrimaryColor,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 90.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Select Your Country',
                    style: GoogleFonts.acme(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 24.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 55.h,
                ),
                InkWell(
                  onTap: () async {
                    LoginApiShadePreference.preferences!
                        .setString('country', 'US');
                    setState(() {});
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ));
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10.sp),
                    height: 60.h,
                    width: 340.w,
                    decoration: ContinerDecoration.continerDecoration(),
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 40.h,
                              width: 100.w,
                              child: Image.asset(
                                'images/us.jpg',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.h,
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.only(top: 13.sp),
                              child: SizedBox(
                                height: 40.h,
                                width: 100.w,
                                child: Text(
                                  'United State',
                                  style: GoogleFonts.acme(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
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
                SizedBox(
                  height: 25.h,
                ),
                // buildTextFieldLabel('Password'),
                InkWell(
                  onTap: () async {
                    LoginApiShadePreference.preferences!
                        .setString('country', 'UK');
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ));

                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10.sp),
                    height: 60.h,
                    width: 340.w,
                    decoration: ContinerDecoration.continerDecoration(),
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 30.h,
                              width: 80.w,
                              child: Image.asset('images/un.png'),
                            ),
                          ),
                          SizedBox(
                            width: 10.h,
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.only(top: 13.sp),
                              child: SizedBox(
                                height: 40.h,
                                width: 100.w,
                                child: Text(
                                  'United Kingdom',
                                  style: GoogleFonts.acme(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
