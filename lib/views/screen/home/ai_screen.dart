// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';

class AIScreen extends StatelessWidget {
  final Function()? goBack;
  const AIScreen({super.key, this.goBack});

  @override
  Widget build(BuildContext context) {
    List<AiChatBubble> messages = [
      AiChatBubble(
        message:
            "Hi there! I’m FitBot, your personal fitness assistant. How can I help you today? You can ask me about workouts, nutrition, recovery tips, and more!",
      ),
      AiChatBubble(
        message: "What should I eat after a workout?",
        isMe: true,
      ),
      AiChatBubble(
        message:
            "After a workout, it’s great to have a mix of protein and carbs. Try options like chicken with rice or a smoothie with whey protein. Want me to suggest recipes?",
      ),
      AiChatBubble(
        message: "Yes, please!",
        isMe: true,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "FitBot AI",
            ),
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    for (int i = 0; i < messages.length; i++) messages[i]
                  ],
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
                    child:
                        Center(child: svgViewer(asset: "assets/svg/send.svg")),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AiChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final bool showImage;

  const AiChatBubble({
    super.key,
    required this.message,
    this.isMe = false,
    this.showImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (!isMe)
              Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: svgViewer(asset: "assets/svg/gemini.svg", height: 40),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: Image.asset(
                    "assets/images/faces/1.png",
                    height: 40,
                  ),
                ),
              ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(12),
                    bottomRight: const Radius.circular(12),
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isMe
                        ? Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "You",
                              style: TextStyle(
                                color: Color(0xff2D2D2D),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "FitBot AI",
                              style: TextStyle(
                                color: Color(0xff2D2D2D),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      message,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Color(0xff2D2D2D),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
