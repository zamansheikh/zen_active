import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/screen/home/calorie_calculator.dart';
import 'package:zenactive/views/screen/home/tdee_calculator_screen.dart';

class SelectCalculatorScreen extends StatefulWidget {
  const SelectCalculatorScreen({super.key});

  @override
  State<SelectCalculatorScreen> createState() => _SelectCalculatorScreenState();
}

class _SelectCalculatorScreenState extends State<SelectCalculatorScreen> {
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
              title: 'Select Calculator',
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //DateSection
                  InkWell(
                    onTap: () {
                      Get.to(() => CalorieCalculator());
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14.r),
                      // height: 79.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.splashColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        color: Color(0xffEBF8FF),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 14.w,
                          ),
                          svgViewer(
                            asset: "assets/svg/fire.svg",
                            height: 32.h,
                            width: 32.w,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            "Calorie Calculator",
                            style: TextStyle(
                              color: Color(0xff174C6B),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => TDEECalculatorScreen());
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14.r),
                      // height: 79.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.splashColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        color: Color(0xffEBF8FF),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 14.w,
                          ),
                          svgViewer(
                            asset: "assets/svg/running.svg",
                            height: 32.h,
                            width: 32.w,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            'TDEE Calculator',
                            style: TextStyle(
                              color: Color(0xff174C6B),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
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
