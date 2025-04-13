import 'package:flutter/material.dart';
import 'package:zenactive/utils/uitls.dart';

class MessageHighlightWidget extends StatelessWidget {
  final String? profilePic;
  final String name;
  final String lastMessage;
  final String time;
  final int unread;
  final Function(String)? onTap;
  const MessageHighlightWidget({
    super.key,
    this.profilePic,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unread = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!(name);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 24,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: Image.network(
                imageUrl(profilePic),
                height: 52,
                width: 52,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      color: Color(0xffE0E0E0),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Center(
                      child: Text(
                        name[0],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff222222),
                        ),
                      ),
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
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff222222),
                  ),
                ),
                Text(
                  lastMessage,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff525252),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff757575),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                (unread != 0)
                    ? Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffFFCACA),
                        ),
                        child: Center(
                          child: Text(
                            unread.toString(),
                            style: TextStyle(
                              fontSize: 11,
                              height: 1.7,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffCC0D0D),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 16,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String dateFormater(DateTime time) {
    return "2 min ago";
  }
}
