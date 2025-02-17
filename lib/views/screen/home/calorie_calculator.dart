import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/home_controller.dart';
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
  final HomeController homeController = Get.find<HomeController>();
  bool result = false;
  bool isChecked = false;
  int calories = 0;
  int fat = 0;
  int carbs = 0;

  List<String> foodItems = [];
  String? selectedFoodItem;
  TextEditingController quantityController = TextEditingController();
  @override
  void initState() {
    for (var element in homeController.adminsMealPlans) {
      foodItems.add(element.mealName!);
    }
    super.initState();
  }

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
                    options: foodItems,
                    onChanged: (p0) {
                      setState(() {
                        selectedFoodItem = p0;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFieldWithButton(
                    title: "Quantity",
                    hintText: "Enter quantity",
                    controller: quantityController,
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
                          if (selectedFoodItem != null &&
                              quantityController.text.isNotEmpty) {
                            try {
                              int quantity = int.parse(quantityController.text);
                              for (var element
                                  in homeController.adminsMealPlans) {
                                if (element.mealName == selectedFoodItem) {
                                  calories =
                                      element.nutritionalInfo!.calories! *
                                          quantity;
                                  fat =
                                      element.nutritionalInfo!.fats! * quantity;
                                  carbs = element.nutritionalInfo!.carbs! *
                                      quantity;
                                  result = true;
                                }
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
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
                                  calories.toString(),
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
                                        text: fat.toString(),
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
                                        text: carbs.toString(),
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
