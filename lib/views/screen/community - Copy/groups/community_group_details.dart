import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:zen_active/views/components/posts.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/controllers/community_group_controller.dart';
import 'package:zen_active/views/screen/community/groups/community_group_information.dart';
import 'package:zen_active/views/screen/community/groups/community_groups_invite.dart';

class CommunityGroupDetails extends StatelessWidget {
  const CommunityGroupDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          overridedBackFunction: () {
            Get.find<CommunityGroupController>().pop();
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/challenges/2.png",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 28,
                  ),
                  child: Column(
                    spacing: 24,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Flex and Flow",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 29,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text("Public group · 65 members"),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              buttonName: "Information",
                              leadingIcon: "assets/svg/information.svg",
                              height: 40,
                              textSize: 16,
                              onPressed: () {
                                Get.find<CommunityGroupController>()
                                    .push(CommunityGroupInformation());
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          Expanded(
                            child: CustomButton(
                              buttonName: "Invite",
                              leadingIcon: "assets/svg/invite.svg",
                              isSecondary: true,
                              height: 40,
                              textSize: 16,
                              onPressed: () {
                                Get.find<CommunityGroupController>()
                                    .push(CommunityGroupsInvite());
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: Image.asset(
                              "assets/images/faces/4.png",
                              height: 40,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
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
                                    "Write something",
                                    style: TextStyle(
                                        color: Color(0xffAFAFAF), height: 3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Posts(
                        imagePath: "assets/images/faces/3.png",
                        name: "Sample Name",
                        time: "2 min",
                        text:
                            "Start your week strong! 🌟 What’s your fitness goal for this week? Let’s keep each other accountable. Share your goals in the comments! 🙌 #MotivationMonday",
                        likes: 233,
                        comment: 40,
                      ),
                      Posts(
                        imagePath: "assets/images/faces/3.png",
                        name: "Sample Name",
                        time: "2 min",
                        text:
                            "Start your week strong! 🌟 What’s your fitness goal for this week? Let’s keep each other accountable. Share your goals in the comments! 🙌 #MotivationMonday",
                        likes: 233,
                        comment: 40,
                      ),
                      Posts(
                        imagePath: "assets/images/faces/3.png",
                        name: "Sample Name",
                        time: "2 min",
                        text:
                            "Start your week strong! 🌟 What’s your fitness goal for this week? Let’s keep each other accountable. Share your goals in the comments! 🙌 #MotivationMonday",
                        likes: 233,
                        comment: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
