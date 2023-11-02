import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_system/Controllers/Services/AdsServices/show_ads.dart';
import 'package:school_system/Presentation/BottomBarParent/profile_screens/edit_profile_screen.dart';
import 'package:school_system/Presentation/utils/colors.dart';

import '../../../models/user_data_model.dart';
import '../../utils/app_images.dart';
import '../../utils/custom_widget/my_text.dart';
import 'components/profile_titles.dart';

class ProfileDetailScreen extends StatelessWidget {
  final UserData? data;

  const ProfileDetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      'My Profile',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 3.sp,
                    ),
                    const MyText(
                      'Manage your all profile details here.',
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
                  child: Image.asset('images/satar.png')),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          const ShowAds(),
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8.sp,
              vertical: 10.sp,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.sp),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey.withAlpha(50), blurRadius: 5)
                ]),
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
                              image: data!.image == null
                                  ? const AssetImage("images/users.png")
                                  : NetworkImage(data!.image!) as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withAlpha(80),
                                  blurRadius: 8)
                            ]),
                      ),
                    ),
                    SizedBox(
                      width: 15.sp,
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            "${data!.firstName.toString()} ${data!.lastName.toString()}",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 3.sp,
                          ),
                          MyText(
                            data!.permanentAddress.toString(),
                            color: const Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return EditProfileScreen(data: data);
                          }));
                        },
                        child: SvgPicture.asset(AppImages.editIcon))
                  ],
                ),
                SizedBox(
                  height: 10.sp,
                ),
                ProfileTitles(
                  title: "First Name",
                  value: data?.firstName ?? '',
                  icon: AppImages.profile,
                ),
                const Divider(),
                ProfileTitles(
                  title: "Last Name",
                  value: data?.lastName ?? '',
                  icon: AppImages.profile,
                ),
                const Divider(),
                ProfileTitles(
                  title: "Email",
                  value: data?.email ?? '',
                  icon: AppImages.emailIcon,
                ),
                const Divider(),
                ProfileTitles(
                  title: "Language",
                  value: data?.language ?? '',
                  icon: AppImages.languageIcon,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.sp,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 78.sp,
                  width: 1.sw,
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: kCardBLColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: MyText(
                          data!.type == 'teacher' ? 'My Classes' : "My Kids",
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.75,
                        ),
                      ),
                      const Expanded(
                        child: MyText(
                          '12',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
                  height: 78.sp,
                  width: 1.sw,
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: kGreenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: MyText(
                          data!.type == 'teacher'
                              ? 'My Subjects'
                              : "My Teachers",
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.75,
                        ),
                      ),
                      const Expanded(
                        child: MyText(
                          '8',
                          color: Color(0xFF000600),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          const ShowAds(),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
