import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/workout_videos.dart';

class WorkoutVideoCommentsPage extends StatelessWidget {
  const WorkoutVideoCommentsPage({super.key});

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
                    children: [
                      WorkoutVideos(
                        isPlaying: true,
                        assetPath: "assets/images/workout_videos/1.png",
                      ),
                      Container(
                        height: 1,
                        color: Color(0xff32A5E8),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xffFEFEFF),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 12,
                          children: [
                            MediaQuery.removePadding(
                              context: context,
                              removeBottom: true,
                              child: Text(
                                "Comments ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff222222),
                                ),
                              ),
                            ),
                            comment(
                              "Henry Aurther",
                              "Ask CDCR San Quintin State Prison 2008. We installed Purex dispensers throughout the prison.....",
                              2,
                            ),
                            comment(
                              "Flores Juanita",
                              "Even factoring differences in body weight between children and adults into account, it would still n",
                              3,
                            ),
                            comment(
                              "Cooper Kristin",
                              "An average healthy 7 year old boy weighs about 50 lb (23 kg). If we suppose the same amount of alcoh",
                              8,
                            ),
                            comment(
                              "Black Marvin",
                              "An interesting implication of the 2007 study concerns the use of hand sanitizers by observant Muslim",
                              6,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Color(0xff79CDFF),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffFEFEFF),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(999),
                              child: Image.asset(
                                "assets/images/faces/4.png",
                                height: 24,
                                width: 24,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xffDBE1E4),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Add a comment",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Color(0xff656869),
                                      ),
                                    ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget comment(String name, String comment, int faceNo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Image.asset(
              "assets/images/faces/$faceNo.png",
              height: 24,
              width: 24,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff222222),
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  comment,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff525252),
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
