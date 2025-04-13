import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/user_info_controller.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/utils/app_constants.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/components/custom_line_bar.dart';
import 'package:zenactive/views/components/custom_selection_button.dart';
import 'package:zenactive/views/screen/auth/user_info/user_info_three.dart';

class UserInfoTwo extends StatefulWidget {
  const UserInfoTwo({super.key});

  @override
  State<UserInfoTwo> createState() => _UserInfoTwoState();
}

class _UserInfoTwoState extends State<UserInfoTwo> {
  final controller = Get.find<UserInfoController>();
  void updateGoal(String goal) {
    controller.primaryGoalController.text = goal;
    goals.forEach((key, value) {
      if (key != goal) {
        goals[key] = false;
      } else {
        goals[key] = true;
      }
    });
  }

  Map<String, bool> goals = {
    'Build Muscle': false,
    'Lose Weight': false,
    'Improve Endurance': false,
    'Increase Flexibility': false,
    'Boost Energy': false,
    'Enhance Mental Health': false,
    'Gain Weight': false,
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
                  'What are your primary fitness goals?',
                  style: TextStyle(
                    color: AppColors.splashTextColor,
                    fontSize: 29.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'To personalize your experience, choose up to 3 goals that matter most to you',
                  style: TextStyle(
                    color: AppColors.splashTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 28.h),
                CustomSelectionButton(
                  isSecondary: !goals['Build Muscle']!,
                  hasIcon: true,
                  onPressed: () {
                    setState(() {
                      updateGoal('Build Muscle');
                    });
                  },
                  buttonName: "Build Muscle",
                  svgPath: AppConstants.gymIcon,
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: !goals['Lose Weight']!,
                  hasIcon: true,
                  buttonName: 'Lose Weight',
                  svgPath: AppConstants.downloadIcon,
                  onPressed: () {
                    setState(() {
                      updateGoal('Lose Weight');
                    });
                  },
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: !goals['Improve Endurance']!,
                  hasIcon: true,
                  buttonName: "Improve Endurance",
                  svgPath: AppConstants.walkIcon,
                  onPressed: () {
                    setState(() {
                      updateGoal('Improve Endurance');
                    });
                  },
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: !goals['Increase Flexibility']!,
                  hasIcon: true,
                  buttonName: "Increase Flexibility",
                  svgPath: AppConstants.walkWithStyle,
                  onPressed: () {
                    setState(() {
                      updateGoal('Increase Flexibility');
                    });
                  },
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  hasIcon: true,
                  buttonName: "Boost Energy",
                  isSecondary: !goals['Boost Energy']!,
                  svgPath: AppConstants.boostIcon,
                  onPressed: () {
                    setState(() {
                      updateGoal('Boost Energy');
                    });
                  },
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: !goals['Enhance Mental Health']!,
                  hasIcon: true,
                  buttonName: "Enhance Mental Health",
                  svgPath: AppConstants.maditationIcon,
                  onPressed: () {
                    setState(() {
                      updateGoal('Enhance Mental Health');
                    });
                  },
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: !goals['Gain Weight']!,
                  hasIcon: true,
                  buttonName: "Gain Weight",
                  svgPath: AppConstants.uploadIcon,
                  onPressed: () {
                    setState(() {
                      updateGoal('Gain Weight');
                    });
                  },
                ),
                SizedBox(height: 24.h),
                CustomButton(
                    buttonName: 'Next',
                    onPressed: () {
                      controller.currentIndex.value = 2;
                      Get.to(() => UserInfoThree());
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
