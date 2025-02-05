import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/community_group_controller.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/screen/Communitys/Groups/community_groups_describe_your_goal.dart';

class CommunityGroupsCoverPhoto extends StatelessWidget {
  const CommunityGroupsCoverPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: GestureDetector(
              onTap: () {
                Get.find<CommunityGroupController>().pop();
              },
              child: Icon(
                Icons.arrow_back_ios_rounded,
              ),
            ),
          ),
          Text(
            "Add a cover photo",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: Color(0xff3A3A3A),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            height: 170,
            decoration: BoxDecoration(
              color: Color(0xffDBE1E4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: svgViewer(asset: "assets/svg/add_image.svg"),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButton(
            buttonName: "Next",
            onPressed: () {
              Get.find<CommunityGroupController>()
                  .push(CommunityGroupsDescribeYourGoal());
            },
          ),
        ],
      ),
    );
  }
}
