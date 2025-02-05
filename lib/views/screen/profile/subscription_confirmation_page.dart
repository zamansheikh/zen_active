import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/screen/app.dart';

class SubscriptionConfirmationPage extends StatelessWidget {
  const SubscriptionConfirmationPage({super.key});

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
                "You have successfully purchased the Package. Now you can enjoy it over offline from my music tab, anytime anywhere.",
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
                Get.offUntil(
                  MaterialPageRoute(builder: (_) => App()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
