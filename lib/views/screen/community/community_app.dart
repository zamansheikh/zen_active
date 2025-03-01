import 'package:flutter/material.dart';
import 'package:zen_active/views/components/community_app_bar.dart';
import 'package:zen_active/views/screen/community/Groups/community_groups_page.dart';
import 'package:zen_active/views/screen/community/community_feed_page.dart';
import 'package:zen_active/views/screen/community/Friends/community_friends_page.dart';
import 'package:zen_active/views/screen/community/community_messages_page.dart';
import 'package:zen_active/views/screen/community/community_notifications_page.dart';

class CommunityApp extends StatefulWidget {
  const CommunityApp({super.key});

  @override
  State<CommunityApp> createState() => _CommunityAppState();
}

class _CommunityAppState extends State<CommunityApp> {
  PageController controller = PageController(
    initialPage: 0,
    keepPage: false,
  );
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            CommunityAppBar(
              index: index,
              onTap: (newIndex) {
                setState(() {
                  index = newIndex;
                });

                controller.animateToPage(
                  newIndex,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.decelerate,
                );
              },
            ),
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                children: [
                  CommunityFeedPage(),
                  CommunityFriendsPage(),
                  CommunityMessagesPage(),
                  CommunityGroupsPage(),
                  CommunityNotificationsPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
