import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/community_feed_controller.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_button.dart';

class FriendRequests extends StatelessWidget {
  final bool isAddFreind;
  const FriendRequests({
    super.key,
    required this.image,
    this.isAddFreind = false,
    required this.name,
    required this.userId,
  });

  final String image;
  final String name;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: Image.network(
            imageUrl(image),
            height: 80,
            width: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(999),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: Color(0xff222222),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                CustomButton(
                  buttonName: isAddFreind ? "Add Friend" : "Confirm",
                  height: 35,
                  width: 125,
                  textSize: 16,
                  onPressed: () {
                    if (isAddFreind) {
                      Get.find<CommunityFeedController>().sendRequest(
                        userId: userId,
                      );
                    } else {
                      Get.find<CommunityFeedController>().confirmFriendRequest(
                        userId: userId,
                      );
                    }
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                CustomButton(
                  buttonName: "Remove",
                  height: 35,
                  width: 125,
                  textSize: 16,
                  isSecondary: true,
                  onPressed: () {
                    if (isAddFreind) {
                      // Remove friend
                    } else {
                      // Cancel friend request
                    }
                  },
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
