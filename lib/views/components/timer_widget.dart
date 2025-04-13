import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zenactive/utils/uitls.dart';

class TimerWidget extends StatefulWidget {
  final Duration timer;
  final String? title;
  final bool isRunning;
  final Function()? onComplete;
  const TimerWidget({
    super.key,
    required this.timer,
    this.title,
    this.onComplete,
    this.isRunning = true,
  });

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  bool isPaused = true;
  late Timer timer;
  late Duration remainingTime;
  String timerText = "";

  @override
  void initState() {
    super.initState();
    remainingTime = widget.timer;
    remainingTime = Duration(seconds: remainingTime.inSeconds + 1);
    timerText = secondToFormattedTimeWithSecond(remainingTime.inSeconds);
    // "${remainingTime.inMinutes.toString().padLeft(2, "0")}:${(remainingTime.inSeconds % 60).toString().padLeft(2, "0")}";
    continueTimer();
  }

  void pauseTimer() {
    setState(() {
      isPaused = true;
    });
    timer.cancel();
  }

  void continueTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      remainingTime = Duration(milliseconds: remainingTime.inMilliseconds - 16);
      if (remainingTime.inMilliseconds > 0) {
        setState(() {
          timerText = secondToFormattedTimeWithSecond(remainingTime.inSeconds);

          //  "${remainingTime.inMinutes.toString().padLeft(2, "0")}:${(remainingTime.inSeconds % 60).toString().padLeft(2, "0")}";
        });
      } else {
        if (widget.onComplete != null) {
          widget.onComplete!();
        }
        setState(() {
          isPaused = true;
        });
        timer.cancel();
      }
    });
    setState(() {
      isPaused = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isRunning && isPaused) {
      continueTimer();
    } else if (!widget.isRunning && !isPaused) {
      pauseTimer();
    }
    return Stack(
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
            child: remainingTime.inMilliseconds <= 0
                ? Column(
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
                  )
                : Stack(
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
                              timerText,
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 46,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      CustomPaint(
                        size: Size(324, 135),
                        painter: SemiCircularProgressPainter(
                          remainingTime.inMilliseconds /
                              (widget.timer.inMilliseconds + 1000),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        if (remainingTime.inMilliseconds > 0)
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Text(
              widget.title ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 26,
                color: Color(0xff222222),
              ),
            ),
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
