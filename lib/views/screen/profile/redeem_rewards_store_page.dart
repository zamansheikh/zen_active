import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/auth_controller.dart';
import 'package:zenactive/models/reward_model.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/custom_button.dart';

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
                        Image.network(
                          imageUrl(reward.image!),
                          height: 110,
                          width: 110,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.badge,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          reward.name!,
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
                              if (Get.find<AuthController>()
                                      .user
                                      .value
                                      .userAppData!
                                      .points! >=
                                  reward.price!) {
                                Get.find<AuthController>()
                                    .buyBadge(reward: reward);
                              } else {
                                Get.snackbar(
                                    "Error", "You don't have enough points");
                              }
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
