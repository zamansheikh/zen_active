import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/helpers/route.dart';
import 'package:zen_active/models/reward_model.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/prefs_helper.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_button.dart';

class ProfilePage extends StatelessWidget {
  final RewardModel? reward;
  const ProfilePage({
    super.key,
    this.reward,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "assets/images/user.png",
                      width: 140,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (reward != null)
                    Positioned(
                      bottom: -10,
                      left: reward!.isCentered ? 0 : null,
                      right: reward!.isCentered ? 0 : -10,
                      child: svgViewer(
                        asset: reward!.iconPath,
                        height: 52,
                        width: 52,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 29,
              ),
              Text(
                "Arlene Flores",
                style: kTextStyle.copyWith(
                  fontSize: 26,
                  color: Color(0xff3a3a3a),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  controller: ScrollController(initialScrollOffset: 100),
                  children: [
                    const SizedBox(
                      width: 24,
                    ),
                    achievement(),
                    const SizedBox(
                      width: 12,
                    ),
                    achievement(),
                    const SizedBox(
                      width: 12,
                    ),
                    achievement(),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffFEFEFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      profileOptions(
                        iconPath: "assets/svg/profile_info.svg",
                        title: "Profile Information",
                        onTap: () =>
                            Get.toNamed(AppRoutes.profileInformationScreen),
                      ),
                      profileOptions(
                        iconPath: "assets/svg/subscription.svg",
                        title: "Subscription",
                        onTap: () => Get.toNamed(AppRoutes.subscriptionPage),
                      ),
                      profileOptions(
                        iconPath: "assets/svg/leaderboard.svg",
                        title: "Leaderboard",
                        onTap: () => Get.toNamed(AppRoutes.leaderboardPage),
                      ),
                      profileOptions(
                        iconPath: "assets/svg/rewards_store.svg",
                        title: "Rewards Store",
                        onTap: () => Get.toNamed(AppRoutes.rewardsStorePage),
                      ),
                      profileOptions(
                        iconPath: "assets/svg/offline_videos.svg",
                        title: "Offline Videos",
                        onTap: () => Get.toNamed(AppRoutes.offlineVideosPage),
                      ),
                      profileOptions(
                        iconPath: "assets/svg/settings.svg",
                        title: "Settings",
                        onTap: () => Get.toNamed(AppRoutes.settingsPage),
                      ),
                      profileOptions(
                        iconPath: "assets/svg/logout.svg",
                        title: "Log Out",
                        isLast: true,
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Color(0xffFAFAFA),
                              // barrierColor: Color(0xff79CDFF),
                              builder: (_) {
                                return SafeArea(
                                  child: SizedBox(
                                    // height: 500,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          height: 75,
                                        ),
                                        Text(
                                          "Are you sure you want to",
                                          style: TextStyle(
                                            color: Color(0xff4E4E4E),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            height: 1,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "Logout?",
                                          style: TextStyle(
                                            color: Color(0xff1e648c),
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            height: 1,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 32,
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(width: 24),
                                            CustomButton(
                                              buttonName: "Logout",
                                              isSecondary: true,
                                              width: 170,
                                              onPressed: () {
                                                PrefsHelper.clearAll();
                                              },
                                            ),
                                            const Spacer(),
                                            CustomButton(
                                              buttonName: "Cancel",
                                              width: 170,
                                              onPressed: () {
                                                Get.back();
                                              },
                                            ),
                                            const SizedBox(width: 24),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 75,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector profileOptions({
    required String iconPath,
    required String title,
    Function()? onTap,
    bool isLast = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          border: Border(
            bottom: isLast
                ? BorderSide.none
                : BorderSide(
                    color: Color(
                      0xff79CDFF,
                    ),
                  ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffC1E8FF),
              ),
              child: Center(
                child: svgViewer(
                  asset: iconPath,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              title,
              style: kTextStyle.copyWith(
                color: Color(0xff4B4B4B),
                fontSize: 18,
              ),
            ),
            const Spacer(),
            svgViewer(
              asset: "assets/svg/arrow_forward.svg",
            ),
          ],
        ),
      ),
    );
  }

  Container achievement() {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xff79CDFF),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffC1E8FF),
            ),
            child: Center(
              child: svgViewer(
                height: 32,
                width: 32,
                asset: "assets/svg/step_master.svg",
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Step Master",
            style: kTextStyle.copyWith(
              fontSize: 16,
              color: Color(0xff174C6B),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "Walked 50,000 steps this month",
            style: kTextStyle.copyWith(
              fontSize: 11,
              color: Color(0xff262626),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
