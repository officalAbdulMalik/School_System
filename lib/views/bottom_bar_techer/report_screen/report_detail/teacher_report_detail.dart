import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_system/views/utils/app_images.dart';
import 'package:school_system/views/utils/custom_widget/custom_app_bar.dart';
import 'package:school_system/views/utils/custom_widget/my_text.dart';
import 'package:school_system/views/utils/custom_widget/my_text_field.dart';

class TeacherReportDetail extends StatefulWidget {
  const TeacherReportDetail({Key? key}) : super(key: key);

  @override
  State<TeacherReportDetail> createState() => _TeacherReportDetailState();
}

class _TeacherReportDetailState extends State<TeacherReportDetail> {
  TextEditingController searchController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: (){},
        child: Icon(Icons.add),
      ),
      appBar: const CustomAppBar(),
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
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: 15.sp,
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  height: 70.sp,
                  padding: const EdgeInsets.all(12),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD6F4EA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: MyText(
                                'Total Reports',
                                color: const Color(0xFF6B7280),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.75,
                              ),
                            ),
                            Flexible(
                              child: MyText(
                                '15 Reports',
                                color: const Color(0xFF000600),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 16.sp,
                        height: 16.sp,
                        child: const Icon(
                          Icons.more_vert,
                          color: Color(0xff6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 8.sp,
              ),
              Expanded(
                child: Container(
                  height: 70.sp,
                  padding: const EdgeInsets.all(12),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFEEF5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: MyText(
                                'Published Reports',
                                color: const Color(0xFF6B7280),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.75,
                              ),
                            ),
                            Flexible(
                              child: MyText(
                                '8 Reports',
                                color: const Color(0xFF000600),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 16.sp,
                        height: 16.sp,
                        child: const Icon(
                          Icons.more_vert,
                          color: Color(0xff6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.sp,),

          Row(
            children: [
              Expanded(child: MyTextField(
                controller: searchController,
                filledColor: Color(0xFFF3F4F6),
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),),
              SizedBox(width: 6.sp,),
              Container(
                width: 44.sp,
                height: 44.sp,
                decoration: ShapeDecoration(
                  color: Color(0xFFF3F4F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Center(child:SvgPicture.asset(AppImages.setting),),
              )
            ],
          ),
          SizedBox(height: 20.sp,),
          GridView.builder(
              itemCount: 6,

              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.5,
            crossAxisCount: 2,crossAxisSpacing: 15.sp,mainAxisSpacing: 12.sp
          ), itemBuilder: (context,index){

                return           Container(
                  height: 87.sp,
                  padding: const EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: MyText(
                                'Grade 6',
                                color: const Color(0xFF6B7280),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.75,
                              ),
                            ),
                            const Expanded(child: Align(

                                alignment: Alignment.centerRight,
                                child: Icon(Icons.more_vert)),),
                          ],
                        ),
                      ),
                      Expanded(
                          child: MyText(
                            'Class A',
                            color: const Color(0xFF000600),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,

                          )),
                      Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: MyText(
                                  'Term 2',
                                  color: const Color(0xFF6B7280),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,

                                ),
                              ),
                              Expanded(child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(AppImages.glassesStar)))
                            ],
                          )),
                    ],
                  ),
                );
          }),
        ],
      ),
    );
  }
}
