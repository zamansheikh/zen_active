import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/community_group_controller.dart';
import 'package:zen_active/views/components/custom_search_bar.dart';
import 'package:zen_active/views/screen/Community/Groups/community_groups_create_group.dart';

class CommunityGroupsYourGroups extends StatelessWidget {
  const CommunityGroupsYourGroups({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: 16,
          children: [
            CustomSearchBar(
              hintText: "Search Group",
            ),
            InkWell(
              onTap: () {
                Get.find<CommunityGroupController>().push(CommunityGroupsCreateGroup());
              },
              child: Row(
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: Color(0xffC1E8FF),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add_rounded,
                        color: Color(0xff174C6B),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Create Group",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff4B4B4B),
                    ),
                  ),
                ],
              ),
            ),
            for (int i = 1; i <= 100; i++) groupNames("$i"),
          ],
        ),
      ),
    );
  }

  Row groupNames(String? name) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            "assets/images/offline_videos/1.png",
            height: 44,
            width: 44,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name ?? "Group Name",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff222222),
              ),
            ),
            Row(
              spacing: 4,
              children: [
                Text(
                  "25+ new posts",
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xff525252),
                  ),
                ),
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    color: Color(0xff32A5E8),
                    shape: BoxShape.circle,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
