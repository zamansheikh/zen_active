import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/challenges_controller.dart';
import 'package:zen_active/models/exercise_model.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/screen/challenges/challenge_progress_page.dart';

class ChallengeDetailsPage extends StatefulWidget {
  final ExerciseModel exercise;
  const ChallengeDetailsPage({super.key, required this.exercise});

  @override
  State<ChallengeDetailsPage> createState() => _ChallengeDetailsPageState();
}

class _ChallengeDetailsPageState extends State<ChallengeDetailsPage> {
  final controller = Get.find<ChallengesController>();
  @override
  void initState() {
    controller.getSingleChallege(
      widget.exercise.id!,
    );
    super.initState();
  }

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
                            child: Image.network(
                              imageUrl(widget.exercise.image!),
                              height: 215,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            widget.exercise.name!,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 23,
                              color: Color(0xff222222),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.exercise.description!,
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
                                    controller
                                        .singleExercise.value.exercise!.goal!,
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
                                    secondToFormattedTime(controller
                                        .singleExercise
                                        .value
                                        .exercise!
                                        .duration!),
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
                                    "${controller.singleExercise.value.participant!.toString()} Completed",
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
                            controller.singleExercise.value.exercise!.about!,
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
                          onPressed: () async {
                            final state =
                                await Get.to(() => ChallengeProgressPage(
                                      exercise: controller.singleExercise.value,
                                    ));
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
