import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/components/custom_drop_down.dart';
import 'package:zenactive/views/components/custom_text_field_with_button.dart';

class TrackWorkOutScreen extends StatefulWidget {
  const TrackWorkOutScreen({super.key});

  @override
  State<TrackWorkOutScreen> createState() => _TrackWorkOutScreenState();
}

class _TrackWorkOutScreenState extends State<TrackWorkOutScreen> {
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
              title: 'Track Workout',
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //DateSection
                  CustomDropDown(
                    title: "Workout Type",
                    hintText: "Select workout type",
                    options: [
                      "Strength Training",
                      "Cardio",
                      "Yoga",
                      "HIIT",
                      "Workout",
                      "Workout",
                      "Workout",
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFieldWithButton(
                    title: "Workout Duration",
                    hintText: "Example: 30 mins",
                    controller: TextEditingController(),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //Calculate Button
                  SizedBox(
                    width: 163.w,
                    child: CustomButton(
                      buttonName: "Start Workout",
                      onPressed: () {},
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
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
