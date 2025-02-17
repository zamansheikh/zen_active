import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_drop_down.dart';
import 'package:zen_active/views/components/custom_gender_button.dart';
import 'package:zen_active/views/components/custom_text_field.dart';
import 'package:zen_active/views/screen/home/tdee_calulator_result_screen.dart';

class TDEECalculatorScreen extends StatefulWidget {
  const TDEECalculatorScreen({super.key});

  @override
  State<TDEECalculatorScreen> createState() => _TDEECalculatorScreenState();
}

class _TDEECalculatorScreenState extends State<TDEECalculatorScreen> {
  bool isChecked = false;
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String? selectedGender;
  String? selectedActivityLevel;
  String? selectedPrimaryGoal;

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
                    CustomTextField(
                        title: "Age",
                        hintText: "Enter your age",
                        keyboardType: TextInputType.number,
                        controller: ageController),
                    SizedBox(height: 20.h),
                    CustomTextField(
                        title: "Height(cm)",
                        hintText: "Enter height",
                        keyboardType: TextInputType.number,
                        controller: heightController),
                    SizedBox(height: 20.h),
                    CustomTextField(
                        title: "Weight(kg)",
                        hintText: "Enter weight",
                        keyboardType: TextInputType.number,
                        controller: weightController),
                    SizedBox(height: 20.h),
                    Row(
                      spacing: 18.w,
                      children: [
                        Expanded(
                          child: CustomGenderButton(
                            isMale: true,
                            isSecondary: selectedGender != "Male",
                            onPressed: () {
                              setState(() {
                                selectedGender = "Male";
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomGenderButton(
                            isMale: false,
                            isSecondary: selectedGender != "Female",
                            onPressed: () {
                              setState(() {
                                selectedGender = "Female";
                              });
                            },
                          ),
                        ),
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
                      onChanged: (value) {
                        setState(() {
                          selectedActivityLevel = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomDropDown(
                      title: "Primary Goal",
                      hintText: "Select one",
                      options: [
                        "Lose Weight",
                        "Build Muscle",
                        "Gain Weight",
                        "Improve Endurance",
                        "Increase Flexibility",
                        "Boost Energy",
                        "Enhance Mental health"
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedPrimaryGoal = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.h),
                    //Calculate Button
                    SizedBox(
                      width: 163.w,
                      child: CustomButton(
                        buttonName: "Calculate",
                        onPressed: () {
                          if (ageController.text.isNotEmpty &&
                              heightController.text.isNotEmpty &&
                              weightController.text.isNotEmpty &&
                              selectedGender != null &&
                              selectedActivityLevel != null &&
                              selectedPrimaryGoal != null) {
                            try {
                              int weight = int.parse(weightController.text);
                              int height = int.parse(heightController.text);
                              int age = int.parse(ageController.text);
                              DateTime dateOfBirth = DateTime.now()
                                  .subtract(Duration(days: age * 365));

                              double tdee = calculateTDEE(
                                weight: weight,
                                height: height,
                                dateOfBirth: dateOfBirth,
                                gender: selectedGender!,
                                activityLevel: selectedActivityLevel!,
                                primaryGoal: selectedPrimaryGoal!,
                              );

                              Get.to(() =>
                                  TDEECalculationResultScreen(tdee: tdee));
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
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

double calculateTDEE({
  required int weight,
  required int height,
  required DateTime dateOfBirth,
  required String gender,
  required String activityLevel,
  required String primaryGoal,
}) {
  // Calculate age
  int age = DateTime.now().year - dateOfBirth.year;

  // Calculate BMR using the Mifflin-St Jeor equation
  double bmr;
  if (gender == "Male") {
    bmr = 10 * weight + 6.25 * height - 5 * age + 5;
  } else {
    bmr = 10 * weight + 6.25 * height - 5 * age - 161;
  }

  // Activity multiplier based on the activityLevel string
  double activityMultiplier;
  switch (activityLevel) {
    case "Lightly Active (light exercise 1-3 days/week)":
      activityMultiplier = 1.375;
      break;
    case "Moderately Active (exercise 3-5 days/week)":
      activityMultiplier = 1.55;
      break;
    case "Very Active (hard exercise 6-7 days/week)":
      activityMultiplier = 1.725;
      break;
    case "Super Active (intense exercise every day)":
      activityMultiplier = 1.9;
      break;
    default:
      activityMultiplier = 1.2; // Default to Sedentary (little to no exercise)
  }

  // Calculate TDEE
  double tdee = bmr * activityMultiplier;

  // Adjust for primary goal
  double adjustedTDEE = tdee;
  switch (primaryGoal) {
    case "Lose Weight":
      adjustedTDEE -= 500; // Subtract 500 calories for weight loss
      break;
    case "Build Muscle":
    case "Gain Weight":
      adjustedTDEE += 500; // Add 500 calories for muscle gain or weight gain
      break;
    case "Improve Endurance":
      adjustedTDEE += 200; // Add 200 calories for endurance improvement
      break;
    case "Increase Flexibility":
      adjustedTDEE += 100; // Add 100 calories for flexibility
      break;
    case "Boost Energy":
      adjustedTDEE += 150; // Add 150 calories for energy
      break;
    case "Enhance Mental health":
      adjustedTDEE += 100; // Add 100 calories for mental well-being
      break;
    default:
      // No adjustment if goal is not recognized
      break;
  }

  return adjustedTDEE;
}
