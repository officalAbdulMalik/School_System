import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:school_system/Controllers/Cubits/CommonCubit/delate_account_cubit.dart';
import 'package:school_system/Presentation/common/views/loginScreen.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:school_system/Presentation/utils/custom_widget/custom_widgets.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

class Dialogs {
  static Future<void> showLoadingDialog(BuildContext context,
      {Widget? child, bool? barrierDismissible}) async {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black12,
      barrierDismissible: barrierDismissible ?? false,
      builder: (BuildContext context) {
        return loadingWidget(child: child);
      },
    );
  }

  static Widget loadingWidget({Widget? child}) {
    return Dialog(
      insetPadding: const EdgeInsets.all(15).r,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10).r,
      ),
      child: child ??
          Lottie.asset(
            'images/loader.json',
            height: 100,
            width: 100,

            //  color: Colors.transparent,
            //frameRate: 30, // default is 15 FPS
          ),
    );
  }

  static logOutDialog(BuildContext context) {
    return iosDialog(
        context,
        SizedBox(
          height: 50.h,
          // width: 130.w,
          child: Column(
            // physics: const NeverScrollableScrollPhysics(),
            //shrinkWrap: true,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10).h,
              //   child: Text(
              //     'Logout',
              //     style: Styles.latoBold(context, fontSize: 22.sp),
              //   ),
              // ),
              SizedBox(
                height: 5.h,
              ),
              //Divider(color: AppColors.primaryColor,height: 2.sp,thickness: 1,),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //   SizedBox(width: 40.sp,),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CustomWidgets.customButton(
                        "Cancel",
                        buttonColor: kDescriptionColor,
                      ),
                    )),

                    SizedBox(
                      width: 5.sp,
                    ),
                    //  SizedBox(width: 10,),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        LoginApiShadePreference.preferences!
                            .remove('api_token');
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) =>
                                LogInScreen(), // Replace with your login page widget
                          ),
                          (route) => false, // Remove all previous routes
                        );
                      },
                      child: CustomWidgets.customButton(
                        "Confirm",
                        buttonColor: kPrimaryColor,
                      ),
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
        'Are you sure to logout  account?');
  }

  static deleteAccountDialog(BuildContext context, String? id) {
    return iosDialog(
        context,
        SizedBox(
          height: 50.h,
          // width: 130.w,
          child: Column(
            // physics: const NeverScrollableScrollPhysics(),
            //shrinkWrap: true,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10).h,
              //   child: Text(
              //     'Logout',
              //     style: Styles.latoBold(context, fontSize: 22.sp),
              //   ),
              // ),
              SizedBox(
                height: 5.h,
              ),
              //Divider(color: AppColors.primaryColor,height: 2.sp,thickness: 1,),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //   SizedBox(width: 40.sp,),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        context.read<DelateAccountCubit>().deleteAccount();
                      },
                      child: CustomWidgets.customButton(
                        "Cancel",
                        buttonColor: kDescriptionColor,
                      ),
                    )),

                    SizedBox(
                      width: 5.sp,
                    ),
                    //  SizedBox(width: 10,),
                    Expanded(
                        child: InkWell(
                      onTap: () {},
                      child: CustomWidgets.customButton(
                        "Confirm",
                        buttonColor: kPrimaryColor,
                      ),
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
        'Are you sure want to delete account?');
  }

  static Future<void> uploadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Prevent the user from dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor:
              Colors.transparent, // Set the background color to transparent
          content: Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ), // Add a CircularProgressIndicator
          ),
        );
      },
    );
  }

  static Future<void> iosDialog(
      BuildContext context, Widget child, String title) async {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black12,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          content: child,
        );
      },
    );
  }

  static Future<void> dialog(BuildContext context, Widget child,
      {Alignment? alignment,
      bool? barr,
      bool? autoDismiss,
      Timer? timerDialog,
      Color? bgColor}) async {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black12,
      barrierDismissible: barr ?? true,
      builder: (BuildContext context) {
        if (autoDismiss != null) {
          timerDialog?.cancel();
          Future.delayed(const Duration(seconds: 5), () {
            // Navigator.of(buildContext).pop(); // close the dialog
            Navigator.of(context).pop(); // navigate back to the previous page
          });
        }
        return Dialog(
          insetPadding: const EdgeInsets.all(15).r,
          elevation: 0.0,
          backgroundColor: bgColor ?? Colors.white,
          alignment: alignment ?? Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10).r,
          ),
          child: child,
        );
      },
    );
  }
}
