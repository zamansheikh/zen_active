import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/helpers/route.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_video_player.dart';
import 'package:zen_active/views/components/workout_videos.dart';

class WorkoutVideoPlayingPage extends StatelessWidget {
  const WorkoutVideoPlayingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Workout Videos",
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    spacing: 16,
                    children: [
                      Hero(
                          tag: "playing",
                          child: CustomVideoPlayer(
                            videoPath: imageUrl(
                                "/medias/8084750-uhd_3840_2160_25fps-1739262146617.mp4"),
                          )),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.workoutVideoCommentsPage);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Color(0xffFEFEFF),
                              borderRadius: BorderRadius.circular(4)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Comments ",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff222222),
                                    ),
                                  ),
                                  Text(
                                    "255",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff525252),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(999),
                                    child: Image.asset(
                                      "assets/images/faces/2.png",
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "Ask CDCR San Quintin State Prison 2008. We installed Purex dispensers throughout the prison.....",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff222222),
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      WorkoutVideos(
                        assetPath: "assets/images/workout_videos/2.png",
                        onTap: () {
                          Get.toNamed(AppRoutes.workoutVideoPlayingPage);
                        },
                      ),
                      WorkoutVideos(
                        assetPath: "assets/images/workout_videos/3.png",
                        onTap: () {
                          Get.toNamed(AppRoutes.workoutVideoPlayingPage);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
