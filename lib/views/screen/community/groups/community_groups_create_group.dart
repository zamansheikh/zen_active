import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/community_group_controller.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/components/custom_popup_menu.dart';
import 'package:zenactive/views/components/custom_text_field.dart';
import 'package:zenactive/views/screen/community/groups/community_groups_cover_photo.dart';

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
            children: [
              CustomTextField(
                title: "Name",
                hintText: "Name your group",
                controller:
                    Get.find<CommunityGroupController>().groupNameController,
              ),
              SizedBox(height: 24),
              CustomPopupMenu(
                title: "Set Group Type",
                hintText: "Choose group type",
                options: ["Public", "Private"],
                onChanged: (p0) {
                  Get.find<CommunityGroupController>()
                      .groupTypeController
                      .text = p0;
                },
              ),
              SizedBox(height: 24),
              CustomButton(
                buttonName: "Create Group",
                onPressed: () {
                  Get.find<CommunityGroupController>()
                      .push(CommunityGroupsCoverPhoto());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
