import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_system/Presentation/common/resources/loading_dialog.dart';
import 'package:school_system/Presentation/utils/colors.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class ShowFile extends StatelessWidget {
  final String url; // The URL of the file you want to display.
  ShowFile({super.key, required this.url});

  ValueNotifier<bool> loading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          WebViewPlus(
            backgroundColor: Colors.white,
            onPageStarted: (p) {
              loading.value = true;
            },
            onPageFinished: (url) async {
              //  var currentUrl = await controller.webViewController.currentUrl();
              //  context.read<LoadingWebCubit>().loadingWeb(false);
              Future.delayed(const Duration(seconds: 20), () {
                loading.value = false;
              });
            },
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) async {
              log("testing url $url");
              controller.loadUrl(url);
              var currentUrl = await controller.webViewController.currentUrl();
              log("current url $currentUrl");
            },
          ),
          ValueListenableBuilder(
              valueListenable: loading,
              builder: (context, bool isLoading, Widget? child) {
                print(isLoading);

                return isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ))
                    : const Stack();
              }),
          Positioned(
            top: 15.sp,
            left: 5.sp,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: 30.r,
                color: Colors.black,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
