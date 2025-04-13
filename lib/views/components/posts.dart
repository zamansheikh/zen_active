import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/community_group_controller.dart';
import 'package:zenactive/utils/text_bolder.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/screen/community/community_comment_page.dart';

class Posts extends StatelessWidget {
  const Posts({
    super.key,
    required this.userImage,
    required this.name,
    required this.time,
    required this.text,
    required this.likes,
    required this.comment,
    required this.postId,
    required this.isLiked,
    required this.toogleLike,
  });

  final String userImage;
  final String name;
  final String time;
  final String text;
  final int likes;
  final int comment;
  final String postId;
  final Function(bool) toogleLike;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffFEFEFF),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(
              15,
            ),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: Image.network(
                    userImage,
                    height: 32,
                    width: 32,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Color(0xff2D2D2D),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: Color(0xffAFAFAF),
                        fontSize: 10,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 0.5,
            color: Color(0xff37B5FF),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 20,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: textBolder(
                text,
                TextStyle(
                  fontSize: 14,
                  color: Color(0xff222222),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
            child: Row(
              children: [
                const SizedBox(width: 12),
                Text("💙 $likes Likes"),
                const Spacer(),
                Text("$comment Comments"),
                const SizedBox(width: 12),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      // Like Post
                      Get.find<CommunityGroupController>().toggleLike(
                          postId: postId,
                          onToggle: (value) {
                            toogleLike(value);
                          });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!isLiked)
                          svgViewer(
                            asset: "assets/svg/like.svg",
                            height: 16,
                          )
                        else
                          svgViewer(
                            asset: "assets/svg/liked.svg",
                            height: 16,
                          ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Like",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xff4B4B4B),
                            height: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  width: 1,
                  color: Color(0xff757575),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => CommunityCommentPage(postId: postId));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        svgViewer(
                          asset: "assets/svg/comment.svg",
                          height: 16,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Comment",
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xff4B4B4B),
                            height: 4,
                          ),
                        ),
                      ],
                    ),
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
