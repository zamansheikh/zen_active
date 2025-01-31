import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/user_info_controller.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_line_bar.dart';
import 'package:zen_active/views/components/custom_selection_button.dart';
import 'package:zen_active/views/screen/auth/user_info/user_info_five.dart';

class UserInfoFour extends StatefulWidget {
  const UserInfoFour({super.key});

  @override
  State<UserInfoFour> createState() => _UserInfoFourState();
}

class _UserInfoFourState extends State<UserInfoFour> {
  final controller = Get.find<UserInfoController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 90),
                CustomLineBar(
                  selectedIndex: controller.currentIndex.value,
                ),
                SizedBox(height: 40.h),
                Text(
                  'What’s your activity level?',
                  style: TextStyle(
                    color: AppColors.splashTextColor,
                    fontSize: 29.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'This helps us tailor your fitness recommendations based on your lifestyle',
                  style: TextStyle(
                    color: AppColors.splashTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 28.h),
                CustomSelectionButton(
                  isSecondary: true,
                  hasIcon: false,
                  buttonName: "Sedentary (little to no exercise)",
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: false,
                  hasIcon: false,
                  buttonName: "Lightly Active (light exercise 1-3 days/week)",
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: true,
                  hasIcon: false,
                  buttonName: "Moderately Active (exercise 3-5 days/week)",
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: true,
                  hasIcon: false,
                  buttonName: "Very Active (hard exercise 6-7 days/week)",
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: true,
                  hasIcon: false,
                  buttonName: "Super Active (intense exercise every day)",
                ),
                SizedBox(height: 24.h),
                CustomButton(
                    buttonName: 'Next',
                    onPressed: () {
                      controller.currentIndex.value = 4;
                      Get.to(() => UserInfoFive());
                    }),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
