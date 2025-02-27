import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/community_group_controller.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_loading.dart';
import 'package:zen_active/views/components/posts.dart';

class CommunityGroupsPosts extends StatefulWidget {
  const CommunityGroupsPosts({super.key});

  @override
  State<CommunityGroupsPosts> createState() => _CommunityGroupsPostsState();
}

class _CommunityGroupsPostsState extends State<CommunityGroupsPosts> {
  final CommunityGroupController communityController = Get.find();
  @override
  void initState() {
    communityController.getAllPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: 16,
          children: [
            Obx(() {
              if (communityController.isLoading.value) {
                return CustomLoading(color: AppColors.primaryColor);
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: communityController.postList.length,
                itemBuilder: (context, index) {
                  final post = communityController.postList[index];
                  return Column(
                    children: [
                      Posts(
                        userImage: imageUrl(post.user!.image!),
                        postId: post.id!,
                        name:
                            "${post.user!.name!.firstName!} ${post.user!.name!.lastName!}",
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
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
