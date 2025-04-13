import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/user_info_controller.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/utils/app_constants.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/components/custom_line_bar.dart';
import 'package:zenactive/views/components/custom_selection_button.dart';
import 'package:zenactive/views/screen/auth/user_info/user_info_four.dart';

class UserInfoThree extends StatefulWidget {
  const UserInfoThree({super.key});

  @override
  State<UserInfoThree> createState() => _UserInfoThreeState();
}

class _UserInfoThreeState extends State<UserInfoThree> {
  final controller = Get.find<UserInfoController>();
  void updateDiet(String diet) {
    controller.dietController.text = diet;
    diets.forEach((key, value) {
      if (key != diet) {
        diets[key] = false;
      } else {
        diets[key] = true;
      }
    });
  }

  Map<String, bool> diets = {
    'No Preference': false,
    'Vegan': false,
    'Vegetarian': false,
    'Keto/Low Carb': false,
    'Gluten-Free': false,
  };
  void updateRestriction(String restriction) {
    controller.restrictinController.text = restriction;
    restrictions.forEach((key, value) {
      if (key != restriction) {
        restrictions[key] = false;
      } else {
        restrictions[key] = true;
      }
    });
  }

  Map<String, bool> restrictions = {
    'Gluten-Free': false,
    'Nut-Free': false,
    'Dairy-Free': false,
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
                  isSecondary: !diets['No Preference']!,
                  hasIcon: true,
                  buttonName: "No Preference",
                  svgPath: AppConstants.noPrefIcon,
                  onPressed: () {
                    setState(() {
                      updateDiet('No Preference');
                    });
                  },
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: !diets['Vegan']!,
                  hasIcon: true,
                  buttonName: "Vegan",
                  svgPath: AppConstants.veganIcon,
                  onPressed: () {
                    setState(() {
                      updateDiet('Vegan');
                    });
                  },
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: !diets['Vegetarian']!,
                  hasIcon: true,
                  buttonName: "Vegetarian",
                  svgPath: AppConstants.vegitableIcon,
                  onPressed: () {
                    setState(() {
                      updateDiet('Vegetarian');
                    });
                  },
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: !diets['Keto/Low Carb']!,
                  hasIcon: true,
                  buttonName: "Keto/Low Carb",
                  svgPath: AppConstants.ketoIcon,
                  onPressed: () {
                    setState(() {
                      updateDiet('Keto/Low Carb');
                    });
                  },
                ),
                SizedBox(height: 24.h),
                Text(
                  'Allergies & Restrictions',
                  style: TextStyle(
                    color: AppColors.splashTextColor,
                    fontSize: 29.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Let us know if you have allergies to ensure the best recommendations',
                  style: TextStyle(
                    color: AppColors.splashTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: !restrictions['Gluten-Free']!,
                  hasIcon: true,
                  buttonName: "Gluten-Free",
                  svgPath: AppConstants.glutenIcon,
                  onPressed: () {
                    setState(() {
                      updateRestriction('Gluten-Free');
                    });
                  },
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: !restrictions['Nut-Free']!,
                  hasIcon: true,
                  buttonName: "Nut-Free",
                  svgPath: "assets/svg/nut_free.svg",
                  onPressed: () {
                    setState(() {
                      updateRestriction('Nut-Free');
                    });
                  },
                ),
                SizedBox(height: 24.h),
                CustomSelectionButton(
                  isSecondary: !restrictions['Dairy-Free']!,
                  hasIcon: true,
                  buttonName: "Dairy-Free",
                  svgPath: "assets/svg/dairy_free.svg",
                  onPressed: () {
                    setState(() {
                      updateRestriction('Dairy-Free');
                    });
                  },
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
