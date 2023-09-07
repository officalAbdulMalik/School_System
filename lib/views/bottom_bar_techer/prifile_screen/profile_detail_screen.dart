import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/user_data_model.dart';
import '../../utils/app_images.dart';
import '../../utils/custom_widget/my_text.dart';

class ProfileDetailScreen extends StatelessWidget {
  final User? data;

  const ProfileDetailScreen({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        children: [
          Row(
            children: [
              Expanded(
                flex:2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText('My Profile',fontSize: 20.sp,fontWeight: FontWeight.w600,)

                    , SizedBox(height: 3.sp,),
                    const MyText('Manage your all profile details here.',   color: Color(0xFF6B7280),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,)
                  ],
                ),),
              SizedBox(
                  width: 86.sp,
                  height: 86.sp,
                  child: Image.asset('images/satar.png')),
            ],
          ),

          SizedBox(height: 15.sp,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.sp,vertical: 10.sp,),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey.withAlpha(50),blurRadius: 5)
              ]
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Center(
                      child: Container(
                        height: 30.sp,
                        width: 30.sp,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage(AppImages.userImage)
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withAlpha(80), blurRadius: 8)
                            ]
                        ),
                      ),
                    ),
                    SizedBox(width: 15.sp,),
                    Expanded(
                      flex:2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(data!.firstName.toString()+ " ${data!.lastName.toString()}",fontSize: 16.sp,fontWeight: FontWeight.w600,)

                          , SizedBox(height: 3.sp,),
                           MyText(data!.permanentAddress.toString(),   color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,)
                        ],
                      ),),
                    SvgPicture.asset(AppImages.editIcon)

                  ],
                ),

                SizedBox(height: 10.sp,),
                Container(
                  width: 311,
                  height: 46,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF9FAFB),
                                  shape: OvalBorder(),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 4,
                              top: 4,
                              child: Container(
                                width: 24,
                                height: 24,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 5,
                                      top: 2,
                                      child: Container(
                                        width: 14,
                                        height: 20,
                                        decoration: BoxDecoration(
                                        ),
                                        child: Center(child: Icon(Icons.person),),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MyText(
                              'First Name',
                                color: Color(0xFF6B7280),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                            ),
                            const SizedBox(height: 4),
                            MyText(
                              data!.firstName.toString(),
                                color: Color(0xFF000600),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
