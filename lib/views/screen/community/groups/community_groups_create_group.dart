import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/community_group_controller.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_text_field.dart';
import 'package:zen_active/views/screen/community/Groups/community_groups_invite.dart';

class CommunityGroupsCreateGroup extends StatelessWidget {
  const CommunityGroupsCreateGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: "Create Group",
          overridedBackFunction: () {
            Get.find<CommunityGroupController>().pop();
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            spacing: 24,
            children: [
              CustomTextField(
                title: "Name",
                hintText: "Name your group",
                controller:
                    Get.find<CommunityGroupController>().groupNameController,
              ),
              // CustomDropDown(
              //   title: "Set Group Type",
              //   hintText: "Choose group type",
              //   options: ["Public", "Private"],
              // ),
              CustomButton(
                buttonName: "Create Group",
                onPressed: () {
                  Get.find<CommunityGroupController>().push(
                    CommunityGroupsInvite(
                      hasNext: true,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
