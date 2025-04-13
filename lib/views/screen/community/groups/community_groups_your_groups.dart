import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/community_group_controller.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_search_bar.dart';
import 'package:zenactive/views/screen/community/Groups/community_groups_create_group.dart';
import 'package:zenactive/views/screen/community/groups/community_group_details.dart';

class CommunityGroupsYourGroups extends StatefulWidget {
  const CommunityGroupsYourGroups({super.key});

  @override
  State<CommunityGroupsYourGroups> createState() =>
      _CommunityGroupsYourGroupsState();
}

class _CommunityGroupsYourGroupsState extends State<CommunityGroupsYourGroups> {
  @override
  void initState() {
    Get.find<CommunityGroupController>().getAllMyGroups();
    super.initState();
  }

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
              controller: TextEditingController(),
              hintText: "Search Group",
            ),
            InkWell(
              onTap: () {
                Get.find<CommunityGroupController>()
                    .push(CommunityGroupsCreateGroup());
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
            Obx(() {
              return Get.find<CommunityGroupController>().isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      spacing: 15,
                      children: Get.find<CommunityGroupController>()
                          .myGroups
                          .map((e) => groupNames(
                              e.name, imageUrl(e.image), e.newPost, e.id))
                          .toList(),
                    );
            }),
          ],
        ),
      ),
    );
  }

  Widget groupNames(
      String? name, String? groupImage, int? newPosts, String? id) {
    return GestureDetector(
      onTap: () {
        Get.to(() => CommunityGroupDetails(groupId: id!));
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              groupImage ?? "https://via.placeholder.com/150",
              height: 44,
              width: 44,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 44,
                  width: 44,
                  color: Colors.grey,
                  child: Center(
                    child: Icon(
                      Icons.error_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                );
              },
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
                    "${newPosts ?? 0}+ new posts",
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
      ),
    );
  }
}
