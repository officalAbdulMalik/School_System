import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Controllers/Services/Connection/internet_conneection.dart';
import 'package:school_system/Presentation/common/views/bottom_bar.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';

class ConnectivityScreen extends StatefulWidget {
  const ConnectivityScreen({Key? key}) : super(key: key);

  @override
  State<ConnectivityScreen> createState() => _ConnectivityScreenState();
}

class _ConnectivityScreenState extends State<ConnectivityScreen> {
  @override
  void initState() {
    if (Navigator.canPop(context)) {
      AppConnectivity.connectionChanged(onConnected: () {
        Navigator.of(context).pop(true);
      });
    } else {
      AppConnectivity.connectionChanged(onConnected: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomBarPages(index: 0)),
            (route) => false);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'images/connection.png',
            height: 93.h,
            width: 100.w,
          )),
          Text(
            'Whoops!',
            style: GoogleFonts.poppins(
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 30).h,
            child: Text(
              'No Internet connection was found.Check\nyour connection or try again. ',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40.h,
                width: 280.w,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Center(
                  child: MyText(
                    "Try Again",
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
