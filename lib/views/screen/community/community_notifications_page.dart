import 'package:flutter/material.dart';
import 'package:zen_active/utils/text_bolder.dart';
import 'package:zen_active/views/components/custom_button.dart';

class CommunityNotificationsPage extends StatelessWidget {
  const CommunityNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          notification(
            0,
            text:
                "`Jane Cooper` invited you to join in the public group `Mobility Masters`",
            isJoinable: true,
            hasViewed: true,
          ),
          notification(
            1,
            text: "`Wade Warren` likes your post",
          ),
          notification(
            2,
            text: "`Robert Jones` sent you a friend request",
            isAcceptable: true,
          ),
          notification(
            3,
            text: "`Cody Fisher` commented on your post",
          ),
          notification(
            4,
            text: "`Ema Wilson` sent you a friend request",
            isAcceptable: true,
          ),
          notification(5, text: "`Albert Flores` likes your post"),
          notification(
            6,
            text:
                "`Ralph Bell` invited you to join in the public group `Flex and Flow`",
                isJoinable: true,
          ),
          notification(
            7,
            text: "`Shamsuzzaman` betrayed his freind",
    
          ),
        ],
      ),
    );
  }

  Container notification(int i,
      {String? text,
      bool isAcceptable = false,
      bool hasViewed = false,
      bool isJoinable = false}) {
    return Container(
      height: 96,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      color: hasViewed ? null : Color(0xffdbf1ff),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Image.asset(
              "assets/images/faces/${i + 1}.png",
              height: 80,
              width: 80,
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
                          ),
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
    );
  }
}
