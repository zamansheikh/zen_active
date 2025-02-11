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
  final bool taken;
  final bool isAdmins;
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
    required this.isAdmins,
    this.taken = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.splashColor,
          width: 0.5.w,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: 56.w, // Set the width
              height: 56.w,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 56.w,
                  height: 56.w,
                  color: Colors.grey, // You can use a random color if needed
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(foodName,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      )),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: "$kcal",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                    TextSpan(
                      text: " kcal",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  ])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("$amount bowl",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryTextColor,
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: "Carbs: ",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    TextSpan(
                      text: "${carbs}g",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                  ])),
                  Container(
                    height: 10.h,
                    width: 1.w,
                    color: Colors.grey,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: "Protein: ",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    TextSpan(
                      text: "${protein}g",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                  ])),
                  Container(
                    height: 10.h,
                    width: 1.w,
                    color: Colors.grey,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: "Fat: ",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    TextSpan(
                      text: "${fat}g",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                  ])),
                ],
              ),
            ],
          )),
          SizedBox(width: 30.w),
          if (!isAdmins)
            InkWell(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (taken)
                    svgViewer(
                      asset: 'assets/svg/checked.svg',
                    )
                  else
                    svgViewer(
                      asset: 'assets/svg/unchecked.svg',
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
