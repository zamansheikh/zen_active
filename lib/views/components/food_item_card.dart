import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/uitls.dart';

class FoodItemCard extends StatelessWidget {
  final String foodName;
  final String imageUrl;
  final int kcal;
  final int carbs;
  final int protein;
  final int fat;
  final int amount;
  final Function()? onTap;
  const FoodItemCard({
    this.onTap,
    super.key,
    required this.foodName,
    required this.imageUrl,
    required this.kcal,
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 253.w,
      height: 72.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'See all',
            style: TextStyle(
              height: 1.5,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryTextColor,
            ),
          ),
          svgViewer(asset: 'assets/svg/arrow-right.svg'),
        ],
      ),
    );
  }
}
