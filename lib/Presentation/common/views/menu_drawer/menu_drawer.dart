import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/delate_account_cubit.dart';
import 'package:school_system/Data/Repository/delete_account.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/common/views/loginScreen.dart';
import 'package:school_system/Presentation/common/views/sign_up_screen.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

import '../subscription_screen/subscription_view.dart';
import 'components/drawer_cards.dart';

class MenuDrawerScreen extends StatelessWidget {
  const MenuDrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              'Manage Your Account',
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(
                              height: 3.sp,
                            ),
                            const MyText(
                              'Manage your account details here',
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
                        child: Image.asset(AppImages.starConfuse),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25.sp,
                  ),
                  DrawerCard(
                    title: 'My Subscription',
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const SubscriptionView();
                      }));
                    },
                  ),
                  DrawerCard(
                    title: 'My Minutes',
                    onTap: () {},
                  ),
                  DrawerCard(
                    title: 'Preferences',
                    onTap: () {},
                  ),
                  DrawerCard(
                    title: 'Security',
                    onTap: () {},
                  ),
                  DrawerCard(
                    title: 'Rate Us In the App Store',
                    onTap: () {},
                  ),
                  DrawerCard(
                    title: 'Privacy Policy',
                    onTap: () {},
                  ),
                  DrawerCard(
                    title: 'Terms & Conditions',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            DrawerCard(
              title: 'Sign Out',
              onTap: () {
                LoginApiShadePreference.preferences!.remove('api_token');
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) =>
                        LogInScreen(), // Replace with your login page widget
                  ),
                  (Route<dynamic> route) => false, // Remove all previous routes
                );
              },
            ),
            BlocListener<DelateAccountCubit, DelateAccountState>(
              listener: (context, state) {
                if (state is DelateAccountLoading) {
                  Dialogs.showLoadingDialog(context);
                }
                if (state is DelateAccountLoaded) {
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ));
                }
                // TODO: implement listener
              },
              child: DrawerCard(
                title: 'Delete Account',
                onTap: () {
                  context.read<DelateAccountCubit>().deleteAccount();
                },
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
          ],
        ),
      ),
    );
  }
}
