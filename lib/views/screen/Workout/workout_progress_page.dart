import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/helpers/route.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/timer_widget.dart';

class WorkoutProgressPage extends StatefulWidget {
  const WorkoutProgressPage({super.key});

  @override
  State<WorkoutProgressPage> createState() => _WorkoutProgressPageState();
}

class _WorkoutProgressPageState extends State<WorkoutProgressPage> {
  bool isRunning = true;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Track Workout",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TimerWidget(
                    timer: const Duration(seconds: 10),
                    isRunning: isRunning,
                    onComplete: () {
                      setState(() {
                        isCompleted = !isCompleted;
                        isRunning = false;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  isCompleted
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Column(
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text:
                                      "You successfully complete today’s workout plan and earn ",
                                  style: TextStyle(
                                    fontFamily: "khula",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff525252),
                                    height: 1,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "52",
                                      style: TextStyle(
                                        fontFamily: "khula",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff1E648C),
                                        height: 1,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " points",
                                      style: TextStyle(
                                        fontFamily: "khula",
                                        fontSize: 18,
                                        height: 1,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff525252),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Click ‘Next’ to optimize your training",
                                style: TextStyle(
                                  fontFamily: "khula",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff525252),
                                ),
                              ),
                              const SizedBox(height: 20),
                              CustomButton(
                                buttonName: "Next",
                                width: 124,
                                onPressed: () {
                                  Get.toNamed(AppRoutes.optimizeTrainingPage);
                                },
                              ),
                            ],
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              isRunning = !isRunning;
                            });
                          },
                          borderRadius: BorderRadius.circular(9999),
                          child: Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              color: Color(0xffC1E8FF),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: svgViewer(
                                asset: !isRunning
                                    ? "assets/svg/play.svg"
                                    : "assets/svg/pause.svg",
                                height: 32,
                                width: 32,
                              ),
                            ),
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
