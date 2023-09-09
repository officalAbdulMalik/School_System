import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatefulWidget {
  final bool? enabled;

  final bool? isPasswordField;
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

  const MyTextField({
    Key? key,
    this.label,
    this.isRequiredField,
    this.borderColor,
    this.filledColor,
    this.contentPadding,
    this.enabled = true,
    this.suffixIcon,
    this.isPasswordField = false,
    required this.controller,
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

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        cursorColor: Colors.blue,
        //  cursorHeight: 20.sp,
        enabled: widget.enabled,
        // autofocus: true,

        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.isPasswordField! ? showPassword : false,
        controller: widget.controller,
        maxLines: widget.maxLine ?? 1,

        validator: widget.isRequiredField == null
            ? null
            : (value) {
                if (value == null || value.isEmpty) {
                  return ' ${widget.label ?? widget.hintText} ${"is required"}';
                }

                return null;
              },
        style: GoogleFonts.poppins(
            color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w400),
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
                top: 12.sp,
                bottom: 15.sp,
              ),

          errorStyle: TextStyle(
            fontSize: 12.sp,
            height: 0.2.sp,
          ),

          hintStyle: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          suffixIconConstraints:
              BoxConstraints(maxHeight: 40.sp, maxWidth: 50.sp),
          hintText: widget.hintText,
          suffixIcon: widget.isPasswordField!
              ? IconButton(
                  hoverColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    showPassword == true
                        ? Icons.visibility
                        : Icons.visibility_off,
                    size: 22.sp,
                  ))
              : Center(
                  child: widget.suffixIcon,
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.sp),
            borderSide: BorderSide(
              color: widget.borderColor ?? Colors.transparent,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.sp),
            borderSide: BorderSide(
              color: widget.borderColor ?? Colors.transparent,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.sp),
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.sp),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.sp),
            borderSide: BorderSide(
              color: widget.borderColor ?? Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.sp),
            borderSide: BorderSide(
              color: widget.borderColor ?? Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
