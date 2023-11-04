import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Presentation/utils/custom_widget/container_decoration.dart';

class MyTextField extends StatefulWidget {
  final bool? enabled;

  final bool? isPasswordField;
  final bool? isEmailField;

  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final bool? isRequiredField;
  final String? hintText;

  final String? label;
  final Widget? suffixIcon;
  final int? maxLine;
  final TextInputType? keyboardType;
  final Color? borderColor;
  final Color? filledColor;
  final Widget? prefixIcon;
  final Function(String)? onCanaged;

  const MyTextField({
    Key? key,
    this.label,
    this.isRequiredField,
    this.isEmailField,
    this.borderColor,
    this.filledColor,
    this.contentPadding,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.isPasswordField = false,
    required this.controller,
    this.onCanaged,
    // required this.label,
    this.hintText,
    this.maxLine,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool showPassword = true;

  bool isEmailValid(String email) {
    // Regular expression for a valid email address
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      cursorColor: Colors.blue,
      //  cursorHeight: 20.sp,
      enabled: widget.enabled,
      // autofocus: true,
      onChanged: widget.onCanaged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: widget.isPasswordField! ? showPassword : false,
      controller: widget.controller,
      maxLines: widget.maxLine ?? 1,

      validator: widget.isRequiredField == null
          ? null
          : widget.isEmailField == null
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return '${widget.label ?? widget.hintText} ${"is required"}';
                  }
                  return null;
                }
              : (value) {
                  if (isEmailValid(value!)) {
                    return null;
                  }
                  return 'Email is not correct"';
                },
      style: GoogleFonts.poppins(
          color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        filled: true,
        errorMaxLines: 1,
        isCollapsed: true,
        //  isDense: true,
        fillColor: widget.filledColor ?? Colors.white,
        contentPadding: widget.contentPadding ??
            EdgeInsets.only(
              left: 15.sp,
              right: 8.sp,
              top: 15.sp,
              bottom: 15.sp,
            ),

        errorStyle: TextStyle(
          fontSize: 12.sp,
          height: 0.2.sp,
          color: Colors.red,
        ),
        hintStyle: GoogleFonts.poppins(
          fontSize: 14.sp,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIconConstraints:
            BoxConstraints(maxHeight: 40.sp, maxWidth: 40.sp),
        hintText: widget.hintText,
        suffixIcon: widget.isPasswordField!
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Icon(showPassword == false
                      ? Icons.visibility_off
                      : Icons.visibility),
                ))
            : Center(
                child: widget.suffixIcon,
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.sp),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class ReportMyTextField extends StatefulWidget {
  final bool? enabled;

  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;

  final String? hintText;

  final Color? filledColor;
  final Widget? prefixIcon;
  final Function(String) callback;

  const ReportMyTextField({
    Key? key,
    this.filledColor,
    this.contentPadding,
    required this.callback,
    this.enabled = true,
    this.prefixIcon,
    required this.controller,
    // required this.label,
    this.hintText,
  }) : super(key: key);

  @override
  State<ReportMyTextField> createState() => _ReportMyTextFieldState();
}

class _ReportMyTextFieldState extends State<ReportMyTextField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.callback,
      cursorColor: Colors.blue,
      //  cursorHeight: 20.sp,
      enabled: widget.enabled,
      // autofocus: true,

      autovalidateMode: AutovalidateMode.onUserInteraction,

      controller: widget.controller,

      style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
        filled: true,
        errorMaxLines: 1,
        isCollapsed: true,
        //  isDense: true,
        fillColor: widget.filledColor ?? Colors.white,
        contentPadding: widget.contentPadding ??
            EdgeInsets.only(
              left: 15.sp,
              right: 8.sp,
              top: 7.sp,
              bottom: 7.sp,
            ),
        hintStyle: GoogleFonts.poppins(
          fontSize: 12.sp,
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIconConstraints:
            BoxConstraints(maxHeight: 40.sp, maxWidth: 40.sp),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
