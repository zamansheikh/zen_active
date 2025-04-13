import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/auth_controller.dart';
import 'package:zenactive/controllers/user_info_controller.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/components/custom_drop_down.dart';
import 'package:zenactive/views/components/custom_line_bar.dart';

class UserInfoFive extends StatefulWidget {
  const UserInfoFive({super.key});

  @override
  State<UserInfoFive> createState() => _UserInfoFiveState();
}

class _UserInfoFiveState extends State<UserInfoFive> {
  final controller = Get.find<UserInfoController>();
  final AuthController _authController = Get.put(AuthController());
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
                  'Help Us Understand Your Needs',
                  style: TextStyle(
                    color: AppColors.splashTextColor,
                    fontSize: 29.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Share your health and mobility details to create a workout plan that’s safe, effective, and tailored to you',
                  style: TextStyle(
                    color: AppColors.splashTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 28.h),
                CustomDropDown(
                  title: "Do you have a history of injuries?",
                  hintText: "Select an injury type",
                  options: [
                    'No Injuries',
                    'Back Pain',
                    'Knee Issues',
                    'Shoulder Injuries',
                    'Ankle Sprains',
                  ],
                  onChanged: (p0) {
                    controller.injuryController.text = p0;
                  },
                ),
                SizedBox(height: 24.h),
                CustomDropDown(
                  title: "Do you have difficulty with certain movements?",
                  hintText: "Select an movements type",
                  options: [
                    'No Difficulty',
                    'Overhead Movements',
                    'Deep Squats',
                    'Rotational Movements',
                    'Forward Bends'
                  ],
                  onChanged: (p0) {
                    controller.movementDifficultyController.text = p0;
                  },
                ),
                SizedBox(height: 24.h),
                CustomDropDown(
                  title:
                      "Do you have any medical conditions we should consider?",
                  hintText: "Select a condition",
                  options: [
                    'No Medical Conditions',
                    'Asthma',
                    'Heart Conditions',
                    'Diabetes',
                    'Arthritis',
                  ],
                  onChanged: (p0) {
                    controller.medicalConditionController.text = p0;
                  },
                ),
                SizedBox(height: 24.h),
                CustomDropDown(
                  title: "What is your occupation",
                  hintText: "Select your occupation ",
                  options: [
                    'Software Engineer 👨‍💻',
                    'Teacher 👩‍🏫',
                    'Doctor 👨‍⚕️',
                    'Chef 👨‍🍳',
                    'Photographer 📷',
                    'Entrepreneur 💼'
                  ],
                  onChanged: (p0) {
                    controller.occupationController.text = p0;
                  },
                ),
                SizedBox(height: 24.h),
                CustomButton(
                    isLoading: _authController.isLoading.value,
                    buttonName: 'Submit',
                    onPressed: () {
                      _authController.updateUserDetails();
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
