import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CUstomDropDown extends StatefulWidget {
  CUstomDropDown({Key? key, required this.item, required this.value1})
      : super(key: key);

  List<String> item;
  String value1;

  @override
  State<CUstomDropDown> createState() => _CUstomDropDownState();
}

class _CUstomDropDownState extends State<CUstomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.sp),
      height: 50.h,
      width: 340.w,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15.sp),
        gradient: const LinearGradient(
            colors: [
              Color(0xFFC7CEF1),
              Color(0xFF8C9BE3),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.1, 1.0],
            tileMode: TileMode.decal),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(
                widget.value1,
                style: GoogleFonts.acme(color: Colors.black, fontSize: 11.sp),
              )),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0.sp),
              child: DropdownButton<String>(
                underline: SizedBox(),
                items: widget.item.map((String value) {
                  return DropdownMenuItem<String>(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  widget.value1 = value!;
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
