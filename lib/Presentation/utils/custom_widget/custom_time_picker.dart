import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';

class CustomTimePickerWithValidation extends StatefulWidget {
  // final String imageUrl;
  final String? validationText;
  final TextEditingController controller;

  final bool isBorderRequired;
  final bool isShadowRequired;
  final bool? isSuffix;
  final double vMargin;
  final double hMargin;
  final String? Function(String?)? validator;
  Widget? prefixIcon;
  Widget? suffixIcon;
  double? sHeight;
  double? sWidth;
  double? pHeight;
  double? pWidth;
  String? hintText;

  final EdgeInsets? contentPadding;

  // final String? Function(String?)? validator;
  CustomTimePickerWithValidation(
      {super.key,
      // required this.text,
      // required this.imageUrl,
      // required this.dateTime,
      this.vMargin = 8,
      this.hMargin = 0,
      this.isBorderRequired = true,
      this.isShadowRequired = false,
      this.hintText,
      required this.validator,
      this.isSuffix = false,
      this.validationText,
      required this.controller,
      this.prefixIcon,
      this.suffixIcon,
      this.sHeight,
      this.sWidth,
      this.pHeight,
      this.pWidth,
      this.contentPadding});

  @override
  State<CustomTimePickerWithValidation> createState() =>
      _CustomTimePickerWithValidationState();
}

class _CustomTimePickerWithValidationState
    extends State<CustomTimePickerWithValidation> {
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return CustomTextFieldWithOnTap(
        contentPadding: widget.contentPadding,
        validateText: widget.validationText ?? "Date Required",

        // isValid: false,

        readOnly: true,
        onTap: () async {
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarColor: Colors.black12,
          ));
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarColor: Colors.black12,
          ));
          var time = await pickTime(context);
          if (time == null) return;

          final newDateTime = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            time.hour,
            time.minute,
          );

          setState(() {
            //  date = newDate;
            // widget.dateTime(newDate);
            widget.controller.text =
                getHumanReadableDateAndTime(newDateTime.toString());
          });
        },
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        isShadowRequired: widget.isShadowRequired,
        suffixHeight: widget.sHeight,
        suffixWidth: widget.sWidth,
        isValid: false,
        controller: widget.controller,
        isBorderRequired: widget.isBorderRequired,
        hintText: widget.hintText ?? "",
        validator: widget.validator,
        textInputType: TextInputType.text);
  }

  // String getHumanReadableDateAndTime(String dt) {
  //   DateTime dateTime = DateTime.parse(dt);
  //   return intl.DateFormat('yyyy/MM/dd').format(dateTime);
  // }
  String getHumanReadableDateAndTime(String dt) {
    DateTime dateTime = DateTime.parse(dt);
    return intl.DateFormat('').add_jm().format(dateTime);
  }

  Future<TimeOfDay?> pickTime(BuildContext context) => showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: kPrimaryColor,
              ),
            ),
            child: child!,
          );
        },
      ).whenComplete(() {
        setState(() {
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
          ));
        });
      });
}

class CustomTextFieldWithOnTap extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final bool isValid;
  final bool isBorderRequired;
  final String? titleText;
  final int? maxline;
  final String? validateText;
  final bool? isShadowRequired;
  final Color? titleTextColor;
  final double? suffixWidth;
  final double? suffixHeight;
  final ValueChanged? onChanged;
  final GestureTapCallback? onTap;
  final bool? readOnly;

  final EdgeInsets? contentPadding;

  const CustomTextFieldWithOnTap({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    required this.textInputType,
    this.suffixIcon,
    this.validator,
    this.prefixIcon,
    this.isValid = false,
    this.isBorderRequired = true,
    this.titleText = "",
    this.maxline = 1,
    this.validateText,
    this.isShadowRequired = false,
    this.titleTextColor,
    this.suffixWidth = 15,
    this.suffixHeight = 15,
    this.onChanged,
    this.contentPadding,
    this.onTap,
    this.readOnly,
  }) : super(key: key);

  final double borderRadius = 12;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleText!.isNotEmpty
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 3).r,
                      child: MyText(
                        titleText!,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                )
              : Container(),
          Container(
            decoration: BoxDecoration(
                // boxShadow: isShadowRequired! ? [AppShadow.normal()] : [],
                ),
            child: TextFormField(
              onTap: onTap,
              readOnly: readOnly ?? false,

              //autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: isValid
                  ? (v) {
                      if (v!.trim().isEmpty) {
                        return validateText;
                      }
                      return null;
                    }
                  : validator,
              onChanged: onChanged,
              keyboardType: textInputType,
              obscureText: obscureText,
              controller: controller,
              maxLines: maxline,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,

                filled: true,
                hintText: hintText,
                prefixIcon: prefixIcon != null
                    ? SizedBox(
                        width: 15.w,
                        height: 15.w,
                        child: Center(
                          child: prefixIcon,
                        ),
                      )
                    : null,
                suffixIcon: suffixIcon != null
                    ? SizedBox(
                        width: suffixWidth ?? 20.sp,
                        height: suffixHeight ?? 20.sp,
                        child: Center(
                          child: suffixIcon,
                        ),
                      )
                    : null,
                // hintStyle: Styles.latoRegular(
                //   context,
                //   color: AppColors.greyColor,
                //   fontSize: 14.sp,
                // ),
                ///changess
                contentPadding: contentPadding ??
                    const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 10,
                    ).r,
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    borderRadius.r,
                  ),
                  borderSide: BorderSide(
                    color: isBorderRequired ? Colors.red : Colors.transparent,
                  ),
                ),
                errorBorder: isBorderRequired
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius.r,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                      )
                    : outlineInputBorder(),
                border: isBorderRequired
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius.r,
                        ),
                      )
                    : outlineInputBorder(),
                focusedBorder: isBorderRequired
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius.r,
                        ),
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                        ),
                      )
                    : outlineInputBorder(),
                enabledBorder: isBorderRequired
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius.r,
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      )
                    : outlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius.r),
      borderSide: const BorderSide(color: Colors.transparent),
    );
  }
}
