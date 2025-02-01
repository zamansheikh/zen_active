import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/message_highlight_widget.dart';

class CommunityMessagesPage extends StatefulWidget {
  const CommunityMessagesPage({super.key});

  @override
  State<CommunityMessagesPage> createState() => _CommunityMessagesPageState();
}

class _CommunityMessagesPageState extends State<CommunityMessagesPage> {
  String? selectedAccount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          selectedAccount == null
              ? Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 14,
                        ),
                        for (int i = 0; i < 100; i++)
                          MessageHighlightWidget(
                            profilePic: "assets/images/faces/${i % 10 + 1}.png",
                            name: "Devon Lane",
                            lastMessage: "Tell me about your fitness journey",
                            time: DateTime(2025, 2, 1, 10, 5),
                            unread: i < 3 ? i + 2 : 0,
                            onTap: (p0) {
                              setState(() {
                                selectedAccount = p0;
                              });
                            },
                          ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: ChatScreen(
                    goBack: () {
                      setState(() {
                        selectedAccount = null;
                      });
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final Function()? goBack;
  const ChatScreen({super.key, this.goBack});

  @override
  Widget build(BuildContext context) {
    List<ChatBubble> messages = [
      ChatBubble(message: "Hello! Nazrul How are you?", isMe: false),
      ChatBubble(message: "You did your job well!", isMe: true),
      ChatBubble(message: "Have a great working week!!", isMe: false),
      ChatBubble(message: "Hope you like it", isMe: false),
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: Row(
            children: [
              const SizedBox(
                width: 24,
              ),
              GestureDetector(
                onTap: goBack,
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
                    child: Image.asset(
                      "assets/images/faces/1.png",
                      height: 44,
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
                    "Devon Lane",
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
              Icon(
                Icons.more_vert_outlined,
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
        Expanded(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [for (int i = 0; i < messages.length; i++) messages[i]],
            ),
          ),
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
                          controller: TextEditingController(text: "Make"),
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
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff2781b5),
                ),
                child: Center(child: svgViewer(asset: "assets/svg/send.svg")),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 22,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: Image.asset(
                  "assets/images/faces/1.png",
                  height: 40,
                ),
              ),
            ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              color: isMe ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: isMe ? const Radius.circular(12) : Radius.zero,
                bottomRight: isMe ? Radius.zero : const Radius.circular(12),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
