import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zen_active/helpers/route.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/app_constants.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/fcustom_text_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading:
            svgViewer(asset: AppConstants.backIcon, height: 10.h, width: 10.w),
        title: Text('Forget Password'),
      ),
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

              //Forget Password
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                      color: AppColors.textColorSub,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              CustomButton(buttonName: 'Sign In', onPressed: () {}),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: AppColors.splashSubTextColor,
                      fontSize: 14.sp,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.signUpScreen);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14.sp,
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
