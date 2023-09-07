import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/views/utils/colors.dart';

class PrivacyPolice extends StatefulWidget {
  const PrivacyPolice({Key? key}) : super(key: key);

  @override
  State<PrivacyPolice> createState() => _PrivacyPoliceState();
}

class _PrivacyPoliceState extends State<PrivacyPolice> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 500,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.sp),
                        bottomRight: Radius.circular(20.sp)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Privacy Police',
                              style: GoogleFonts.poppins(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(child: Image.asset('images/terms.jpeg')),
              ],
            ),
          )),
    );
  }
}
