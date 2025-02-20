import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/helpers/route.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/workout_plans.dart';
import 'package:zen_active/views/screen/workout/plan_details_page.dart';

class WorkoutPlansPage extends StatelessWidget {
  const WorkoutPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> data = [
      "Full-Body Plan",
      "Building foundational strength and endurance.",
      "Strength Builder",
      "Enhance strength and build muscle.",
      "Cardio Conditioning",
      "Improve stamina and cardiovascular health.",
      "Core Strength Plan",
      "Focus on your core.",
      "Fat Loss Accelerator",
      "Burn calories with high intensity program.",
      "Yoga for Flexibility",
      "A calming session to improve flexibility and reduce tension."
    ];
    List<String> plans = ["4 Week Plans", "8 Week Plans", "12 Week Plans"];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Workout Plans",
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: SizedBox(
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
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: ListView.builder(
                  itemCount: (data.length / 2).toInt(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: WorkoutPlans(
                        assetPath:
                            "assets/images/workout_plans/${index + 1}.png",
                        title: data[index * 2],
                        subTitle: data[(index * 2) + 1],
                        isHighlighted: index < 2,
                        onTap: () {
                          if (index == 0) {
                            Get.toNamed(AppRoutes.workoutPlansDetailsPage);
                          } else {
                            // Get.to(
                            //   PlanDetailsPage(
                            //     isJoined: false,
                            //   ),
                            // );
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
