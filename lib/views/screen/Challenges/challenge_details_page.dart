import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/helpers/route.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';

class ChallengeDetailsPage extends StatelessWidget {
  const ChallengeDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Challenge",
              tailingIconPath: "assets/svg/share.svg",
            ),
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "assets/images/challenges/2.png",
                              height: 215,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "Power Push-Up Challenge",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 23,
                              color: Color(0xff222222),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Test your strength and resilience! Complete 50 push-ups in a week and level up your fitness",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xff4B4B4B),
                            ),
                          ),
                          const SizedBox(height: 28),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              svgViewer(
                                asset: "assets/svg/goal.svg",
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Goal",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff757575),
                                      fontWeight: FontWeight.w600,
                                      height: 1,
                                    ),
                                  ),
                                  Text(
                                    "50 Push-Ups today",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xff3A3A3A),
                                      fontWeight: FontWeight.w600,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              svgViewer(
                                asset: "assets/svg/duration.svg",
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Duration",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff757575),
                                      fontWeight: FontWeight.w600,
                                      height: 1,
                                    ),
                                  ),
                                  Text(
                                    "30 min",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xff3A3A3A),
                                      fontWeight: FontWeight.w600,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              svgViewer(
                                asset: "assets/svg/participants.svg",
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Participants",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff757575),
                                      fontWeight: FontWeight.w600,
                                      height: 1,
                                    ),
                                  ),
                                  Text(
                                    "20 completed",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xff3A3A3A),
                                      fontWeight: FontWeight.w600,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "About this Challenge",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff2D2D2D),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. commodo consequat. Duis aute irure dolor in""",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xff525252),
                            ),
                          ),
                          const SizedBox(
                            height: 52,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 24,
                    right: 24,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.white.withAlpha(255),
                                Colors.white.withAlpha(0),
                              ],
                            ),
                          ),
                        ),
                        CustomButton(
                          buttonName: "Take the Challenge",
                          onPressed: () {
                            Get.toNamed(AppRoutes.challengeProgressPage);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
