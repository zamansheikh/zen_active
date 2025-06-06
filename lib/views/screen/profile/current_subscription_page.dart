import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/helpers/route.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/components/subscription_widget.dart';

class CurrentSubscriptionPage extends StatelessWidget {
  const CurrentSubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Current Subscription",
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 12,
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
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      CustomButton(
                        buttonName: "Renew",
                        onPressed: () {
                          Get.toNamed(AppRoutes.paymentMethodPage);
                        },
                      ),
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
