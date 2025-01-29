import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/user_info_controller.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/app_constants.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_line_bar.dart';
import 'package:zen_active/views/components/custom_selection_button.dart';

class UserInfoTwo extends StatefulWidget {
  const UserInfoTwo({super.key});

  @override
  State<UserInfoTwo> createState() => _UserInfoTwoState();
}

class _UserInfoTwoState extends State<UserInfoTwo> {
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
                  'Tell us about yourself',
                  style: TextStyle(
                    color: AppColors.splashTextColor,
                    fontSize: 29.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'We’ll use this information to calculate your fitness and nutritional needs',
                  style: TextStyle(
                    color: AppColors.splashTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 28.h),
                CustomSelectionButton(
                  // isSecondary: true,
                  hasIcon: true,
                  buttonName: "Build Muscle",
                  svgPath: AppConstants.gymIcon,
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: true,
                  hasIcon: true,
                  buttonName: "Loose Weight",
                  svgPath: AppConstants.downloadIcon,
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: true,
                  hasIcon: true,
                  buttonName: "Improve Endurance",
                  svgPath: AppConstants.walkIcon,
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: true,
                  hasIcon: true,
                  buttonName: "Increase Flexibility",
                  svgPath: AppConstants.boostIcon,
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  hasIcon: true,
                  buttonName: "Boost Energy",
                  svgPath: AppConstants.boostIcon,
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: true,
                  hasIcon: true,
                  buttonName: "Enhance Mental Health",
                  svgPath: AppConstants.boostIcon,
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: true,
                  hasIcon: true,
                  buttonName: "Gain Weight",
                  svgPath: AppConstants.boostIcon,
                ),
                SizedBox(height: 24.h),
                CustomButton(
                    buttonName: 'Next',
                    onPressed: () {
                      Get.to(() => UserInfoTwo());
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
