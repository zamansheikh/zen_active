import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/auth_controller.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/utils/app_constants.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/components/fcustom_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final AuthController _authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              backgroundColor: AppColors.backgroundColor,
              title: 'Reset Password',
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  svgViewer(
                      asset: AppConstants.appLogo, height: 100.h, width: 100.w),
                  SizedBox(height: 40.h),
                  FCustomTextField(
                    isPassword: true,
                    hintText: 'Enter your password',
                    svgIcon: AppConstants.lockIcon,
                  ),
                  SizedBox(height: 12.h),
                  FCustomTextField(
                    isPassword: true,
                    hintText: 'Re-Enter your password',
                    svgIcon: AppConstants.lockIcon,
                  ),
                  SizedBox(height: 12.h),
                  Obx(() {
                    return CustomButton(
                        buttonName: 'Confirm',
                        isLoading: _authController.isLoading.value,
                        onPressed: () {
                          _authController.logIn(
                              email: 'test@gmail  .com', password: '123456');
                        });
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
