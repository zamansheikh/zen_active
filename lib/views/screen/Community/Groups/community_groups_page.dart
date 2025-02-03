import 'package:flutter/material.dart';
import 'package:zen_active/views/components/slidable_tab_bar.dart';
import 'package:zen_active/views/screen/Community/Groups/community_groups_discover.dart';
import 'package:zen_active/views/screen/Community/Groups/community_groups_posts.dart';
import 'package:zen_active/views/screen/Community/Groups/community_groups_your_groups.dart';

class CommunityGroupsPage extends StatefulWidget {
  const CommunityGroupsPage({super.key});

  @override
  State<CommunityGroupsPage> createState() => _CommunityGroupsPageState();
}

class _CommunityGroupsPageState extends State<CommunityGroupsPage> {
  int index = 0;
  List<Widget> initialPages = [
    CommunityGroupsYourGroups(),
    CommunityGroupsDiscover(),
    CommunityGroupsPosts(),
  ];

  @override
  Widget build(BuildContext context) {
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
  }
}
