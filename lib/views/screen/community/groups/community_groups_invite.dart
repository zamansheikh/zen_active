import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/community_group_controller.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/components/custom_loading.dart';
import 'package:zenactive/views/components/custom_search_bar.dart';
import 'package:zenactive/views/screen/community/Groups/community_groups_cover_photo.dart';

class CommunityGroupsInvite extends StatefulWidget {
  final bool hasNext;
  final String? groupId;
  const CommunityGroupsInvite({super.key, this.hasNext = false, this.groupId});

  @override
  State<CommunityGroupsInvite> createState() => _CommunityGroupsInviteState();
}

class _CommunityGroupsInviteState extends State<CommunityGroupsInvite> {
  final controlller = Get.find<CommunityGroupController>();
  @override
  void initState() {
    if (widget.groupId != null) {
      controlller.getAllInvity(widget.groupId!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                CustomAppBar(
                  title: "Invite People",
                  overridedBackFunction: () {
                    Get.back();
                  },
                ),
                if (widget.hasNext)
                  Positioned(
                    right: 12,
                    top: 12,
                    child: TextButton(
                      onPressed: () {
                        Get.find<CommunityGroupController>()
                            .push(CommunityGroupsCoverPhoto());
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  spacing: 16,
                  children: [
                    CustomSearchBar(
                      controller: TextEditingController(),
                      hintText: "Search people",
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Suggested",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff4B4B4B),
                        ),
                      ),
                    ),
                    // Expanded(child: Container()),
                    if (controlller.isLoading.value)
                      Expanded(
                        child: Center(
                          child: CustomLoading(),
                        ),
                      )
                    else
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (int i = 0;
                                  i < controlller.inviteList.length;
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(999),
                                        child: Image.network(
                                          imageUrl(
                                              controlller.inviteList[i].image),
                                          width: 52,
                                          height: 52,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              width: 52,
                                              height: 52,
                                              color: Colors.grey,
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        "${controlller.inviteList[i].name.firstName} ${controlller.inviteList[i].name.lastName}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff222222),
                                        ),
                                      ),
                                      const Spacer(),
                                      Obx(() {
                                        return CustomButton(
                                          buttonName: controlller
                                                  .inviteList[i].isInvited
                                              ? "Invited"
                                              : "Invite",
                                          width: 80,
                                          height: 35,
                                          textSize: 16,
                                          onPressed: () {
                                            (controlller
                                                    .inviteList[i].isInvited)
                                                ? Get.snackbar(
                                                    "Already Invited",
                                                    "You have already invited this person",
                                                    snackPosition:
                                                        SnackPosition.BOTTOM,
                                                    backgroundColor: Colors.red,
                                                    colorText: Colors.white,
                                                  )
                                                : controlller.inviteToGroup(
                                                    controlller
                                                        .inviteList[i].id,
                                                    widget.groupId!,
                                                  );
                                          },
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
