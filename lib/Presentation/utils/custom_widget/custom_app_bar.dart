import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/get_user_data_cubit.dart';
import 'package:school_system/Presentation/BottomBarTeacher/prifile_screen/profile_detail_screen.dart';
import 'package:school_system/Presentation/common/views/menu_drawer/menu_drawer.dart';

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
            SizedBox(
              width: 8.sp,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const MenuDrawerScreen();
                  }));
                },
                child: Container(
                  height: 30.sp,
                  width: 30.sp,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withAlpha(80), blurRadius: 8)
                      ]),
                  child: const Center(
                    child: Icon(Icons.menu),
                  ),
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
                child: const Center(
                  child: Icon(Icons.notifications_none),
                ),
              ),
            ),
            SizedBox(
              width: 8.sp,
            ),
            BlocBuilder<GetUserDataCubit, GetUserDataState>(
              builder: (context, state) {
                if (state is GetUserDataLoaded) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileDetailScreen(
                                    data: state.model,
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
                              image: state.model!.image == null
                                  ? const AssetImage("images/users.png")
                                  : NetworkImage(state.model!.image!)
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withAlpha(80),
                                  blurRadius: 8)
                            ]),
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    width: 30.sp,
                  );
                }
              },
            ),
            SizedBox(
              width: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
