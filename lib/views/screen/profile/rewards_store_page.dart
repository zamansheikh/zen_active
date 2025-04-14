import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/auth_controller.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/custom_loading.dart';
import 'package:zenactive/views/screen/profile/redeem_rewards_store_page.dart';

class RewardsStorePage extends StatefulWidget {
  const RewardsStorePage({super.key});

  @override
  State<RewardsStorePage> createState() => _RewardsStorePageState();
}

class _RewardsStorePageState extends State<RewardsStorePage> {
  final AuthController authController = Get.find<AuthController>();
  @override
  void initState() {
    //Add Post Frame Callback
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authController.getAlluserBadges();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Rewards Store",
            ),
            authController.isLoading.value
                ? const Center(
                    child: CustomLoading(),
                  )
                : Expanded(
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
                                      authController.user.value.userBadgeData ==
                                              null
                                          ? "0"
                                          : authController
                                              .user.value.userBadgeData!.points
                                              .toString(),
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
                          Obx(() {
                            return Expanded(
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
                                      for (int index = 0;
                                          index < authController.badges.length;
                                          index++)
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              RedeemRewardsStorePage(
                                                reward: authController
                                                    .badges[index],
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 84,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  width: index ==
                                                          authController.badges
                                                                  .length -
                                                              1
                                                      ? 0
                                                      : 0.5,
                                                  color: Color(0xff79CDFF),
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Image.network(
                                                  imageUrl(authController
                                                      .badges[index].image!),
                                                  height: 52,
                                                  width: 52,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Container(
                                                      height: 52,
                                                      width: 52,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                      ),
                                                    );
                                                  },
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  authController
                                                      .badges[index].name!,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    color: Color(0xff4B4B4B),
                                                    height: 1,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  authController
                                                      .badges[index].price
                                                      .toString(),
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
                            );
                          }),
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
