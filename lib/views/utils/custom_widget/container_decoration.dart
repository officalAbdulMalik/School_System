import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/views/utils/colors.dart';

class DecoratedContainer extends StatelessWidget {
  DecoratedContainer({Key? key, required this.child}) : super(key: key);

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.sp, right: 20.sp),
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.sp),
        color: kContainerColor,
      ),
      child: child,
    );
  }
}

class ContinerDecoration {
  static continerDecoration() {
    return BoxDecoration(
      color: kContainerColor,
      borderRadius: BorderRadius.circular(15.r),
    );
  }
}
