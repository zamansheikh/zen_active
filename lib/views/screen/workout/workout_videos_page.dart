import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/helpers/route.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/workout_videos.dart';

class WorkoutVideosPage extends StatelessWidget {
  const WorkoutVideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> plans = ["HIIT", "Cardio", "Dance"];
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
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 25,
                        child: ListView.builder(
                          clipBehavior: Clip.none,
                          scrollDirection: Axis.horizontal,
                          itemCount: plans.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xffC1E8FF),
                                  border: Border.all(
                                    width: index == 0 ? 1.5 : 0,
                                    color: Color(0xff37B5FF),
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  heightFactor: 5,
                                  child: Text(
                                    plans[index],
                                    style: kTextStyle.copyWith(
                                      fontSize: 14,
                                      color: Color(
                                        index == 0 ? 0xff174C6B : 0xff32A5E8,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xffFEFEFF),
                          border: Border.all(
                            color: Color(0xff79CDFF),
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff8B8B8B),
                                  ),
                                  hintText: "Search Workout videos...",
                                ),
                              ),
                            ),
                            Icon(
                              Icons.search_rounded,
                              color: Color(0xff8B8B8B),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                      ),
                      WorkoutVideos(
                        assetPath: "assets/images/workout_videos/1.png",
                        onTap: () {
                          Get.toNamed(AppRoutes.workoutVideoPlayingPage);
                        },
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
