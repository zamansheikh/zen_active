import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/community_group_controller.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/screen/Communitys/Groups/community_group_details.dart';

class CommunityGroupsDescribeYourGoal extends StatelessWidget {
  const CommunityGroupsDescribeYourGoal({super.key});

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
            "Describe your goal",
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
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: Color(0xffFEFEFF),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color(0xff79CDFF),
              ),
            ),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Tell us more about your goal.......",
                      hintStyle: TextStyle(
                        color: Color(0xff8B8B8B),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButton(
            buttonName: "Next",
            onPressed: () {
              Get.find<CommunityGroupController>()
                  .push(CommunityGroupDetails());
            },
          ),
        ],
      ),
    );
  }
}
