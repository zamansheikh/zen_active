import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/helpers/route.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_button.dart';

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({super.key});

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
              Expanded(
                child: Column(
                  spacing: 16,
                  children: [
                    challengeWidget(
                      "Step Up Challenge",
                      "Complete 5,000 steps today. Let's get moving!",
                      1,
                    ),
                    challengeWidget(
                      "Power Push-Up Challenge",
                      "Master your strength by completing 50 push-ups",
                      2,
                    ),
                    challengeWidget(
                      "Yoga Quest",
                      "Complete a 5 minute yoga sessions to improbe flexibility",
                      3,
                      isCompleted: true,
                    ),
                    challengeWidget(
                      "Sprint to the Finish",
                      "Cover 1 km in 30 min",
                      4,
                    ),
                    challengeWidget(
                      "Dance Party Challenge",
                      "Dance for 30 minutes",
                      5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget challengeWidget(String title, String subTitle, int fileNo,
      {bool isCompleted = false}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.challengeDetailsPage);
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
                  child: Image.asset(
                    "assets/images/challenges/$fileNo.png",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
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
