import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/models/reward_model.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/screen/Profile/redeem_rewards_store_page.dart';

class RewardsStorePage extends StatelessWidget {
  const RewardsStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<RewardModel> list = [
      RewardModel(
        name: "Golden Strider",
        iconPath: "assets/svg/rewards/golden_strider.svg",
        price: 200,
      ),
      RewardModel(
        name: "Peak Performer",
        iconPath: "assets/svg/rewards/peak_performer.svg",
        price: 250,
      ),
      RewardModel(
        name: "Mindful Master",
        iconPath: "assets/svg/rewards/mindful_master.svg",
        price: 300,
      ),
      RewardModel(
        name: "Iron Resolve",
        iconPath: "assets/svg/rewards/iron_resolve.svg",
        price: 350,
      ),
      RewardModel(
        name: "Consistency King",
        iconPath: "assets/svg/rewards/consistency_king.svg",
        price: 400,
      ),
      RewardModel(
        name: "Step Conqueror",
        iconPath: "assets/svg/rewards/step_conqueror.svg",
        price: 450,
      ),
      RewardModel(
        name: "Trailblazer",
        iconPath: "assets/svg/rewards/trailblazer.svg",
        price: 500,
      ),
      RewardModel(
        name: "Marathoner Medal",
        iconPath: "assets/svg/rewards/marathoner_medal.svg",
        price: 550,
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Rewards Store",
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 92,
                      width: 228,
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xfffefeff),
                        border: Border.all(
                          color: Color(0xff5FC4FF),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "You have",
                              style: TextStyle(
                                color: Color(0xff3A3A3A),
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                height: 1,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Text(
                                "2,346",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 41,
                                  height: 1,
                                  color: Color(0xff2781b5),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "points",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff3A3A3A),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xfffefeff),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              for (int index = 0; index < list.length; index++)
                                GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      RedeemRewardsStorePage(
                                        reward: list[index],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 84,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: index == list.length - 1
                                              ? 0
                                              : 0.5,
                                          color: Color(0xff79CDFF),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        svgViewer(
                                          asset: list[index].iconPath,
                                          height: 52,
                                          width: 52,
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          list[index].name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Color(0xff4B4B4B),
                                            height: 1,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          list[index].price.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            color: Color(0xff1E648C),
                                            height: 1,
                                          ),
                                        ),
                                        Text(
                                          " points",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Color(0xff757575),
                                            height: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
