import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/community_group_controller.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_loading.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xffFEFEFF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Comments ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff222222),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Obx(() {
            return Get.find<CommunityGroupController>().isLoading.value
                ? Center(child: CustomLoading())
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 8,
                        children: [
                          for (int i = 0;
                              i <
                                  Get.find<CommunityGroupController>()
                                      .postList
                                      .length;
                              i++)
                            comment(
                              Get.find<CommunityGroupController>()
                                  .postList[i]
                                  .user!
                                  .name!
                                  .firstName!,
                              Get.find<CommunityGroupController>()
                                  .postList[i]
                                  .text!,
                              imageUrl(Get.find<CommunityGroupController>()
                                  .postList[i]
                                  .user!
                                  .image!),
                            ),
                        ],
                      ),
                    ),
                  );
          }),
          Container(
            height: 1,
            color: Color(0xff79CDFF),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: Color(0xffFEFEFF),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: Image.asset(
                    "assets/images/faces/4.png",
                    height: 24,
                    width: 24,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0xffDBE1E4),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Transform.translate(
                      offset: Offset(0, -9),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Add a comment",
                            hintStyle: TextStyle(
                              fontSize: 11,
                              color: Color(0xff656869),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
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

  Widget comment(String name, String comment, String userDp) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Image.network(
              userDp,
              height: 24,
              width: 24,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.amber,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff222222),
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  comment,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff525252),
                    height: 1,
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
