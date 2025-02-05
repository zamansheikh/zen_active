import 'package:flutter/material.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/friend_requests.dart';
import 'package:zen_active/views/components/slidable_tab_bar.dart';

class CommunityFriendsSuggestion extends StatelessWidget {
  final Function(int) onPageChanged;
  const CommunityFriendsSuggestion({
    super.key,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                onPageChanged(0);
              },
              child: Transform.translate(
                offset: Offset(0, -2),
                child: svgViewer(
                  asset: "assets/svg/arrow_back_2.svg",
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: SlidableTabBar(
                options: ["Suggestion", "Your Friends"],
                index: 0,
                onChanged: (val) {
                  if (val == 1) {
                    onPageChanged(4);
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < 100; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: FriendRequests(
                      i: i % 10,
                      isAddFreind: true,
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
