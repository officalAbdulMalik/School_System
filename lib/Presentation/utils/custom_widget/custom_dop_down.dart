import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_system/Presentation/common/views/bottom_bar.dart';
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
            child: DecoratedContainer(
              child: DropdownButtonFormField(
                padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
                borderRadius: BorderRadius.circular(10),
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null) {
                    validation = true;
                    setState(() {});
                  } else {
                    validation = false;
                    setState(() {});
                    return null;
                  }
                },

                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIconConstraints: BoxConstraints(
                    maxHeight: 60.w,
                    maxWidth: 50.w,
                    minHeight: 22.w,
                    minWidth: 23.w,
                  ),
                  errorMaxLines: 1,

                  // EdgeInsets.symmetric(
                  //   vertical: 13,
                  //   horizontal: prefixIcon != null ? 10 : 6,
                  // ).r,
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
          ),
          validation == false
              ? const SizedBox()
              : Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '    field is required',
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
