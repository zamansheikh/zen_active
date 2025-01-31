import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/user_info_controller.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/app_constants.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_line_bar.dart';
import 'package:zen_active/views/components/custom_selection_button.dart';
import 'package:zen_active/views/screen/auth/user_info/user_info_four.dart';

class UserInfoThree extends StatefulWidget {
  const UserInfoThree({super.key});

  @override
  State<UserInfoThree> createState() => _UserInfoThreeState();
}

class _UserInfoThreeState extends State<UserInfoThree> {
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
                  'Let us know your current dietary preferences to ensure the best recommendations',
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
                  buttonName: "No Preference",
                  svgPath: AppConstants.noPrefIcon,
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: true,
                  hasIcon: true,
                  buttonName: "Vegan",
                  svgPath: AppConstants.veganIcon,
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: true,
                  hasIcon: true,
                  buttonName: "Vegetarian",
                  svgPath: AppConstants.vegitableIcon,
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  hasIcon: true,
                  buttonName: "Keto/Low Carb",
                  svgPath: AppConstants.ketoIcon,
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: true,
                  hasIcon: true,
                  buttonName: "Gluten-Free",
                  svgPath: AppConstants.glutenIcon,
                ),
                SizedBox(height: 24.h),
                CustomButton(
                    buttonName: 'Next',
                    onPressed: () {
                      controller.currentIndex.value = 3;
                      Get.to(() => UserInfoFour());
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
