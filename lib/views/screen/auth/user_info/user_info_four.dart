import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/user_info_controller.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/components/custom_line_bar.dart';
import 'package:zenactive/views/components/custom_selection_button.dart';
import 'package:zenactive/views/screen/auth/user_info/user_info_five.dart';

class UserInfoFour extends StatefulWidget {
  const UserInfoFour({super.key});

  @override
  State<UserInfoFour> createState() => _UserInfoFourState();
}

class _UserInfoFourState extends State<UserInfoFour> {
  final controller = Get.find<UserInfoController>();
  void updateActivityLevel(String activityLevel) {
    controller.activityLevelController.text = activityLevel;
    activityLevels.forEach((key, value) {
      if (key != activityLevel) {
        activityLevels[key] = false;
      } else {
        activityLevels[key] = true;
      }
    });
  }

  Map<String, bool> activityLevels = {
    'Sedentary (little to no exercise)': false,
    'Lightly Active (light exercise 1-3 days/week)': false,
    'Moderately Active (exercise 3-5 days/week)': false,
    'Very Active (hard exercise 6-7 days/week)': false,
    'Super Active (intense exercise every day)': false,
  };
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
                  isSecondary:
                      !activityLevels['Sedentary (little to no exercise)']!,
                  hasIcon: false,
                  buttonName: "Sedentary (little to no exercise)",
                  onPressed: () {
                    setState(() {
                      updateActivityLevel('Sedentary (little to no exercise)');
                    });
                  },
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: !activityLevels[
                      'Lightly Active (light exercise 1-3 days/week)']!,
                  hasIcon: false,
                  buttonName: "Lightly Active (light exercise 1-3 days/week)",
                  onPressed: () {
                    setState(() {
                      updateActivityLevel(
                          'Lightly Active (light exercise 1-3 days/week)');
                    });
                  },
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: !activityLevels[
                      'Moderately Active (exercise 3-5 days/week)']!,
                  hasIcon: false,
                  buttonName: "Moderately Active (exercise 3-5 days/week)",
                  onPressed: () {
                    setState(() {
                      updateActivityLevel(
                          'Moderately Active (exercise 3-5 days/week)');
                    });
                  },
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: !activityLevels[
                      'Very Active (hard exercise 6-7 days/week)']!,
                  hasIcon: false,
                  buttonName: "Very Active (hard exercise 6-7 days/week)",
                  onPressed: () {
                    setState(() {
                      updateActivityLevel(
                          'Very Active (hard exercise 6-7 days/week)');
                    });
                  },
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: !activityLevels[
                      'Super Active (intense exercise every day)']!,
                  hasIcon: false,
                  buttonName: "Super Active (intense exercise every day)",
                  onPressed: () {
                    setState(() {
                      updateActivityLevel(
                          'Super Active (intense exercise every day)');
                    });
                  },
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
