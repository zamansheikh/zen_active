import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/auth_controller.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/utils/app_constants.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/custom_otp_field.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final AuthController _authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    final String email = Get.arguments;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              backgroundColor: AppColors.backgroundColor,
              title: 'OTP Verification',
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      svgViewer(
                        asset: AppConstants.appLogo,
                        height: 100.h,
                        width: 100.w,
                      ),
                      SizedBox(height: 48.h),
                      Obx(
                        () => CustomOTPField(
                          isLoading: _authController.isLoading.value,
                          onPressed: (otp) {
                            _authController.verifyOTP(
                              email: email,
                              otp: otp,
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t get the code?',
                            style: TextStyle(
                              color: AppColors.splashSubTextColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // _authController.resendOTP(email);
                              Get.snackbar(
                                'Resend OTP',
                                'OTP has been resent to your mobile number',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppColors.splashColor,
                                colorText: Colors.white,
                              );
                            },
                            child: Text(
                              'Resend',
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
            ),
          ],
        ),
      ),
    );
  }
}
