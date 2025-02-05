import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_drop_down.dart';
import 'package:zen_active/views/components/custom_text_field_with_button.dart';

class CalorieCalculator extends StatefulWidget {
  const CalorieCalculator({super.key});

  @override
  State<CalorieCalculator> createState() => _CalorieCalculatorState();
}

class _CalorieCalculatorState extends State<CalorieCalculator> {
  bool result = false;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              backgroundColor: AppColors.backgroundColor,
              title: 'Calorie Calculator',
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //DateSection
                  CustomDropDown(
                    title: "Select Food",
                    hintText: "Select food item",
                    options: ["Food 1", "Food 2", "Food 3"],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFieldWithButton(
                    title: "Calories",
                    hintText: "Enter calories",
                    controller: TextEditingController(),
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
                        setState(() {
                          result = true;
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),
                  if (result)
                    //Result Section
                    Container(
                      height: 114.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: AppColors.splashColor,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "CALORIES",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: AppColors.primaryTextColor,
                                  ),
                                ),
                                Text(
                                  "160",
                                  style: TextStyle(
                                      fontSize: 29.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryTextColor),
                                ),
                              ],
                            ),
                          ),
                          VerticalDivider(
                            color: AppColors.splashColor,
                            thickness: 1.5,
                            indent: 20,
                            endIndent: 20,
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "FAT",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryTextColor,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "10",
                                        style: TextStyle(
                                            fontSize: 29.sp,
                                            color: AppColors.primaryTextColor),
                                      ),
                                      TextSpan(
                                        text: "G",
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: AppColors.primaryTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          VerticalDivider(
                            color: AppColors.splashColor,
                            thickness: 1.5,
                            indent: 20,
                            endIndent: 20,
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "CARBS",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: AppColors.primaryTextColor,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "2",
                                        style: TextStyle(
                                            fontSize: 29.sp,
                                            color: AppColors.primaryTextColor),
                                      ),
                                      TextSpan(
                                        text: "G",
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            color: AppColors.primaryTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
