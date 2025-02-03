import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_drop_down.dart';
import 'package:zen_active/views/components/custom_gender_button.dart';
import 'package:zen_active/views/components/custom_text_field.dart';
import 'package:zen_active/views/screen/Home/tdee_calulator_result_screen.dart';

class TDEECalculatorScreen extends StatefulWidget {
  const TDEECalculatorScreen({super.key});

  @override
  State<TDEECalculatorScreen> createState() => _TDEECalculatorScreenState();
}

class _TDEECalculatorScreenState extends State<TDEECalculatorScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                backgroundColor: AppColors.backgroundColor,
                title: 'TDEE Calculator',
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(title: "Age", hintText: "Enter your age"),
                    SizedBox(height: 20.h),
                    CustomTextField(
                        title: "Height(cm)", hintText: "Enter height"),
                    SizedBox(height: 20.h),
                    CustomTextField(
                        title: "Weight(kg)", hintText: "Enter weight"),
                    SizedBox(height: 20.h),
                    Row(
                      spacing: 18.w,
                      children: [
                        Expanded(
                            child: CustomGenderButton(
                                isMale: true, isSecondary: true)),
                        Expanded(child: CustomGenderButton(isMale: false)),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    CustomDropDown(
                      title: "Activity",
                      hintText: "Select one",
                      options: [
                        'Sedentary (little to no exercise)',
                        'Lightly Active (light exercise 1-3 days/week)',
                        'Moderately Active (exercise 3-5 days/week)',
                        'Very Active (hard exercise 6-7 days/week)',
                        'Super Active (intense exercise every day)',
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    //Calculate Button
                    SizedBox(
                      width: 163.w,
                      child: CustomButton(
                          buttonName: "Calculate",
                          onPressed: () {
                            Get.to(() => TDEECalculationResultScreen());
                          }),
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
