import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/auth_controller.dart';
import 'package:zen_active/controllers/community_feed_controller.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_loading.dart';
import 'package:zen_active/views/components/posts.dart';
import 'package:zen_active/views/screen/community/community_post_page.dart';

class CommunityFeedPage extends StatelessWidget {
  const CommunityFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CommunityFeedController communityFeedController = Get.find();
    return RefreshIndicator(
      onRefresh: () async {
        communityFeedController.getAllPost();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            spacing: 16,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: Image.network(
                        imageUrl(Get.find<AuthController>().user.value.image!),
                        height: 40,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/images/faces/1.png",
                            height: 40,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        Get.to(CommunityPostPage());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xffFEFEFF),
                          border: Border.all(color: Color(0xff79CDFF)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Share your fitness journey.........",
                            style:
                                TextStyle(color: Color(0xffAFAFAF), height: 3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (communityFeedController.isLoading.value) {
                  return CustomLoading(color: AppColors.primaryColor);
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: communityFeedController.postList.length,
                  itemBuilder: (context, index) {
                    final post = communityFeedController.postList[index];
                    return Column(
                      children: [
                        Posts(
                          postId: post.id!,
                          userImage: imageUrl(post.userInfo!.image!),
                          name:
                              "${post.userInfo!.name!.firstName!} ${post.userInfo!.name!.lastName!}",
                          time: post.createdAt!,
                          text: post.text!,
                          likes: post.likes!.length.toInt(),
                          comment: post.comments!.length.toInt(),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                );
              }),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
