import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:zenactive/controllers/auth_controller.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_loading.dart';
import 'package:zenactive/views/components/posts.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/controllers/community_group_controller.dart';
import 'package:zenactive/views/screen/community/community_post_page.dart';
import 'package:zenactive/views/screen/community/groups/community_group_information.dart';
import 'package:zenactive/views/screen/community/groups/community_groups_invite.dart';

class CommunityGroupDetails extends StatefulWidget {
  final String groupId;
  const CommunityGroupDetails({super.key, required this.groupId});

  @override
  State<CommunityGroupDetails> createState() => _CommunityGroupDetailsState();
}

class _CommunityGroupDetailsState extends State<CommunityGroupDetails> {
  late final CommunityGroupController _controller;
  late Future<void> _fetchFuture;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<CommunityGroupController>();
    _fetchFuture = _controller.fetchSingleGroupData(widget.groupId);
    _controller.getAllPost(widget.groupId); // Fetch posts for the group
  }

  Future<void> _refreshGroupInfo() async {
    await _controller.fetchSingleGroupData(widget.groupId);
    await _controller.getAllPost(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              overridedBackFunction: () {
                if (_controller.customPages.isNotEmpty) {
                  _controller.pop();
                } else {
                  _controller.clearGroupInfo();
                  Get.back();
                }
              },
            ),
            Expanded(
              child: FutureBuilder<void>(
                future: _fetchFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CustomLoading());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final groupInfo = _controller.groupInfo.value;
                    if (groupInfo.id == null) {
                      return const Center(child: Text("No data found."));
                    }
                    return RefreshIndicator(
                      onRefresh: _refreshGroupInfo,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Image.network(
                              imageUrl(groupInfo.image ?? imageUrl(null)),
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  "assets/images/challenges/2.png",
                                  height: 200,
                                   filterQuality: FilterQuality.none,
                                  width: double.infinity,
                                  fit: BoxFit.fitWidth,
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 28,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    groupInfo.name!,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 29,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                      "${groupInfo.type!} Group · ${groupInfo.totalMembers!} members"),
                                  const SizedBox(height: 24),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomButton(
                                          buttonName: "Information",
                                          leadingIcon:
                                              "assets/svg/information.svg",
                                          height: 40,
                                          textSize: 16,
                                          onPressed: () async {
                                            await Get.to(() =>
                                                CommunityGroupInformation(
                                                    groupId: widget.groupId));
                                            await _refreshGroupInfo();
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 18),
                                      Expanded(
                                        child: CustomButton(
                                          buttonName: "Invite",
                                          leadingIcon: "assets/svg/invite.svg",
                                          isSecondary: true,
                                          height: 40,
                                          textSize: 16,
                                          onPressed: () {
                                            Get.to(() => CommunityGroupsInvite(
                                                groupId: widget.groupId));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(999),
                                        child: Image.network(
                                          imageUrl(Get.find<AuthController>()
                                              .user
                                              .value
                                              .image!),
                                          height: 40,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: const Color(0xffDBE1E4),
                                                borderRadius:
                                                    BorderRadius.circular(999),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(() => CommunityPostPage(
                                                groupId: widget.groupId));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffFEFEFF),
                                              border: Border.all(
                                                color: const Color(0xff79CDFF),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Write something",
                                                style: TextStyle(
                                                    color: Color(0xffAFAFAF),
                                                    height: 3),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  Obx(() {
                                    if (_controller.isLoading.value) {
                                      return CustomLoading();
                                    }

                                    if (_controller.postList.isEmpty) {
                                      return const Center(
                                          child: Text("No posts available."));
                                    }

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: _controller.postList.length,
                                      itemBuilder: (context, index) {
                                        final post =
                                            _controller.postList[index];

                                        RxBool isLiked = post.likes!
                                            .map((x) => x.id)
                                            .contains(Get.find<AuthController>()
                                                .user
                                                .value
                                                .id)
                                            .obs;
                                        return Column(
                                          children: [
                                            Obx(() {
                                              return Posts(
                                                toogleLike: (p0) {
                                                  isLiked.value = p0;
                                                },
                                                postId: post.id!,
                                                userImage:
                                                    imageUrl(post.user!.image!),
                                                isLiked: isLiked.value,
                                                name:
                                                    "${post.user!.name!.firstName!} ${post.user!.name!.lastName!}",
                                                time:
                                                    post.createdAt!.toString(),
                                                text: post.text!,
                                                likes:
                                                    post.likes!.length.toInt(),
                                                comment: post.comments!.length
                                                    .toInt(),
                                              );
                                            }),
                                            const SizedBox(height: 16),
                                          ],
                                        );
                                      },
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
