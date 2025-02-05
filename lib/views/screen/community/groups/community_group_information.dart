import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/community_group_controller.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_text_field.dart';

class CommunityGroupInformation extends StatefulWidget {
  const CommunityGroupInformation({super.key});

  @override
  State<CommunityGroupInformation> createState() =>
      _CommunityGroupInformationState();
}

class _CommunityGroupInformationState extends State<CommunityGroupInformation> {
  bool isEditing = false;
  TextEditingController groupNameController = TextEditingController();
  TextEditingController groupTypeController = TextEditingController();
  TextEditingController groupGoalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: "Group Info",
          overridedBackFunction: () {
            Get.find<CommunityGroupController>().pop();
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      "assets/images/challenges/2.png",
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                    if (isEditing)
                      Container(
                        width: double.infinity,
                        height: 200,
                        color: Colors.black.withAlpha(102),
                        child: Center(
                          child: svgViewer(
                            asset: "assets/svg/camera.svg",
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    spacing: 24,
                    children: [
                      CustomTextField(
                        title: "Group Name",
                        isDisabled: !isEditing,
                      ),
                      CustomTextField(
                        title: "Group Type",
                        isDisabled: !isEditing,
                      ),
                      CustomTextField(
                        title: "Goal of this Group",
                        multiline: true,
                        isDisabled: !isEditing,
                        lines: 5,
                      ),
                      CustomButton(
                        buttonName: isEditing ? "Update Group" : "Edit Group",
                        isSecondary: !isEditing,
                        onPressed: () {
                          setState(() {
                            isEditing = !isEditing;
                          });
                        },
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
