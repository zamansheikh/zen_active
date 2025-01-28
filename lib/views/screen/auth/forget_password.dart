import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zen_active/helpers/route.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/app_constants.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/fcustom_text_field.dart';
import 'package:zen_active/views/screen/auth/otp_verify_screen.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              backgroundColor: AppColors.backgroundColor,
              title: 'Forget Password',
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  svgViewer(
                    asset: AppConstants.appLogo,
                    height: 100.h,
                    width: 100.w,
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    'Forgot your password?',
                    style: TextStyle(
                      color: AppColors.authTitleColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 29.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Please enter your email address to reset your password.',
                    style: TextStyle(
                      color: AppColors.authSubtitleColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  FCustomTextField(
                    hintText: 'Enter your email',
                    svgIcon: AppConstants.mailIcon,
                  ),
                  SizedBox(height: 24.h),
                  CustomButton(
                      buttonName: 'Send OTP',
                      onPressed: () {
                        Get.to(() => OtpVerifyScreen());
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
