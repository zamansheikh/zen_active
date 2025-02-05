import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_drop_down.dart';
import 'package:zen_active/views/components/custom_text_field.dart';
import 'package:zen_active/views/screen/home/mood_tracker_screen.dart';

class MoodTrackerFormScreen extends StatefulWidget {
  const MoodTrackerFormScreen({super.key});

  @override
  State<MoodTrackerFormScreen> createState() => _MoodTrackerFormScreenState();
}

class _MoodTrackerFormScreenState extends State<MoodTrackerFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              backgroundColor: AppColors.scaffoldBackgroundColor,
              title: 'Mode Tracker',
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomDropDown(
                    title: "Select your mode",
                    options: [
                      "Happy 😊",
                      "Neutral 😐",
                      "Stressed 😓",
                      "Anxious 😟",
                      "Excited 😄"
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomDropDown(
                    title: "How do you feel physically?",
                    options: [
                      "Energetic ⚡",
                      "Tired 😴",
                      "Calm 🌊",
                      "Restless 🌀",
                      "Balanced ⚖️",
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomDropDown(
                    title: "What’s your overall energy level?",
                    options: [
                      "High 🔋",
                      "Medium ⚡",
                      "Low 🌙",
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    title: "What’s bothering you right now?",
                    hintText: "Tell us more.....",
                  ),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    title: "What’s one thing you’re grateful for today?",
                    hintText: "Tell us more.....",
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                      buttonName: "Submit",
                      onPressed: () {
                        Get.to(() => MoodTrackerScreen());
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModeCard extends StatelessWidget {
  final String mode;
  final Function onShare;

  const ModeCard({super.key, required this.mode, required this.onShare});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            border: Border.all(
              color: AppColors.splashColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 14.w,
              ),
              svgViewer(
                asset: "assets/svg/mood_tracker.svg",
                height: 205.h,
                width: 205.w,
              ),
              SizedBox(
                width: 14.w,
              ),
              Text(
                mode,
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 12,
          top: 12,
          child: InkWell(
            onTap: () => onShare(),
            child: svgViewer(
                asset: "assets/svg/share.svg", height: 24.h, width: 24.w),
          ),
        ),
      ],
    );
  }
}
