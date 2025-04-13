import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/home_controller.dart';
import 'package:zenactive/models/exercise_model.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/components/custom_loading.dart';
import 'package:zenactive/views/screen/challenges/challenge_details_page.dart';

class DailyChallengesPage extends StatefulWidget {
  const DailyChallengesPage({super.key});

  @override
  State<DailyChallengesPage> createState() => _DailyChallengesPageState();
}

class _DailyChallengesPageState extends State<DailyChallengesPage> {
  final controller = Get.put(HomeController());
  @override
  void initState() {
    controller.getDailyChallenges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Daily Challenges",
            ),
            const SizedBox(height: 14), // Space below AppBar
            Expanded(
              // Wrap the ListView with Expanded
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CustomLoading());
                  }
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = controller.exercises[index];
                      return Column(
                        children: [
                          challengeWidget(
                            exercise.name ?? "Unknown",
                            exercise.description ?? "No description available",
                            imageUrl(exercise.image),
                            exercise,
                            isCompleted: exercise.isCompleted ?? false,
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget challengeWidget(
      String title, String subTitle, String imageUrl, ExerciseModel exercise,
      {bool isCompleted = false}) {
    return GestureDetector(
      onTap: () {
        if (isCompleted) return;
        Get.to(() => ChallengeDetailsPage(
              exercise: exercise,
            ));
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isCompleted ? Color(0xffC1E8FF) : Color(0xffFEFEFF),
          border: Border.all(
            color: Color(0xff79CDFF),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    imageUrl,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/logo/zen_logo.png",
                         filterQuality: FilterQuality.none,
                        width: 46,
                        height: 33,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff222222),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: Text(
                        subTitle,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff757575),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            CustomButton(
              buttonName: isCompleted ? "Completed" : "Take the Challenge",
              textSize: 14,
              height: 33,
              width: isCompleted ? 130 : 150,
              borderRadius: 4,
              leadingIcon: isCompleted ? "assets/svg/tick.svg" : null,
            ),
          ],
        ),
      ),
    );
  }
}
