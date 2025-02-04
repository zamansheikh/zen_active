import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/community_group_controller.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_search_bar.dart';
import 'package:zen_active/views/screen/Community/Groups/community_groups_cover_photo.dart';

class CommunityGroupsInvite extends StatelessWidget {
  final bool hasNext;
  const CommunityGroupsInvite({super.key, this.hasNext = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CustomAppBar(
              title: "Invite People",
              overridedBackFunction: () {
                Get.find<CommunityGroupController>().pop();
              },
            ),
            if(hasNext)
            Positioned(
              right: 12,
              top: 12,
              child: TextButton(
                onPressed: () {
                  Get.find<CommunityGroupController>().push(CommunityGroupsCoverPhoto());
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < 40; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(999),
                                  child: Image.asset(
                                    "assets/images/faces/1.png",
                                    height: 52,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "Profile Name",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff222222),
                                  ),
                                ),
                                const Spacer(),
                                CustomButton(
                                  buttonName: "Invite",
                                  width: 80,
                                  height: 35,
                                  textSize: 16,
                                ),
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
    );
  }
}
