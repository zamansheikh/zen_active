import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:zenactive/controllers/community_group_controller.dart';
import 'package:zenactive/models/my_friend_model.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_loading.dart';
import 'package:zenactive/views/components/message_highlight_widget.dart';
import 'package:zenactive/views/screen/community/groups/community_chat_screen.dart';

class CommunityMessagesPage extends StatefulWidget {
  const CommunityMessagesPage({super.key});

  @override
  State<CommunityMessagesPage> createState() => _CommunityMessagesPageState();
}

class _CommunityMessagesPageState extends State<CommunityMessagesPage> {
  final controller = Get.find<CommunityGroupController>();
  @override
  void initState() {
    //Flutter Add post frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getLastMesssage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.getLastMesssage();
    return Scaffold(
      body: Obx(() {
        return Column(
          children: [
            controller.isLoading.value
                ? Center(child: CustomLoading())
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 14,
                          ),
                          for (int i = 0;
                              i < controller.lastMessages.length;
                              i++)
                            MessageHighlightWidget(
                              profilePic: controller
                                  .lastMessages[i].friendDetails.image,
                              name:
                                  "${controller.lastMessages[i].friendDetails.name.firstName} ${controller.lastMessages[i].friendDetails.name.lastName}",
                              lastMessage:
                                  controller.lastMessages[i].lastMessage,
                              time: timeago
                                  .format(controller.lastMessages[i].time!),
                              unread: i < 3 ? i + 2 : 0,
                              onTap: (p0) {
                                Get.to(ConversationScreen(
                                    friend: MyFriendModel(
                                  id: controller
                                      .lastMessages[i].friendDetails.id,
                                  name: UserName(
                                      firstName: controller.lastMessages[i]
                                          .friendDetails.name.firstName,
                                      lastName: controller.lastMessages[i]
                                          .friendDetails.name.lastName),
                                  image: controller
                                      .lastMessages[i].friendDetails.image,
                                  connectionId:
                                      controller.lastMessages[i].connectionId,
                                )));
                              },
                            ),
                          const SizedBox(
                            height: 4,
                          ),
                        ],
                      ),
                    ),
                  )
          ],
        );
      }),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final String? usravatar;
  final bool isMe;
  final bool showImage;
  final bool showTime;
  final DateTime? time;

  const ChatBubble({
    super.key,
    required this.message,
    this.isMe = false,
    this.showImage = true,
    this.showTime = false,
    this.time,
    this.usravatar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isMe)
              Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                ),
                child: showImage
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: Image.network(
                          imageUrl(usravatar),
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 40,
                              width: 40,
                              color: Colors.grey,
                              child: Center(
                                child: Icon(
                                  Icons.error_outline_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox(
                        height: 40,
                        width: 40,
                      ),
              ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              decoration: BoxDecoration(
                color: isMe ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(12),
                  bottomRight: const Radius.circular(12),
                  topLeft: isMe ? const Radius.circular(12) : Radius.zero,
                  topRight: isMe ? Radius.zero : const Radius.circular(12),
                ),
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.white : Color(0xff2D2D2D),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        if (showTime)
          Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMe ? 32 : 96),
              child: Text(
                time != null ? "${time!.hour}:${time!.minute}" : "12:00",
                style: TextStyle(
                  color: Color(0xff797C7B),
                  fontSize: 10,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
