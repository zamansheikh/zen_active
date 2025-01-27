import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/subscription_widget.dart';
import 'package:zen_active/views/screen/Profile/current_subscription_page.dart';

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
                        onTap: () {},
                      ),
                      SubscriptionWidget(
                        title: "Monthly Subscription",
                        subTitle: "\$20/month",
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
                          Get.to(CurrentSubscriptionPage());
                        },
                      ),
                      SubscriptionWidget(
                        title: "Annual Subscription",
                        subTitle: "\$79.99/year",
                        benifits: [
                          "Everything in Monthly Plan",
                          "Save 50% with annual Plan",
                        ],
                        buttonText: "Subscribe Annually",
                        onTap: () {},
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
