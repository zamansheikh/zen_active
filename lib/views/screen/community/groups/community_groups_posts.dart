import 'package:flutter/material.dart';
import 'package:zen_active/views/components/posts.dart';

class CommunityGroupsPosts extends StatelessWidget {
  const CommunityGroupsPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: 16,
          children: [
            Posts(
                userImage: "assets/images/faces/3.png",
                name: "Alex Johnson",
                time: "10 min",
                text:
                    "Completed my first HIIT session today! 🥵💪 Feeling accomplished. \n#FitnessGoals #NoPainNoGain",
                likes: 125,
                comment: 20),
            Posts(
                userImage: "assets/images/faces/5.png",
                name: "Bessie Cooper",
                time: "1 hr",
                text:
                    "Finally ran my first 10K today! 🏃‍♂️✨ Couldn't have done it without this amazing community pushing me forward. #RunningGoals #KeepMoving",
                likes: 20,
                comment: 24),
            Posts(
                userImage: "assets/images/faces/6.png",
                name: "Leslie Alexander",
                time: "15 min",
                text:
                    "Meal prep for the week done! 🥗🍗 Keeping it clean and colorful. How do you stay on track during busy weeks? #HealthyEating #MealPrepIdeas",
                likes: 135,
                comment: 10),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
