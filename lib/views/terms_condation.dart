import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/views/utils/colors.dart';

class TermsCondation extends StatefulWidget {
  const TermsCondation({Key? key}) : super(key: key);

  @override
  State<TermsCondation> createState() => _TermsCondationState();
}

class _TermsCondationState extends State<TermsCondation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: kButtonColor,
          title: Text(
            "Terms and condition",
            style: GoogleFonts.acme(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Image.asset('images/terms.jpeg'));
  }
}
