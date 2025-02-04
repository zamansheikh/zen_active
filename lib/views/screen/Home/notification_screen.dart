import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<String> notifications = [
    'New Meal Plan Added',
    'Workout Reminder',
    'Hydration Alert',
    'New Recipe Available',
    'Daily Motivation Quote',
  ];

  final List<bool> isCheckedList = [true, true, false, true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              backgroundColor: AppColors.backgroundColor,
              title: 'Notification',
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(notifications.length, (index) {
                  return NotificationCard(
                    title: notifications[index],
                    isChecked: isCheckedList[index],
                    onTap: () {
                      setState(() {
                        isCheckedList[index] = !isCheckedList[index];
                      });
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final bool isChecked;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.title,
    required this.isChecked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 79.h,
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          color: !isChecked ? AppColors.splashColor : Colors.transparent,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 14.w,
            ),
            Container(
              height: 50.h,
              width: 50.w,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25.r)),
                color: Color(0xffEBF8FF),
              ),
              child: svgViewer(
                asset: "assets/svg/bell.svg",
                height: 24.h,
                width: 24.w,
              ),
            ),
            SizedBox(width: 14.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isChecked
                        ? AppColors.authTitleColor
                        : AppColors.inversePrimaryTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  'Check out your personalized plan for today',
                  style: TextStyle(
                    color: isChecked
                        ? AppColors.authTitleColor
                        : AppColors.inversePrimaryTextColor,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.visible,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
