import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/helpers/route.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';

class PlanDetailsPage extends StatefulWidget {
  final bool isJoined;
  const PlanDetailsPage({
    super.key,
    this.isJoined = true,
  });

  @override
  State<PlanDetailsPage> createState() => _PlanDetailsPageState();
}

class _PlanDetailsPageState extends State<PlanDetailsPage> {
  bool isJoining = false;
  bool hasJoined = false;
  bool isJoined = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Full-Body Plan",
              tailingIconPath: "assets/svg/share.svg",
            ),
            Expanded(
              child: SingleChildScrollView(
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
                        child: Stack(
                          children: [
                            Image.asset(
                              "assets/images/workout_plans/1.png",
                              height: 215,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: Colors.black.withAlpha(102),
                                child: Center(
                                  child: Container(
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffEBF8FF),
                                    ),
                                    child: Center(
                                      child: svgViewer(
                                        asset: "assets/svg/play.svg",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  color: Color(0xff174C6B),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Text(
                                  "15:00",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffEBF8FF),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Full-Body Plan",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 23,
                          color: Color(0xff222222),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "A 4-week plan for building foundational strength and endurance.",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xff4B4B4B),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "About this Workout",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Color(0xff2D2D2D),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
commodo consequat. Duis aute irure dolor in""",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xff525252),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      /* 
                        Temoporary Solution
                        Use Switch Case during API-Integration
                      */
                      widget.isJoined || isJoined
                          ? CustomButton(
                              buttonName: "Start Workout",
                              onPressed: () {
                                Get.toNamed(AppRoutes.workoutProgressPage);
                              },
                            )
                          : CustomButton(
                              buttonName: hasJoined
                                  ? "You successfully joined this plan"
                                  : "Join this Plan",
                              isLoading: isJoining,
                              leadingIcon: hasJoined
                                  ? "assets/svg/tick_circled.svg"
                                  : null,
                              textSize: hasJoined ? 18 : 20,
                              onPressed: () async {
                                setState(() {
                                  isJoining = true;
                                });
                                await Future.delayed(
                                  const Duration(seconds: 1),
                                );
                                setState(() {
                                  isJoining = false;
                                  hasJoined = true;
                                });
                                await Future.delayed(
                                  const Duration(seconds: 1),
                                );
                                setState(() {
                                  isJoined = true;
                                });
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
