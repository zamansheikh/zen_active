import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/community_group_controller.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_drop_down.dart';
import 'package:zen_active/views/components/custom_text_field.dart';

class CommunityGroupsCreateGroup extends StatelessWidget {
  const CommunityGroupsCreateGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        spacing: 24,
        children: [
          CustomAppBar(
            title: "Create Group",
            overridedBackFunction: () {
              Get.find<CommunityGroupController>().pop();
            },
          ),
          CustomTextField(
            title: "Name",
            hintText: "Name your group",
          ),
          CustomDropDown(
            title: "Set Group Type",
            hintText: "Choose group type",
            options: ["Public", "Private"],
          ),
          CustomButton(buttonName: "Create Group"),
        ],
      ),
    );
  }
}
