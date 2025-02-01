import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/app_constants.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/fcustom_text_field.dart';
import 'package:zen_active/views/screen/Home/select_calculator_screen.dart';
import 'package:zen_active/views/screen/auth/otp_verify_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
              title: 'Notification',
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //DateSection
                  InkWell(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                        Get.to(SelectCalculatorScreen());
                      });
                    },
                    child: Container(
                      height: 79.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        color: !isChecked
                            ? AppColors.splashColor
                            : Colors.transparent,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.r)),
                                color: Color(0xffEBF8FF),
                              ),
                              child: svgViewer(
                                asset: "assets/svg/bell.svg",
                                height: 24.h,
                                width: 24.w,
                              )),
                          SizedBox(width: 14.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'New Meal Plan Added',
                                style: TextStyle(
                                  color: isChecked
                                      ? AppColors.authTitleColor
                                      : AppColors.inversePrimaryTextColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Text(
                                'Check out your personalized dinner plan for today',
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
