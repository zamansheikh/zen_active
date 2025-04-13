import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/auth_controller.dart';
import 'package:zenactive/controllers/community_group_controller.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_loading.dart';
import 'package:zenactive/views/components/posts.dart';

class CommunityGroupsPosts extends StatefulWidget {
  final String? groupId;
  const CommunityGroupsPosts({super.key, this.groupId});

  @override
  State<CommunityGroupsPosts> createState() => _CommunityGroupsPostsState();
}

class _CommunityGroupsPostsState extends State<CommunityGroupsPosts> {
  final CommunityGroupController communityController = Get.find();
  @override
  void initState() {
    communityController.getAllPostAllGroup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          communityController.getAllPostAllGroup();
        },
        child: Obx(() {
          if (communityController.isLoading.value) {
            return CustomLoading(color: AppColors.primaryColor);
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 5),
            itemCount: communityController.allGroupPosts.length,
            itemBuilder: (context, index) {
              final post = communityController.allGroupPosts[index];
              RxBool isLiked = post.likes!
                  .map((x) => x.userId)
                  .contains(Get.find<AuthController>().user.value.id)
                  .obs;
              RxInt likes = post.likes!.length.toInt().obs;
              return Column(
                children: [
                  Obx(() {
                    return Posts(
                      toogleLike: (p0) {
                        isLiked.value = p0;
                        if (p0) {
                          likes.value++;
                        } else {
                          likes.value--;
                        }
                      },
                      userImage: imageUrl(post.user!.image!),
                      postId: post.id!,
                      name:
                          "${post.user!.name!.firstName!} ${post.user!.name!.lastName!}",
                      time: post.createdAt!.toString(),
                      text: post.text!,
                      likes: likes.value,
                      isLiked: isLiked.value,
                      comment: post.comments!.length.toInt(),
                    );
                  }),
                  const SizedBox(height: 16),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
