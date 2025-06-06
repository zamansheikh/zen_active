import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/helpers/route.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/subscription_widget.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Subscribe to Premium",
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 16,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      SubscriptionWidget(
                        title: "1 month Free Trial",
                        subTitle: "Free",
                        benifits: [
                          "Personalized meal plans",
                          "Adaptive fitness recommendations",
                          "Offline access",
                          "Premium challenges and rewards",
                        ],
                        buttonText: "Subscribe Free",
                        onTap: () {
                          Get.toNamed(AppRoutes.currentSubscriptionPage);
                        },
                      ),
                      SubscriptionWidget(
                        title: "Monthly Subscription",
                        subTitle: "\$14.99/month",
                        benifits: [
                          "Personalized meal plans",
                          "Adaptive fitness recommendations",
                          "Premium challenges and rewards",
                          "Daily Energy Expenditure Calculator",
                          "Mood Tracking",
                          "Emotional Support",
                          "Offline access",
                          "Ad-free experience",
                        ],
                        buttonText: "Subscribe Monthly",
                        isDark: true,
                        onTap: () {
                          Get.toNamed(AppRoutes.currentSubscriptionPage);
                        },
                      ),
                      SubscriptionWidget(
                        title: "Annual Subscription",
                        subTitle: "\$69.99/year",
                        benifits: [
                          "Everything in Monthly Plan",
                          "Save 50% with annual Plan",
                        ],
                        buttonText: "Subscribe Annually",
                        onTap: () {
                          Get.toNamed(AppRoutes.currentSubscriptionPage);
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
