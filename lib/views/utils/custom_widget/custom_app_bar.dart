import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/views/bottom_bar_techer/prifile_screen/profile_detail_screen.dart';

import '../../../controllers/cubits/common_cubit/get_user_data_cubit.dart';
import '../../bottom_bar_parent/profile_screens/edit_profile_screen.dart';
import '../app_images.dart';
import 'my_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomAppBar({
    super.key,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(45.sp);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(

        height: 45.sp,
        child: Row(
          children: [
            SizedBox(width: 8.sp,),
            Center(
              child: Container(
                height: 30.sp,
                width: 30.sp,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withAlpha(80), blurRadius: 8)
                    ]),
                child: Center(
                  child: Icon(Icons.menu),
                ),
              ),
            ),
            Spacer(),
            Center(
              child: Container(
                height: 30.sp,
                width: 30.sp,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withAlpha(80), blurRadius: 8)
                    ]),
                child: Center(
                  child: Icon(Icons.notifications_none),
                ),
              ),
            ),
            SizedBox(width: 8.sp,),
            BlocBuilder<GetUserDataCubit, GetUserDataState>(
              builder: (context, state) {
                if(state is GetUserDataLoaded){
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfileDetailScreen(
                                    data: state.model.user,
                                  )));
                    },
                    child: Center(
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
                  );

                }else{
                  return SizedBox(width: 30.sp,);
                }
              },
            ),
            SizedBox(width: 20.sp,),
          ],
        ),
      ),
    );
  }
}

