import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/delate_account_cubit.dart';
import 'package:school_system/Presentation/common/resources/dailog.dart';
import 'package:school_system/Presentation/common/views/loginScreen.dart';
import 'package:school_system/Presentation/common/views/onboarding_screen.dart';
import 'package:school_system/Presentation/common/views/privacy_police.dart';
import 'package:school_system/Presentation/common/views/sign_up_screen.dart';
import 'package:school_system/Presentation/common/views/terms_condation.dart';
import 'package:school_system/Presentation/utils/app_images.dart';
import 'package:school_system/Presentation/utils/custom_widget/my_text.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import '../subscription_screen/subscription_view.dart';
import 'components/drawer_cards.dart';

class MenuDrawerScreen extends StatelessWidget {
  MenuDrawerScreen({Key? key}) : super(key: key);

  final String? userID =
      LoginApiShadePreference.preferences!.getString('user_id');

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
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const PrivacyPolice();
                        },
                      ));
                    },
                  ),
                  DrawerCard(
                    title: 'Terms & Conditions',
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const TermsCondation();
                        },
                      ));
                    },
                  ),
                ],
              ),
            ),
            DrawerCard(
              title: 'Sign Out',
              onTap: () {
                Dialogs.logOutDialog(context);
              },
            ),
            BlocListener<DelateAccountCubit, DelateAccountState>(
              listener: (context, state) {
                if (state is DelateAccountLoading) {
                  Dialogs.loadingDialog(context);
                }
                if (state is DelateAccountLoaded) {
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LogInScreen();
                      },
                    ),
                    (route) => false,
                  );
                }
                // TODO: implement listener
              },
              child: DrawerCard(
                title: 'Delete Account',
                onTap: () {
                  Dialogs.deleteAccountDialog(context, userID);
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
