import 'package:flutter/material.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/friend_requests.dart';

class CommunityFriendsRequests extends StatelessWidget {
  final Function(int) onPageChanged;
  const CommunityFriendsRequests({super.key, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
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
            Text(
              "Friend Requests",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff4B4B4B),
              ),
            ),
            Text(
              " 122",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff1E648C),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < 100; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: FriendRequests(i: i % 10),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
