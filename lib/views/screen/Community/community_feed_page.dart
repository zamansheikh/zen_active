import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_loading.dart';
import 'package:zen_active/views/components/posts.dart';
import 'package:zen_active/views/screen/Community/community_comment_page.dart';
import 'package:zen_active/views/screen/Community/community_post_page.dart';

class CommunityFeedPage extends StatelessWidget {
  const CommunityFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          spacing: 16,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
                bottom: 8,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: Image.asset(
                      "assets/images/faces/1.png",
                      height: 40,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(CommunityPostPage());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xffFEFEFF),
                          border: Border.all(
                            color: Color(0xff79CDFF),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Share your fitness journey.........",
                            style:
                                TextStyle(color: Color(0xffAFAFAF), height: 3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Posts(imagePath: "assets/images/faces/3.png", name: "Alex Johnson", time: "10 min", text: "Completed my first HIIT session today! 🥵💪 Feeling accomplished. \n#FitnessGoals #NoPainNoGain", likes: 125, comment: 20),
            Posts(imagePath: "assets/images/faces/5.png", name: "Bessie Cooper", time: "1 hr", text: "Finally ran my first 10K today! 🏃‍♂️✨ Couldn't have done it without this amazing community pushing me forward. #RunningGoals #KeepMoving", likes: 20, comment: 24),
            Posts(imagePath: "assets/images/faces/6.png", name: "Leslie Alexander", time: "15 min", text: "Meal prep for the week done! 🥗🍗 Keeping it clean and colorful. How do you stay on track during busy weeks? #HealthyEating #MealPrepIdeas", likes: 135, comment: 10),
            CustomLoading(
              color: AppColors.primaryColor,
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}