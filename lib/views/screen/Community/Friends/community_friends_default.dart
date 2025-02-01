import 'package:flutter/material.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/friend_requests.dart';
import 'package:zen_active/views/components/slidable_tab_bar.dart';

class CommunityFriendsDefault extends StatelessWidget {
  final Function(int)? onPageChanged;
  const CommunityFriendsDefault({super.key, this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Text(
              "Friends",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xff4B4B4B),
              ),
            ),
            const Spacer(),
            svgViewer(
              asset: "assets/svg/search.svg",
              color: Color(0xff4B4B4B),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        SlidableTabBar(
          options: ["Suggestion", "Your Friends"],
          index: -1,
          onChanged: (val) {
            if (val == 0) {
              if (onPageChanged != null) {
                onPageChanged!(3);
              }
            } else {
              if (onPageChanged != null) {
                onPageChanged!(4);
              }
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          child: const Divider(
            height: 0.5,
            color: Color(0xffDBE1E4),
          ),
        ),
        friendsOnlineSection(),
        const SizedBox(
          height: 32,
        ),
        friendRequestsSection(count: 155),
      ],
    );
  }

  Widget friendRequestsSection({int count = 52}) {
    return Column(
      spacing: 16,
      children: [
        GestureDetector(
          onTap: () {
            if (onPageChanged != null) {
              onPageChanged!(2);
            }
          },
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              Text(
                "Friend Requests",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff525252),
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
              const Spacer(),
              Text(
                "See All",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff525252),
                ),
              ),
              svgViewer(asset: "assets/svg/see_all.svg"),
            ],
          ),
        ),
        for (int i = 0; i < 3; i++) FriendRequests(i: i),
      ],
    );
  }

  Widget friendsOnlineSection({int count = 52}) {
    return Column(
      // spacing: 16,
      children: [
        GestureDetector(
          onTap: () {
            if (onPageChanged != null) {
              onPageChanged!(1);
            }
          },
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              Text(
                "Friends Online",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff525252),
                ),
              ),
              Text(
                " 132",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff1E648C),
                ),
              ),
              const Spacer(),
              Text(
                "See All",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff525252),
                ),
              ),
              svgViewer(asset: "assets/svg/see_all.svg"),
            ],
          ),
        ),
        for (int i = 0; i < 3; i++)
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 14,
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: Image.asset(
                        "assets/images/faces/${i + 4}.png",
                        height: 52,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          color: Color(0xff04AB04),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xfff6fafc),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "Random Name",
                  style: TextStyle(
                    color: Color(0xff222222),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 24,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Color(0xffDBE1E4),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: svgViewer(
                      asset: "assets/svg/chat_dark.svg",
                      height: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.more_horiz_rounded,
                  size: 16,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
