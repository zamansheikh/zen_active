import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/helpers/route.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_drop_down.dart';
import 'package:zen_active/views/components/custom_text_field.dart';
import 'package:zen_active/views/screen/Workout/optimize_traning_completion_page.dart';

class OptimizeTraningPage extends StatelessWidget {
  const OptimizeTraningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 24,
          children: [
            CustomAppBar(
              title: "Optimize Your Training",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                spacing: 24,
                children: [
                  CustomDropDown(
                    title: "How difficul was today's workout?",
                    hintText: "Select difficulty level",
                    options: [
                      "Easy",
                      "Hard",
                      "Very Hard",
                    ],
                  ),
                  CustomDropDown(
                    title: "Did you complete all the exercises?",
                    hintText: "Select one",
                    options: [
                      "Yes",
                      "No",
                    ],
                  ),
                  CustomTextField(
                    title: "Any specific challenges during your session?",
                    hintText: "Challenges you face...",
                    multiline: true,
                  ),
                  CustomButton(
                    buttonName: "Submit",
                    width: 145,
                    onPressed: () {
                      Get.toNamed(AppRoutes.optimizeTrainingCompletionPage);
                    },
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
