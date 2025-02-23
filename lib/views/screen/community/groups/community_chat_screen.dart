import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/auth_controller.dart';
import 'package:zen_active/controllers/community_feed_controller.dart';
import 'package:zen_active/controllers/message_controller.dart';
import 'package:zen_active/models/my_friend_model.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_loading.dart';
import 'package:zen_active/views/screen/community/community_messages_page.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key, required this.friend});
  final MyFriendModel friend;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  OverlayEntry? _overlayEntry;

  void _showFloatingMenu(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: _removeOverlay,
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Positioned(
            right: 24,
            top: 120,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 250,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: svgViewer(asset: "assets/svg/block.svg"),
                      title: Text("Block Devon"),
                      onTap: () {
                        _removeOverlay();
                      },
                    ),
                    Divider(
                      height: 0.5,
                      color: Color(0xff79CDFF),
                    ),
                    ListTile(
                      leading: svgViewer(asset: "assets/svg/unfriend.svg"),
                      title: Text("Remove Devon"),
                      onTap: () {
                        // handle Option 2 action
                        _removeOverlay();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  final CommunityFeedController communityFeedController = Get.find();
  final MessageController messageController = Get.put(MessageController());

  @override
  void initState() {
    messageController.getAllMessage(id: widget.friend.id!);
    debugPrint("Friend ID: ${widget.friend.id}");
    messageController.listenMessage();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Row(
              children: [
                const SizedBox(
                  width: 24,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: svgViewer(
                    asset: "assets/svg/arrow_back_2.svg",
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: Image.network(
                        imageUrl(widget.friend.image),
                        fit: BoxFit.cover,
                        height: 44,
                        width: 44,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/images/faces/1.png",
                            height: 44,
                            width: 44,
                          );
                        },
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
                  width: 18,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.friend.name != null
                          ? '${widget.friend.name!.firstName} ${widget.friend.name!.lastName}'
                          : 'No Name',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff222222),
                      ),
                    ),
                    Text(
                      "Active Now",
                      style: TextStyle(
                        fontSize: 13,
                        height: 0.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff757575),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    _showFloatingMenu(context);
                  },
                  child: Icon(
                    Icons.more_vert_outlined,
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(
              0xffDBE1E4,
            ),
          ),
          Obx(
            () {
              return messageController.isLoading.value
                  ? Expanded(
                      child: Center(
                        child: CustomLoading(),
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        reverse: true,
                        child: Column(
                          children: [
                            for (int i = 0;
                                i <
                                    messageController
                                        .messages.value.userChat!.length;
                                i++)
                              ChatBubble(
                                message: messageController
                                    .messages.value.userChat![i].message!,
                                isMe: messageController.messages.value
                                        .userChat![i].senderId!.id !=
                                    widget.friend.id,
                                showTime: true,
                                time: DateTime.parse(messageController
                                    .messages.value.userChat![i].createdAt!),
                              ),
                          ],
                        ),
                      ),
                    );
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            decoration: BoxDecoration(
              color: Color(0xfffefeff),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffF1F7FA),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: messageController.textController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        svgViewer(
                          asset: "assets/svg/emoji.svg",
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                InkWell(
                  onTap: () {
                    messageController.sendMessage(
                        rcvId: widget.friend.id!,
                        message: messageController.textController.text,
                        senderId: Get.find<AuthController>().user.value.id!);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff2781b5),
                    ),
                    child:
                        Center(child: svgViewer(asset: "assets/svg/send.svg")),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
