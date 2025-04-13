// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:zenactive/services/gemini_service.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AIScreen extends StatefulWidget {
  final Function()? goBack;
  const AIScreen({super.key, this.goBack});

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {
  List<AiChatBubble> messages = [
    AiChatBubble(
      message:
          "Hi there! I’m FitBot, your personal fitness assistant. How can I help you today? You can ask me about workouts, nutrition, recovery tips, and more!",
    ),
  ]; // Move messages list to class-level
  TextEditingController messageController = TextEditingController();
  bool isLoading = false;

  // void getMessageFromGemini(String message) async {
  //   final modifiedMessage =
  //       "Act like a FitBot, whenever you want to talk to me,talk to me as Fitbot Ai, whenever someone ask me anything that no related to Fitness , you ask people to ask about fitness.";
  //   setState(() {
  //     isLoading = true;
  //   });

  // GeminiService().prompt(message).then((response) {
  //   if (response != null) {
  //     setState(() {
  //       messages.insert(0, AiChatBubble(message: response, isMarkdown: true));
  //     });
  //   }

  //   setState(() {
  //     isLoading = false;
  //   });
  // });
  // }
  void getMessageFromGemini(String message) async {
    final modelPrompt =
        "You are FitBot AI, a dedicated fitness assistant. Your purpose is to provide expert advice on workouts, nutrition, recovery, and fitness-related topics. Always respond as FitBot AI, maintaining an informative and engaging tone. If a user asks a question unrelated to fitness, politely redirect them by encouraging them to ask about workouts, nutrition, or recovery instead. Only respond to queries related to fitness and chatbot features.";

    setState(() {
      isLoading = true;
    });

    GeminiService().chat([
      Content(
        parts: [Part.text(modelPrompt)],
        role: "model", // Ensure it behaves like a system directive.
      ),
      Content(
        parts: [Part.text(message)],
        role: "user",
      ),
    ]).then((response) {
      if (response != null) {
        setState(() {
          messages.insert(0, AiChatBubble(message: response, isMarkdown: true));
        });
      }

      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      ('Chat error: $error').printError();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "FitBot AI"),
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length + (isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (isLoading && index == 0) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return messages[isLoading ? index - 1 : index];
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(color: Color(0xfffefeff)),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Color(0xffF1F7FA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller:
                                  messageController, // Use persistent controller
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type a message...",
                              ),
                            ),
                          ),
                          svgViewer(asset: "assets/svg/emoji.svg"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      if (messageController.text.trim().isNotEmpty &&
                          !isLoading) {
                        setState(() {
                          messages.insert(
                            0,
                            AiChatBubble(
                              message: messageController.text,
                              isMe: true,
                            ),
                          );
                        });

                        // Call AI response function
                        getMessageFromGemini(messageController.text);

                        // Clear text field
                        messageController.clear();
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff2781b5),
                      ),
                      child: Center(
                        child: svgViewer(asset: "assets/svg/send.svg"),
                      ),
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

class AiChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final bool showImage;
  final bool isMarkdown;

  const AiChatBubble({
    super.key,
    required this.message,
    this.isMe = false,
    this.showImage = true,
    this.isMarkdown = false,
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
                     filterQuality: FilterQuality.none,
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
                    isMarkdown
                        ? MarkdownBody(data: message)
                        : Text(
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
