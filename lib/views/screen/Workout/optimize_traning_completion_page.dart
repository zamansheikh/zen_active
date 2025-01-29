import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';

class OptimizeTraningCompletionPage extends StatelessWidget {
  const OptimizeTraningCompletionPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Timer(const Duration(seconds: 2), () {
          Get.back();
          Get.back();
          Get.back();
          Get.back();
        });
      },
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Optimize Your Training",
            ),
            const SizedBox(
              height: 100,
            ),
            svgViewer(
              asset: "assets/svg/check.svg",
              height: 180,
              width: 180,
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Your Plan Has Been Updated!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff174C6B),
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Based on your feedback, we’ve adjusted your training. Let’s keep pushing towards your goals!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff757575),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
