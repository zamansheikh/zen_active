import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/user_info_controller.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_gender_button.dart';
import 'package:zen_active/views/components/custom_line_bar.dart';
import 'package:zen_active/views/components/custom_text_field.dart';
import 'package:zen_active/views/screen/auth/user_info/user_info_two.dart';

class UserInfoOne extends StatefulWidget {
  const UserInfoOne({super.key});

  @override
  State<UserInfoOne> createState() => _UserInfoOneState();
}

class _UserInfoOneState extends State<UserInfoOne> {
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
                CustomTextField(title: 'First Name'),
                SizedBox(height: 24.h),
                CustomTextField(title: 'Last Name'),
                SizedBox(height: 24.h),
                CustomTextField(
                  title: 'Date of Birth',
                  hintText: "DD / MM / YEAR",
                ),
                SizedBox(height: 24.h),
                Row(
                  spacing: 18.w,
                  children: [
                    Expanded(
                      child: CustomGenderButton(
                        isMale: true,
                      ),
                    ),
                    Expanded(
                      child: CustomGenderButton(
                        isSecondary: true,
                        isMale: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                CustomTextField(title: 'Your Height (cm)'),
                SizedBox(height: 24.h),
                CustomTextField(title: 'Your Weight (kg)'),
                SizedBox(height: 24.h),
                CustomButton(
                    buttonName: 'Next',
                    onPressed: () {
                      controller.currentIndex.value = 1;
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
