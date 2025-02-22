import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/workout_controller.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_loading.dart';

class WorkoutExcercisePage extends StatefulWidget {
  final String planId;
  const WorkoutExcercisePage({super.key, required this.planId});

  @override
  State<WorkoutExcercisePage> createState() => _WorkoutExcercisePageState();
}

class _WorkoutExcercisePageState extends State<WorkoutExcercisePage> {
  final controller = Get.find<WorkoutController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getSingleWorkOutPlan(widget.planId);
    });
    debugPrint("Plan ID: ${widget.planId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return controller.isLoading.value
              ? CustomLoading()
              : Column(
                  children: [
                    CustomAppBar(
                      title:
                          "Day ${(controller.singleWorkout.value.currentWorkoutIndex == null) ? 1 : controller.singleWorkout.value.currentWorkoutIndex! + 1}",
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                children: [
                                  Image.network(
                                    imageUrl(controller
                                        .singleWorkout
                                        .value
                                        .workoutPlanId!
                                        .workouts![controller.singleWorkout
                                            .value.currentWorkoutIndex!]
                                        .exercises![controller.singleWorkout
                                            .value.currentExerciseIndex!]
                                        .image!),
                                    height: 215,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey,
                                        child: Center(
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    },
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
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              controller
                                  .singleWorkout
                                  .value
                                  .workoutPlanId!
                                  .workouts![controller
                                      .singleWorkout.value.currentWorkoutIndex!]
                                  .exercises![controller.singleWorkout.value
                                      .currentExerciseIndex!]
                                  .name!,
                              style: TextStyle(
                                color: Color(0xff222222),
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width: 0.5,
                                    color: Color(0xff79CDFF),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Transform.translate(
                                          offset: Offset(0, 5),
                                          child: Text(
                                            controller
                                                .singleWorkout
                                                .value
                                                .workoutPlanId!
                                                .workouts![controller
                                                    .singleWorkout
                                                    .value
                                                    .currentWorkoutIndex!]
                                                .exercises![controller
                                                    .singleWorkout
                                                    .value
                                                    .currentExerciseIndex!]
                                                .sets
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff174C6B),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Sets",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff174C6B),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 2,
                                      height: 60,
                                      color: Color(0xff2781B5),
                                    ),
                                    Column(
                                      children: [
                                        Transform.translate(
                                          offset: Offset(0, 5),
                                          child: Text(
                                            controller
                                                .singleWorkout
                                                .value
                                                .workoutPlanId!
                                                .workouts![controller
                                                    .singleWorkout
                                                    .value
                                                    .currentWorkoutIndex!]
                                                .exercises![controller
                                                    .singleWorkout
                                                    .value
                                                    .currentExerciseIndex!]
                                                .reps
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff174C6B),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Reps",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff174C6B),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(child: Container()),
                            CustomButton(
                              buttonName: "Next",
                              onPressed: () {
                                controller.nextExercise(
                                  widget.planId,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
