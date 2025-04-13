import 'package:flutter/material.dart';
import 'package:zenactive/views/components/comment_section.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/workout_videos.dart';

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
                    Expanded(
                        child: CommentSection(
                      postId: "kjdfkd",
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
