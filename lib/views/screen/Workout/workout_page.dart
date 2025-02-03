import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/helpers/route.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/workout_plans.dart';
import 'package:zen_active/views/components/workout_videos.dart';
import 'package:zen_active/views/screen/Workout/plan_details_page.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> plans = ["4 Week Plans", "8 Week Plans", "12 Week Plans"];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/logo/zen_logo.png",
                      width: 46,
                      height: 33,
                    ),
                    const Spacer(),
                    svgViewer(
                      asset: "assets/svg/notification.svg",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.workoutPlansPage);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    children: [
                      Text(
                        "Workout Plans",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff525252),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff525252),
                        ),
                      ),
                      svgViewer(asset: "assets/svg/see_all.svg"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 25,
                  child: ListView.builder(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    itemCount: plans.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xffC1E8FF),
                            border: Border.all(
                              width: index == 0 ? 1.5 : 0,
                              color: Color(0xff37B5FF),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            heightFactor: 5,
                            child: Text(
                              plans[index],
                              style: kTextStyle.copyWith(
                                fontSize: 14,
                                color: Color(
                                  index == 0 ? 0xff174C6B : 0xff32A5E8,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                WorkoutPlans(
                  assetPath: "assets/images/workout_plans/1.png",
                  title: "Full-Body Plan",
                  subTitle: "Building foundational strength and endurance.",
                  isHighlighted: true,
                  onTap: () {
                    Get.toNamed(AppRoutes.workoutPlansDetailsPage);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                WorkoutPlans(
                  assetPath: "assets/images/workout_plans/2.png",
                  title: "Strength Building",
                  subTitle: "Enhance strength and build muscle.",
                  onTap: () {
                    // Get.toNamed(AppRoutes.workoutPlansDetailsPage);
                    Get.to(()=>
                      PlanDetailsPage(
                        isJoined: false,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                WorkoutPlans(
                  assetPath: "assets/images/workout_plans/3.png",
                  title: "Cardio Conditioning",
                  subTitle: "Improve stamina and cardiovascular health.",
                  onTap: () {
                    // Get.toNamed(AppRoutes.workoutPlansDetailsPage);
                    Get.to(()=>
                      PlanDetailsPage(
                        isJoined: false,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.workoutVideosPage);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    children: [
                      Text(
                        "Workout Videos",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff525252),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff525252),
                        ),
                      ),
                      svgViewer(asset: "assets/svg/see_all.svg"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                WorkoutVideos(
                  assetPath: "assets/images/workout_videos/1.png",
                  onTap: () => Get.toNamed(AppRoutes.workoutVideoPlayingPage),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
