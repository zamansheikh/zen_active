import 'package:flutter/material.dart';
import 'package:zen_active/utils/uitls.dart';

class CommunityFriendsOnline extends StatelessWidget {
  final Function(int) onPageChanged;
  const CommunityFriendsOnline({super.key, required this.onPageChanged});

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
              "Friend Online",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff4B4B4B),
              ),
            ),
            Text(
              " 23",
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
                                "assets/images/faces/${(i % 9)+1}.png",
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
            ),
          ),
        ),
      ],
    );
  }
}
