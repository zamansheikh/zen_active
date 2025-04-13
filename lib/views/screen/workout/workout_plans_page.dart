import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/workout_plans.dart';
import 'package:zenactive/controllers/workout_controller.dart';
import 'package:zenactive/views/components/custom_loading.dart';
import 'package:zenactive/views/screen/workout/plan_details_page.dart';

class WorkoutPlansPage extends StatefulWidget {
  const WorkoutPlansPage({super.key});

  @override
  State<WorkoutPlansPage> createState() => _WorkoutPlansPageState();
}

class _WorkoutPlansPageState extends State<WorkoutPlansPage> {
  final WorkoutController controller = Get.find();
  List<String> workoutPlan = [
    // "All",
    "8 week workout Plan",
    "12 week workout Plan",
  ];
  int workoutPlanIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "Workout Plans"),
            const SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CustomLoading(size: 30));
                  } else if (controller.workOutPlan.isEmpty) {
                    return Center(child: Text("No Workout Plans Available"));
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: 25,
                          child: ListView.builder(
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            itemCount: workoutPlan.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.selectedWorkOutPlan.value =
                                      index == 0 ? 8 : 12;
                                  controller.getAllWorkOutPlan();
                                },
                                child: Obx(() {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: Color(0xffC1E8FF),
                                        border: Border.all(
                                          width: controller.selectedWorkOutPlan
                                                      .value ==
                                                  (index == 0 ? 8 : 12)
                                              ? 1.5
                                              : 0,
                                          color: Color(0xff37B5FF),
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        heightFactor: 5,
                                        child: Text(
                                          workoutPlan[index],
                                          style: kTextStyle.copyWith(
                                            fontSize: 14,
                                            color: Color(
                                              controller.selectedWorkOutPlan
                                                          .value ==
                                                      (index == 0 ? 8 : 12)
                                                  ? 0xff174C6B
                                                  : 0xff32A5E8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.workOutPlan.length,
                            itemBuilder: (context, index) {
                              final plan = controller.workOutPlan[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: WorkoutPlans(
                                  assetPath: plan.image!,
                                  title: plan.name!,
                                  subTitle: plan.description!,
                                  isHighlighted: plan.isEnrolled ?? false,
                                  onTap: () => Get.to(() => PlanDetailsPage(
                                        workoutPlanIndex: index,
                                        workoutIndex: index,
                                      )),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
