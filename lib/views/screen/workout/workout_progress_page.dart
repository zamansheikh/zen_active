import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/helpers/route.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/custom_button.dart';

class WorkoutProgressPage extends StatefulWidget {
  const WorkoutProgressPage({super.key});

  @override
  State<WorkoutProgressPage> createState() => _WorkoutProgressPageState();
}

class _WorkoutProgressPageState extends State<WorkoutProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Track Workout",
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Container(
                height: 270,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffFEFEFF),
                  border: Border.all(
                    color: Color(0xff79CDFF),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      svgViewer(
                        asset: "assets/svg/check.svg",
                        height: 180,
                        width: 180,
                      ),
                      Text(
                        "Done",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff222222),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
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
                  Padding(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
