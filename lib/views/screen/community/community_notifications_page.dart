import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:zen_active/controllers/community_group_controller.dart';
import 'package:zen_active/models/notification_model.dart';
import 'package:zen_active/utils/text_bolder.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_button.dart';

class CommunityNotificationsPage extends StatelessWidget {
  const CommunityNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CommunityGroupController();
    controller.fetchNotifications();
    return SingleChildScrollView(
      child: Obx(() {
        return Column(
          children: controller.notificationList
              .map(
                (notification) => notificationType(notification),
              )
              .toList(),
        );
      }),
    );
  }

  Widget notificationType(NotificationModel data) {
    switch (data.type) {
      case "like":
        return notification(
          imageUrl(data.senderId!.image!),
          text: data.message,
          isAcceptable: false,
          hasViewed: data.isRead!,
          isJoinable: false,
          onTap: () {
            Get.find<CommunityGroupController>().readNofication(data.id!);
          },
        );

      case "comment":
        return notification(
          imageUrl(data.senderId!.image!),
          text: data.message,
          isAcceptable: false,
          hasViewed: data.isRead!,
          isJoinable: false,
          onTap: () {
            print("Marks as read");
          },
        );
      case "friend_request":
        return notification(
          imageUrl(data.senderId!.image!),
          id: data.id,
          text: data.message,
          isAcceptable: true,
          hasViewed: data.isRead!,
          isJoinable: false,
          onTap: () {
            print("Marks as read");
          },
          onAccept: () {
            print("Accept");
          },
          onReject: () {
            print("Reject");
          },
        );
      case "join_group_request":
        return notification(
          imageUrl(data.senderId!.image!),
          id: data.id,
          text: data.message,
          isAcceptable: false,
          hasViewed: data.isRead!,
          isJoinable: true,
          onTap: () {
            print("Marks as read");
          },
          onAccept: () {
            print("Join Group");
          },
          onReject: () {
            print("Reject Group");
          },
        );
      default:
        return notification(
          imageUrl(data.senderId!.image!),
          text: data.message,
          isAcceptable: false,
          hasViewed: data.isRead!,
          isJoinable: false,
        );
    }
  }

  Widget notification(String photo,
      {String? id,
      String? text,
      bool isAcceptable = false,
      bool hasViewed = false,
      bool isJoinable = false,
      Function()? onTap,
      Function()? onAccept,
      Function()? onReject}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 96,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        color: hasViewed ? null : Color(0xffdbf1ff),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: Image.network(
                photo,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/logo/zen_logo.png",
                    height: 80,
                    width: 80,
                  );
                },
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textBolder(
                    text ?? "`User` sent you a friend Request",
                    TextStyle(
                      color: Color(0xff222222),
                      fontSize: 16,
                    ),
                  ),
                  if (isAcceptable || isJoinable)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                                buttonName: isJoinable ? "Join" : "Accept",
                                height: 35,
                                textSize: 16,
                                onPressed: onAccept),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: CustomButton(
                              buttonName: "Delete",
                              height: 35,
                              textSize: 16,
                              isSecondary: true,
                              onPressed: onReject,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
