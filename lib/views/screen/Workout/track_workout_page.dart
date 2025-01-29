import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/screen/Workout/optimize_traning_page.dart';

class TrackWorkoutPage extends StatefulWidget {
  const TrackWorkoutPage({super.key});

  @override
  State<TrackWorkoutPage> createState() => _TrackWorkoutPageState();
}

class _TrackWorkoutPageState extends State<TrackWorkoutPage> {
  bool isRunning = true;
  bool isPaused = true;
  late Timer timer;
  Duration requiredTime = Duration(minutes: 10);
  late Duration remainingTime;
  String timeText = "";

  @override
  void initState() {
    super.initState();
    remainingTime = requiredTime;
    timeText =
        "${remainingTime.inMinutes.toString().padLeft(2, "0")}:${(remainingTime.inSeconds % 60).toString().padLeft(2, "0")}";
    toggleTimer();
  }

  void toggleTimer() {
    if (isPaused) {
      setState(() {
        isPaused = !isPaused;
      });
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        remainingTime = Duration(minutes: remainingTime.inMinutes - 1);
        if (remainingTime.inSeconds >= 0) {
          setState(() {
            timeText =
                "${remainingTime.inMinutes.toString().padLeft(2, "0")}:${(remainingTime.inSeconds % 60).toString().padLeft(2, "0")}";
          });
        } else {
          setState(() {
            isRunning = false;
          });
          timer.cancel();
        }
      });
    } else {
      setState(() {
        isPaused = !isPaused;
      });
      timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Track Workout",
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    isRunning ? clock() : done(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget clock() {
    return Column(
      children: [
        Container(
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 275,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Color(0xffC1E8FF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(137.5, 137.5),
                      topRight: Radius.elliptical(137.5, 137.5),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: Text(
                        timeText,
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 64,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                CustomPaint(
                  size: Size(324, 135),
                  painter: SemiCircularProgressPainter(
                    remainingTime.inSeconds / requiredTime.inSeconds,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        InkWell(
          onTap: () => toggleTimer(),
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
                asset:
                    isPaused ? "assets/svg/play.svg" : "assets/svg/pause.svg",
                height: 32,
                width: 32,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget done() {
    return Column(
      children: [
        Container(
          height: 270,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffFEFEFF),
            border: Border.all(
              color: Color(0xff79CDFF),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
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
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 26,
          ),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "You successfully complete today’s workout plan and earn ",
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
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 26,
          ),
          child: Text(
            "Click ‘Next’ to optimize your training",
            style: TextStyle(
              fontFamily: "khula",
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xff525252),
            ),
          ),
        ),
        const SizedBox(height: 24),
        CustomButton(
          buttonName: "Next",
          width: 124,
          onPressed: () {
            Get.to(OptimizeTraningPage());
          },
        ),
      ],
    );
  }
}

class SemiCircularProgressPainter extends CustomPainter {
  final double progress;

  SemiCircularProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Color(0xffC1E8FF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16;

    final Paint progressPaint = Paint()
      ..color = Color(0xff2781B5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;

    final Paint halfCirclePaint = Paint()
      ..color = Color(0xffC1E8FF)
      ..style = PaintingStyle.fill
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    // Draw background arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      pi,
      false,
      backgroundPaint,
    );

    // Draw progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
