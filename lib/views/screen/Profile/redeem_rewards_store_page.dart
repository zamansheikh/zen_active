import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/models/reward_model.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/screen/Profile/reward_confirmation_page.dart';

class RedeemRewardsStorePage extends StatelessWidget {
  final RewardModel reward;
  const RedeemRewardsStorePage({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: CustomAppBar(
              title: "Rewards Store",
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffEBF8FF),
                      border: Border.all(
                        color: Color(0xff37B5FF),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        svgViewer(
                          asset: reward.iconPath,
                          height: 110,
                          width: 110,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          reward.name,
                          style: TextStyle(
                              fontSize: 29,
                              color: Color(0xff4B4B4B),
                              fontWeight: FontWeight.w600,
                              height: 1),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Points: ",
                              style: TextStyle(
                                color: Color(0xff4B4B4B),
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                            Text(
                              reward.price.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 32,
                                color: Color(0xff1E648C),
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 4,
                          ),
                          child: CustomButton(
                            buttonName: "Redeem Badge",
                            textSize: 16,
                            width: 172,
                            height: 43,
                            onPressed: () {
                              Get.to(RewardConfirmationPage(reward: reward));
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
