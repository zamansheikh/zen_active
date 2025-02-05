import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/timer_widget.dart';

class ChallengeProgressPage extends StatefulWidget {
  const ChallengeProgressPage({super.key});

  @override
  State<ChallengeProgressPage> createState() => _ChallengeProgressPageState();
}

class _ChallengeProgressPageState extends State<ChallengeProgressPage> {
  bool isRunning = true;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Challenge",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                children: [
                  TimerWidget(
                    timer: const Duration(seconds: 10),
                    isRunning: isRunning,
                    title: "Power Push-Up Challenge",
                    onComplete: () {
                      setState(() {
                        isCompleted = !isCompleted;
                        isRunning = false;
                        Timer(const Duration(seconds: 3), () {
                          Get.back();
                          Get.back();
                        });
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
                              Text(
                                "You pass the daily challenge",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff525252),
                                ),
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: "and earn ",
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
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
