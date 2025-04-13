import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/user_info_controller.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/components/custom_dob_field.dart';
import 'package:zenactive/views/components/custom_gender_button.dart';
import 'package:zenactive/views/components/custom_line_bar.dart';
import 'package:zenactive/views/components/custom_text_field.dart';
import 'package:zenactive/views/screen/auth/user_info/user_info_two.dart';

class UserInfoOne extends StatefulWidget {
  const UserInfoOne({super.key});

  @override
  State<UserInfoOne> createState() => _UserInfoOneState();
}

class _UserInfoOneState extends State<UserInfoOne> {
  final controller = Get.find<UserInfoController>();
  bool isMale = true;
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
                CustomTextField(
                  title: 'First Name',
                  controller: controller.firstNameController,
                ),
                SizedBox(height: 24.h),
                CustomTextField(
                    title: 'Last Name',
                    controller: controller.lastNameControler),
                SizedBox(height: 24.h),
                Obx(() {
                  return CustomDOBField(
                    title: 'Date of Birth',
                    hintText: controller.dateOfBirth.value,
                    onChanged: (formatted, actual) {
                      controller.dateOfBirth.value = formatted;
                      controller.dateTimeStr.value = actual.toIso8601String();
                      print(actual.toIso8601String());
                    },
                  );
                }),
                SizedBox(height: 24.h),
                Row(
                  spacing: 18.w,
                  children: [
                    Expanded(
                      child: CustomGenderButton(
                        isMale: true,
                        onPressed: () {
                          controller.gender.value = Gender.male
                              .toString()
                              .split('.')
                              .last
                              .capitalize!;
                          setState(() {
                            isMale = true;
                          });
                        },
                        isSecondary: !isMale,
                      ),
                    ),
                    Expanded(
                      child: CustomGenderButton(
                        isMale: false,
                        onPressed: () {
                          controller.gender.value = Gender.female
                              .toString()
                              .split('.')
                              .last
                              .capitalize!;
                          setState(() {
                            isMale = false;
                          });
                        },
                        isSecondary: isMale,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                CustomTextField(
                  title: 'Your Height (cm)',
                  controller: controller.heightController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                SizedBox(height: 24.h),
                CustomTextField(
                  title: 'Your Weight (kg)',
                  keyboardType: TextInputType.number,
                  controller: controller.weightController,
                ),
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
