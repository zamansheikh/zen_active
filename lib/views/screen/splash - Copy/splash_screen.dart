import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zen_active/helpers/route.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/app_constants.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/screen/Splash/controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController _splashController = Get.find<SplashController>();
  int _index = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        handleRoute();
      });
    });
  }

  void handleRoute() {
    if (_splashController.isSplashPassed.value &&
        _splashController.isUserLoggedIn.value &&
        _splashController.isUserInfoCompleted.value) {
      Get.offAllNamed(AppRoutes.app);
    } else if (_splashController.isSplashPassed.value &&
        !_splashController.isUserLoggedIn.value) {
      Get.offAllNamed(AppRoutes.signInScreen);
    } else if (_splashController.isSplashPassed.value &&
        _splashController.isUserLoggedIn.value &&
        !_splashController.isUserInfoCompleted.value) {
      Get.offAllNamed(AppRoutes.userInfoStack);
    } else if (!_splashController.isSplashPassed.value &&
        !_splashController.isUserLoggedIn.value) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _index = 1;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackgrond,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: IndexedStack(
          index: _index,
          children: [
            SplashOne(
              controller: _splashController,
            ),
            SplashTwo(
              controller: _splashController,
            ),
          ],
        ),
      ),
    );
  }
}

class SplashOne extends StatelessWidget {
  final SplashController controller;
  const SplashOne({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: AlignmentDirectional(0.w, 1.3.h),
          child: Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
              color: AppColors.splashColor,
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 100.0,
            sigmaY: 100.0,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppConstants.logo,
                width: 200,
              ),
              Text(
                AppConstants.APPNAME,
                style: TextStyle(
                  color: AppColors.splashTextColor,
                  fontSize: 47,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SplashTwo extends StatelessWidget {
  final SplashController controller;
  const SplashTwo({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0.w, -0.5.h),
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: AppColors.splashColor,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 100.0,
              sigmaY: 100.0,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                svgViewer(
                  asset: AppConstants.splashImage,
                  height: 375.h,
                  width: 285.w,
                ),
                SizedBox(height: 85.h),
                Text(
                  AppConstants.SPLASH_HEADER,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.splashHeaderTextColor,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  AppConstants.SPLASH_SUB_HEADER,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.splashSubTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  buttonName: "Let's Go!",
                  onPressed: () {
                    controller.skipSplash(); // Use the controller method
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
