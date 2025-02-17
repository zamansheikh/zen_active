import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';

class TDEECalculationResultScreen extends StatelessWidget {
  final double tdee;

  const TDEECalculationResultScreen({super.key, required this.tdee});

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Maintenance Calorie",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ), //2,346 Calories/day
                    RichText(
                      text: TextSpan(
                        text: "${tdee.toStringAsFixed(2)} ",
                        style: TextStyle(
                          fontSize: 41.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2781B5),
                        ),
                        children: [
                          TextSpan(
                            text: "Calories/day",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryTextColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50.h),
                    TDEEResultCell(
                        title: "Energy intake to lose weight",
                        value: (tdee - 500).toStringAsFixed(2)),
                    SizedBox(height: 20.h),
                    TDEEResultCell(
                        title: "Energy intake to gain weight",
                        value: (tdee + 500).toStringAsFixed(2)),
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

class TDEEResultCell extends StatelessWidget {
  final String title;
  final String value;
  const TDEEResultCell({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff2d2d2d),
            )),
        const SizedBox(
          height: 6,
        ),
        Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: 52,
          ),
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Color(0xfffefeff),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1.0,
              color: Color(
                0xff79CDFF,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: RichText(
                text: TextSpan(
              text: "$value ",
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xff2d2d2d),
              ),
              children: [
                TextSpan(
                  text: "Calories/day",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryTextColor,
                  ),
                ),
              ],
            )),
          ),
        ),
      ],
    );
  }
}
