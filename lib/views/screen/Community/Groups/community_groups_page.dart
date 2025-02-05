import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/community_group_controller.dart';
import 'package:zen_active/views/components/slidable_tab_bar.dart';
import 'package:zen_active/views/screen/community/Groups/community_groups_your_groups.dart';
import 'package:zen_active/views/screen/community/groups/community_groups_discover.dart';
import 'package:zen_active/views/screen/community/groups/community_groups_posts.dart';

class CommunityGroupsPage extends StatefulWidget {
  const CommunityGroupsPage({super.key});

  @override
  State<CommunityGroupsPage> createState() => _CommunityGroupsPageState();
}

class _CommunityGroupsPageState extends State<CommunityGroupsPage> {
  int index = 0;
  late CommunityGroupController controller;
  List<Widget> initialPages = [
    CommunityGroupsYourGroups(),
    CommunityGroupsDiscover(),
    CommunityGroupsPosts(),
  ];

  @override
  void initState() {
    super.initState();
    controller = Get.find<CommunityGroupController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.customPages.isNotEmpty) {
        return controller.customPages[controller.customPages.length - 1];
      }
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 24,
              top: 24,
              right: 24,
              bottom: 20,
            ),
            child: SlidableTabBar(
              options: ["Your Groups", "Discover", "Posts"],
              index: index,
              onChanged: (p0) {
                setState(() {
                  index = p0;
                });
              },
            ),
          ),
          Expanded(
            child: initialPages[index % initialPages.length],
          ),
        ],
      );
    });
  }
}
