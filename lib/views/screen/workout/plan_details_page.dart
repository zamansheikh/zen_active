import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/workout_controller.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/screen/workout/workout_excercise_page.dart';

class PlanDetailsPage extends StatefulWidget {
  final int workoutIndex;
  final int workoutPlanIndex;
  const PlanDetailsPage({
    super.key,
    this.workoutIndex = 0,
    this.workoutPlanIndex = 0,
  });

  @override
  State<PlanDetailsPage> createState() => _PlanDetailsPageState();
}

class _PlanDetailsPageState extends State<PlanDetailsPage> {
  final workoutController = Get.find<WorkoutController>();
  bool hasJoined = false;
  @override
  Widget build(BuildContext context) {
    print(workoutController.workOutPlan[widget.workoutPlanIndex].isEnrolled);
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              CustomAppBar(
                title: workoutController
                    .workOutPlan[widget.workoutPlanIndex].name!,
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
                          workoutController
                              .workOutPlan[widget.workoutPlanIndex].name!,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 23,
                            color: Color(0xff222222),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          workoutController.workOutPlan[widget.workoutPlanIndex]
                              .description!,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xff4B4B4B),
                          ),
                        ),
                        const SizedBox(height: 24),
                        workoutController.workOutPlan[widget.workoutPlanIndex]
                                .isEnrolled!
                            ? Table(
                                columnWidths: {
                                  0: FlexColumnWidth(3),
                                  1: FlexColumnWidth(),
                                  2: FlexColumnWidth(),
                                },
                                border: TableBorder.all(
                                  width: 0.5,
                                  color: Color(0xff79CDFF),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                children: [
                                  TableRow(
                                    decoration: BoxDecoration(
                                      color: Color(0xffc1e8ff),
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(8),
                                      ),
                                    ),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Text(
                                          "Excercise",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff2D2D2D),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Text(
                                            "Sets",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff2D2D2D),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Text(
                                            "Reps",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff2D2D2D),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  for (var i in workoutController
                                      .workOutPlan[widget.workoutPlanIndex]
                                      .workouts![widget.workoutIndex]
                                      .exercises!)
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            i.name!,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff454B54),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              i.name.toString(),
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff454B54),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              i.reps.toString(),
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff454B54),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                    workoutController
                                        .workOutPlan[widget.workoutPlanIndex]
                                        .about!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Color(0xff525252),
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 40,
                        ),
                        /* 
                            Temoporary Solution
                            Use Switch Case during API-Integration
                          */
                        workoutController.workOutPlan[widget.workoutPlanIndex]
                                .isEnrolled!
                            ? CustomButton(
                                buttonName: "Start Workout",
                                onPressed: () {
                                  Get.to(
                                    () => WorkoutExcercisePage(
                                        planId: workoutController
                                            .workOutPlan[
                                                widget.workoutPlanIndex]
                                            .id!),
                                  );
                                },
                              )
                            : CustomButton(
                                buttonName: workoutController.hasJoined.value
                                    ? "You successfully joined this plan"
                                    : "Join this Plan",
                                isLoading: workoutController.isLoading.value,
                                leadingIcon: workoutController
                                        .workOutPlan[widget.workoutPlanIndex]
                                        .isEnrolled!
                                    ? "assets/svg/tick_circled.svg"
                                    : null,
                                textSize: workoutController
                                        .workOutPlan[widget.workoutPlanIndex]
                                        .isEnrolled!
                                    ? 18
                                    : 20,
                                onPressed: () async {
                                  workoutController.joinAWorkOutPlan(
                                      workoutController
                                          .workOutPlan[widget.workoutPlanIndex]
                                          .id!);
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
          );
        }),
      ),
    );
  }
}
