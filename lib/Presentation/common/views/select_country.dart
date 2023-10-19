import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Presentation/common/views/sign_up_screen.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

import '../../utils/custom_widget/custom_row_widget.dart';
import '../../utils/custom_widget/navigator_pop.dart';

class SelectCountry extends StatefulWidget {
  SelectCountry({Key? key}) : super(key: key);

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  final ValueNotifier<bool> loading = ValueNotifier(false);

  final ValueNotifier<bool> showPassword = ValueNotifier(false);

  String country = '';
  //
  // getToken() async {
  //   String token = await FirebaseNotificationsService().getDeviceToken();
  //   LoginApiShadePreference.preferences!.setString('device_token', token);
  // }

  @override
  void initState() {
    // getToken();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                const NavigatorPop(),
                SizedBox(
                  height: 20.h,
                ),
                CustomRowWidget(
                  text1: 'Choice Your Country',
                  text2: 'Select Your country from here...',
                  image: 'con_star.png',
                ),
                SizedBox(
                  height: 70.h,
                ),
                InkWell(
                  onTap: () async {
                    LoginApiShadePreference.preferences!
                        .setString('country', 'US');
                    country = 'US';
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
                    decoration: BoxDecoration(
                      color: kBorderColor.withOpacity(0.2),
                      border: Border.all(
                          color:
                              country == "US" ? kPrimaryColor : Colors.white),
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          const Expanded(
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage('images/usa.png'),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text(
                              'United States',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp,
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
                    country = 'UK';
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
                    decoration: BoxDecoration(
                      color: kBorderColor.withOpacity(0.2),
                      border: Border.all(
                          color:
                              country == "UK" ? kPrimaryColor : Colors.white),
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          const Expanded(
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage('images/un.png'),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text(
                              'United Kingdom',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp,
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
