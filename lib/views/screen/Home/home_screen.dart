import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/app_constants.dart';
import 'package:zen_active/utils/uitls.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Hello, ',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryTextColor,
                          ),
                          children: [
                            TextSpan(
                              text: 'Arlene',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Ready to conquer today',
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: svgViewer(asset: 'assets/svg/gemini.svg'),
                  ),
                  SizedBox(width: 12.w),
                  InkWell(
                    onTap: () {},
                    child: svgViewer(asset: 'assets/svg/bell.svg'),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 0.5.w,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                svgViewer(asset: 'assets/svg/fire-flame.svg'),
                                SizedBox(width: 4.w),
                                Text(
                                  'Calorie Intake',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryTextColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 7.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                  text: '350',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryTextColor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '/1,800kcal',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secondaryTextColor,
                                      ),
                                    ),
                                  ],
                                )),
                                MediaQuery.removePadding(
                                  context: context,
                                  child: CircularPercentIndicator(
                                      radius: 15.r,
                                      lineWidth: 4.0,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      percent: 0.25,
                                      progressColor: AppColors.splashColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 18.w),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 0.5.w,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                svgViewer(asset: 'assets/svg/timer.svg'),
                                SizedBox(width: 4.w),
                                Text(
                                  'Workout Time',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryTextColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 7.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                  text: '1h 30m',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryTextColor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' / 2h',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secondaryTextColor,
                                      ),
                                    ),
                                  ],
                                )),
                                MediaQuery.removePadding(
                                  context: context,
                                  child: CircularPercentIndicator(
                                      radius: 15.r,
                                      lineWidth: 4.0,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      percent: 0.75,
                                      progressColor: AppColors.splashColor),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                spacing: 18.w,
                children: [
                  Expanded(
                    child: FeatureButton(
                      svgAsset: 'assets/svg/boost.svg',
                      title: 'Count Calorie',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: FeatureButton(
                      svgAsset: 'assets/svg/workouts.svg',
                      title: 'Track Workout',
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: FeatureButton(
                      svgAsset: 'assets/svg/senti.svg',
                      title: 'Track Mood',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              //Today Workout --- see all
              SectionDev(
                sectionName: 'Today Workout',
              ),
              SizedBox(height: 12.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (index) {
                    return Container(
                      width: 120.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 8.h),
                          Text(
                            'Running',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SectionDev(
                sectionName: 'Today Meal',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SectionDev extends StatelessWidget {
  final String sectionName;
  const SectionDev({
    required this.sectionName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          sectionName,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryTextColor,
          ),
        ),
        Spacer(),
        InkWell(
          onTap: () {},
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
        ),
      ],
    );
  }
}

class FeatureButton extends StatelessWidget {
  final String svgAsset;
  final Function()? onTap;
  final String title;
  const FeatureButton({
    super.key,
    required this.svgAsset,
    this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: Color(0xFFC1E8FF),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svgViewer(
              asset: svgAsset,
              width: 24.w,
              height: 24.h,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
