import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/app_images.dart';
import '../../utils/custom_widget/my_text.dart';

class MeetingDetailScreen extends StatelessWidget {
  const MeetingDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),

        children: [

          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      'Meeting Details',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 3.sp,
                    ),
                    const MyText(
                      'You can add meeting participants here.',
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )
                  ],
                ),
              ),
              SizedBox(
                  width: 86.sp,
                  height: 86.sp,
                  child: Image.asset(AppImages.calendar)),
            ],
          ),
          SizedBox(height: 25.sp,),
          MyText(
            'Class A Meeting',
              color: const Color(0xFF000600),
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 15.sp,),
          MyText(
            'Thus Aug 31,2023',
              color: const Color(0xFF000600),
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,

          )  ,
          SizedBox(height: 10.sp,),

          Container(
            height: 30,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SvgPicture.asset(AppImages.historyClock),
                       SizedBox(width: 12.sp),
                      MyText(
                        '09:30 AM',
                          color: Color(0xFF000600),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '-',
                  style: TextStyle(
                    color: Color(0xFF000600),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppImages.historyClock),

                       SizedBox(width: 12.sp),
                      MyText(
                        '09:50AM',
                          color: const Color(0xFF000600),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            child: MyText(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam bibendum metus est, ut commodo dui tristique eget. Etiam ut leo a leo luctus tincidunt sed eget diam.',
                color: Color(0xFF6B7280),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.75,

            ),
          ),
          SizedBox(height: 20.sp,),
          MyText(
            'Meeting Organizer',
              color: Color(0xFF000600),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,

          ),
          SizedBox(height: 15.sp,),

          Container(
            width: 343,
            height: 40,
            padding: const EdgeInsets.all(8),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 24,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppImages.userImage),
                                  fit: BoxFit.fill,
                                ),
                                shape: OvalBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: MyText(
                    'Jack Nickolsan',
                    color: Color(0xFF000600),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.75,
                  ),
                ),

                Container(
                  width: 16,
                  height: 16,
                  child: Icon(Icons.more_vert,color: Colors.grey,),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
