import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';

import '../../utils/colors.dart';
import 'loginScreen.dart';

class CompleteScreen extends StatelessWidget {
  const CompleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: 100.h,
          ),
          SizedBox(
            height: 150.h,
            width: 300.w,
            child: Image.asset('images/complete.png'),
          ),
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: Text(
              'Complete',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: Text(
              ' Congratulations! You have been\nsuccessfully authenticated.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
              ),
            ),
          ),
          SizedBox(
            height: 150.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return LogInScreen();
                  },
                ));
              },
              child: CustomWidgets.customButton('Continue'),
            ),
          )
        ],
      ),
    );
  }
}
