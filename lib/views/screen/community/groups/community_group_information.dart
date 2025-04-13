
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/community_group_controller.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/components/custom_popup_menu.dart';
import 'package:zenactive/views/components/custom_text_field.dart';

class CommunityGroupInformation extends StatefulWidget {
  final String groupId;
  const CommunityGroupInformation({super.key, required this.groupId});

  @override
  State<CommunityGroupInformation> createState() =>
      _CommunityGroupInformationState();
}

class _CommunityGroupInformationState extends State<CommunityGroupInformation> {
  bool isEditing = false;
  TextEditingController groupNameController = TextEditingController();
  TextEditingController groupTypeController = TextEditingController();
  TextEditingController groupGoalController = TextEditingController();
  final groupController = Get.find<CommunityGroupController>();
  @override
  void initState() {
    groupGoalController.text = groupController.groupInfo.value.goal!;
    groupNameController.text = groupController.groupInfo.value.name!;
    groupTypeController.text = groupController.groupInfo.value.type!;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CommunityGroupController>(builder: (controller) {
        return SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                title: "Group Info",
                overridedBackFunction: () {
                  Get.back();
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 24),
                        child: Column(
                          spacing: 24,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      controller
                                          .pickImageAndSave(widget.groupId);
                                    },
                                    child: Container(
                                      height: 180,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffDBE1E4),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Image.network(
                                        imageUrl(
                                            controller.groupInfo.value.image!),
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            height: 180,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffDBE1E4),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: svgViewer(
                                                  asset:
                                                      "assets/svg/add_image.svg"),
                                            ),
                                          );
                                        },
                                      ),
                                    )),
                                Positioned(
                                    child: isEditing
                                        ? Container(
                                            height: 180,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: svgViewer(
                                                  asset:
                                                      "assets/svg/camera.svg"),
                                            ),
                                          )
                                        : Container()),
                              ],
                            ),
                            CustomTextField(
                              title: "Group Name",
                              isDisabled: !isEditing,
                              controller: groupNameController,
                            ),
                            CustomPopupMenu(
                              title: "Group Type",
                              hintText: groupController.groupInfo.value.type,
                              isActive: isEditing,
                              options: ["Public", "Private"],
                              onChanged: (p0) {
                                groupTypeController.text = p0;
                              },
                            ),
                            CustomTextField(
                              title: "Goal of this Group",
                              multiline: true,
                              isDisabled: !isEditing,
                              controller: groupGoalController,
                              lines: 5,
                            ),
                            CustomButton(
                              buttonName:
                                  isEditing ? "Update Group" : "Edit Group",
                              isSecondary: !isEditing,
                              onPressed: () async {
                                if (!isEditing) {
                                  setState(() {
                                    isEditing = !isEditing;
                                  });
                                } else {
                                  groupController
                                      .pathGroupData(
                                          groupName: groupNameController.text,
                                          type: groupTypeController.text,
                                          goal: groupGoalController.text,
                                          id: widget.groupId)
                                      .then((value) {
                                    if (value) {
                                      setState(() {
                                        isEditing = !isEditing;
                                      });
                                    } else {
                                      Get.snackbar("Error",
                                          "You can't update the group, You are not Admin",
                                          backgroundColor: const Color.fromARGB(
                                              255, 0, 255, 242),
                                          snackPosition: SnackPosition.BOTTOM);
                                    }
                                  });
                                }
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
          ),
        );
      }),
    );
  }
}
