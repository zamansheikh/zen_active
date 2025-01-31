import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_loading.dart';
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
            feedPost(
              "assets/images/faces/3.png",
              "Alex Johnson",
              "10 min",
              "Completed my first HIIT session today! 🥵💪 Feeling accomplished. \n#FitnessGoals #NoPainNoGain",
              125,
              20,
            ),
            feedPost(
              "assets/images/faces/5.png",
              "Bessie Cooper",
              "1 hr",
              "Finally ran my first 10K today! 🏃‍♂️✨ Couldn't have done it without this amazing community pushing me forward. #RunningGoals #KeepMoving",
              20,
              24,
            ),
            feedPost(
              "assets/images/faces/6.png",
              "Leslie Alexander",
              "15 min",
              "Meal prep for the week done! 🥗🍗 Keeping it clean and colorful. How do you stay on track during busy weeks? #HealthyEating #MealPrepIdeas",
              135,
              10,
            ),
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

  Widget feedPost(String imagePath, String name, String time, String text,
      int likes, int comment) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffFEFEFF),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(
              15,
            ),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: Image.asset(
                    imagePath,
                    height: 32,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Color(0xff2D2D2D),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: Color(0xffAFAFAF),
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 0.5,
            color: Color(0xff37B5FF),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 20,
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 25,
            child: Row(
              children: [
                const SizedBox(width: 12),
                Text("💙 $likes Likes"),
                const Spacer(),
                Text("$likes Comments"),
                const SizedBox(width: 12),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        svgViewer(
                          asset: "assets/svg/like.svg",
                          height: 16,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Like",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xff4B4B4B),
                            height: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  width: 1,
                  color: Color(0xff757575),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.to(()=> CommunityCommentPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        svgViewer(
                          asset: "assets/svg/comment.svg",
                          height: 16,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Comment",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xff4B4B4B),
                            height: 4,
                          ),
                        ),
                      ],
                    ),
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
