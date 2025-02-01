import 'package:flutter/material.dart';
import 'package:zen_active/views/components/community_app_bar.dart';
import 'package:zen_active/views/screen/Community/community_feed_page.dart';

class CommunityApp extends StatefulWidget {
  const CommunityApp({super.key});

  @override
  State<CommunityApp> createState() => _CommunityAppState();
}

class _CommunityAppState extends State<CommunityApp> {
  PageController controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CommunityAppBar(
              index: index,
              onTap: (newIndex) {
                setState(() {
                  index = newIndex;
                });

                controller.animateToPage(newIndex,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.bounceIn);
              },
            ),
            Expanded(
              child: PageView(
                controller: controller,
                children: [
                  CommunityFeedPage(),
                  Text("Friends"),
                  Text("Messages"),
                  Text("Groups"),
                  Text("Notifications"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
