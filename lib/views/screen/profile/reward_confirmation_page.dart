import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/models/reward_model.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_button.dart';

class RewardConfirmationPage extends StatelessWidget {
  final RewardModel reward;
  const RewardConfirmationPage({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffefeff),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svgViewer(
              asset: "assets/svg/congrats.svg",
              height: 246,
            ),
            const SizedBox(height: 20),
            Text(
              "Congratulations!",
              style: TextStyle(
                fontSize: 29,
                color: Color(0xff3A3A3A),
                fontWeight: FontWeight.w600,
                height: 1,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
              ),
              child: Text(
                "Congratulations! 🎉 You’ve unlocked the ${reward.name} badge! Wear it proudly and show off your amazing achievement. Keep up the great work!",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff525252),
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            CustomButton(
              buttonName: "Back to Dashboard",
              textSize: 16,
              width: 170,
              onPressed: () {
                Get.back();
                Get.back();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
