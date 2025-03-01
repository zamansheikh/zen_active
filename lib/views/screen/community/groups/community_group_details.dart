import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/posts.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/controllers/community_group_controller.dart';
import 'package:zen_active/views/screen/community/groups/community_group_information.dart';
import 'package:zen_active/views/screen/community/groups/community_groups_invite.dart';

class CommunityGroupDetails extends StatefulWidget {
  final String groupId;
  const CommunityGroupDetails({super.key, required this.groupId});

  @override
  State<CommunityGroupDetails> createState() => _CommunityGroupDetailsState();
}

class _CommunityGroupDetailsState extends State<CommunityGroupDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<CommunityGroupController>().fetchSingleGroupData(widget.groupId);
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
                Image.network(
                  imageUrl(
                    Get.find<CommunityGroupController>().groupInfo.value.image!,
                  ),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/images/challenges/2.png",
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    );
                  },
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Get.find<CommunityGroupController>()
                                .groupInfo
                                .value
                                .name!,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 29,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                              "${Get.find<CommunityGroupController>().groupInfo.value.type!} Group · ${Get.find<CommunityGroupController>().groupInfo.value.totalMembers!} members"),
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
                        postId: "1",
                        userImage: "assets/images/faces/3.png",
                        name: "Sample Name",
                        time: "2 min",
                        text:
                            "Start your week strong! 🌟 What’s your fitness goal for this week? Let’s keep each other accountable. Share your goals in the comments! 🙌 #MotivationMonday",
                        likes: 233,
                        comment: 40,
                      ),
                      Posts(
                        postId: "1",
                        userImage: "assets/images/faces/3.png",
                        name: "Sample Name",
                        time: "2 min",
                        text:
                            "Start your week strong! 🌟 What’s your fitness goal for this week? Let’s keep each other accountable. Share your goals in the comments! 🙌 #MotivationMonday",
                        likes: 233,
                        comment: 40,
                      ),
                      Posts(
                        postId: "1",
                        userImage: "assets/images/faces/3.png",
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
