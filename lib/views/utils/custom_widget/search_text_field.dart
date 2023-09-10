import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/views/utils/colors.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController? controller;

  final String? hintText;
  final int? maxLine;
  final Color? borderColor;
  final Color? filledColor;
  final Function(String) callBack;

  const SearchTextField({
    Key? key,
    this.borderColor,
    this.filledColor,
    this.controller,
    // required this.label,
    this.hintText,
    this.maxLine,
    required this.callBack,
  }) : super(key: key);

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextFormField(
        onChanged: widget.callBack,
        cursorColor: Colors.blue,
        //  cursorHeight: 20.sp,
        // autofocus: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        maxLines: widget.maxLine ?? 1,
        style: GoogleFonts.poppins(
            color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.sp),
            borderSide: BorderSide.none,
          ),
          filled: true,
          errorMaxLines: 1,
          isCollapsed: true,
          //  isDense: true,
          fillColor: widget.filledColor ?? Colors.white,
          contentPadding: EdgeInsets.only(
            left: 15.sp,
            right: 8.sp,
            top: 15.sp,
            bottom: 10.sp,
          ),
          errorStyle: TextStyle(
            fontSize: 12.sp,
            height: 0.2.sp,
          ),
          hintStyle: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: kDescriptionColor,
          ),
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
