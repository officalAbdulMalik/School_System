import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/views/utils/app_images.dart';
import 'package:school_system/views/utils/custom_widget/custom_app_bar.dart';
import 'package:school_system/views/utils/custom_widget/my_text.dart';

class TeacherReportScreen extends StatelessWidget {
  const TeacherReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        children: [
          MyText(
            'Reports',
              color: const Color(0xFF000600),
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
          ),
          MyText(
            'Manage all your reports here',
              color: const Color(0xFF6B7280),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,),
          SizedBox(height: 15.sp,),

          Row(
            children: [
              Expanded(
                child: MyText(
                  'My Subjects',
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                ),
              ),
               Expanded(
                child: MyText(
                  '3 Subjects',
                    color: const Color(0xFF6B7280),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
          SizedBox(height: 8.sp,),
          SizedBox(
            height: 110.sp,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
              return Container(
                margin: EdgeInsets.only(right: 6.sp),
                width: 126.sp,
                height: 109.sp,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 0.50, color: Color(0xFFF7D55C)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x19303133),
                      blurRadius: 30,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Container(
                          width: 64.sp,
                          height: 64.sp,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppImages.starConfuse),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    MyText(
                      'Mathematics',
                      color: const Color(0xFF000600),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,

                    ),
                  ],
                ),
              );
            }),
          ),
          SizedBox(height: 15.sp,),
          Row(
            children: [
              Expanded(
                child: MyText(
                  'My Classes',
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                child: MyText(
                  '8 Classes',
                  color: const Color(0xFF6B7280),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),

          SizedBox(height: 15.sp,),
          GridView.builder(
            itemCount: 4,
              shrinkWrap: true,
              primary: false,

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 15.sp,crossAxisSpacing: 15.sp), itemBuilder: (context,index){
            return Container(
              width: 163.50,
              height: 135,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: ShapeDecoration(
                color: Color(0xFFE2F4FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(

                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/satar.png'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: MyText(
                              'Class A',
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,

                            ),
                          ),
                          Flexible(
                            child: MyText(
                              'Grade 6',
                                color: const Color(0xFF6B7280),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.75,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
