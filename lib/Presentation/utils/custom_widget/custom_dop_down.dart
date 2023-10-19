import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Presentation/common/views/bottom_bar.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/container_decoration.dart';

class CustomDropDown extends StatefulWidget {
  CustomDropDown(
      {Key? key,
      required this.itemsMap,
      required this.onChanged,
      required this.hintText})
      : super(key: key);

  final List<DropdownMenuItem<Object>> itemsMap;
  final ValueChanged onChanged;
  String hintText;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  bool validation = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: validation == true ? 60.h : 45.h,
      child: Column(
        children: [
          Expanded(
            child: DropdownButtonFormField(
              borderRadius: BorderRadius.circular(10),
              //autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'Field is required';
                }

                return null;
              },
              decoration: InputDecoration(
                filled: true,
                errorMaxLines: 1,
                isCollapsed: true,
                //  isDense: true,
                fillColor: kContainerColor,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.r)),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: 60.w,
                  maxWidth: 50.w,
                  minHeight: 22.w,
                  minWidth: 23.w,
                ),
                contentPadding: EdgeInsets.only(
                    top: 10.sp, bottom: 10.sp, left: 10, right: 10),
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
                suffixIconConstraints:
                    BoxConstraints(maxHeight: 40.sp, maxWidth: 40.sp),
                hintText: widget.hintText,
              ),
              hint: Text(
                widget.hintText,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              icon: const Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
              ),
              iconSize: 28.r,
              isExpanded: true,
              // style: Styles.latoRegular(
              //   context,
              //   fontSize: 14.sp,
              // ),
              value: null,
              onChanged: widget.onChanged,
              items: widget.itemsMap,
            ),
          ),
          // validation == false
          //     ? const SizedBox()
          //     : Align(
          //         alignment: Alignment.centerLeft,
          //         child: Text(
          //           '    field is required',
          //           style: GoogleFonts.poppins(
          //             color: Colors.red,
          //           ),
          //         ),
          //       ),
        ],
      ),
    );
  }
}
