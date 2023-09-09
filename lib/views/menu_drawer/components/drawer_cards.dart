import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/custom_widget/my_text.dart';

class DrawerCard extends StatelessWidget {
  final Color? color;
  final VoidCallback onTap;
  final String title;
  const DrawerCard({Key? key,this.color,required this.title,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return                     Container(
      margin: EdgeInsets.only(bottom: 5.sp),
      height: 40.sp,
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child:  Row(

        children: [
          Expanded(
            child: MyText(
              title,
              color: color ?? const Color(0xFF000600),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.75,
            ),
          ),
          SizedBox(width: 27),

          Icon(Icons.arrow_forward_ios,size: 18.sp,color: color??Colors.grey[500],)
        ],
      ),
    )
    ;
  }
}
