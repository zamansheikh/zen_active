import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/auth_controller.dart';
import 'package:zenactive/helpers/route.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/utils/app_constants.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/components/fcustom_text_field.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final AuthController _authController = Get.put(AuthController());
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
                controller: _authController.emailController,
              ),
              SizedBox(height: 12.h),
              FCustomTextField(
                isPassword: true,
                hintText: 'Enter your password',
                svgIcon: AppConstants.lockIcon,
                controller: _authController.passwordController,
              ),

              //Forget Password
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.forgetPassword);
                  },
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                      color: AppColors.textColorSub,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Obx(() {
                return CustomButton(
                    buttonName: 'Sign In',
                    isLoading: _authController.isLoading.value,
                    onPressed: () async {
                      _authController.logIn(
                          email: _authController.emailController.text.trim(),
                          password: _authController.passwordController.text);
                    });
              }),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: AppColors.splashSubTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
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
