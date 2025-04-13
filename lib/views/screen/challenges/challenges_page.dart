import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/challenges_controller.dart';
import 'package:zenactive/models/exercise_model.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/components/custom_loading.dart';
import 'package:zenactive/views/screen/challenges/challenge_details_page.dart';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({super.key});

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  final controller = Get.put(ChallengesController());
  @override
  void initState() {
    controller.getChallenges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 34,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/logo/zen_logo.png",
                     filterQuality: FilterQuality.none,
                    width: 46,
                    height: 33,
                  ),
                  const Spacer(),
                  svgViewer(
                    asset: "assets/svg/notification.svg",
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: CustomLoading(),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: controller.exercises.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                challengeWidget(
                                  controller.exercises[index].name!,
                                  controller.exercises[index].description!,
                                  imageUrl(controller.exercises[index].image),
                                  controller.exercises[index],
                                  isCompleted:
                                      controller.exercises[index].isCompleted!,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
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
