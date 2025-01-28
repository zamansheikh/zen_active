import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/app_constants.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/fcustom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              svgViewer(
                  asset: AppConstants.appLogo, height: 100.h, width: 100.w),
              SizedBox(height: 40.h),
              FCustomTextField(
                hintText: 'Enter your email',
                svgIcon: AppConstants.mailIcon,
              ),
              SizedBox(height: 12.h),
              FCustomTextField(
                isPassword: true,
                hintText: 'Enter your password',
                svgIcon: AppConstants.lockIcon,
              ),
              SizedBox(height: 12.h),
              FCustomTextField(
                isPassword: true,
                hintText: 'Re-enter your password',
                svgIcon: AppConstants.lockIcon,
              ),
              SizedBox(height: 20.h),
              CustomButton(buttonName: 'Sign Up', onPressed: () {}),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: AppColors.splashSubTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
