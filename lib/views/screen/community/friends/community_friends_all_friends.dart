//CommunityFriendsAllFriends

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/auth_controller.dart';
import 'package:zenactive/controllers/community_feed_controller.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_loading.dart';
import 'package:zenactive/views/components/slidable_tab_bar.dart';
import 'package:zenactive/views/screen/community/groups/community_chat_screen.dart';

class CommunityFriendsAllFriends extends StatelessWidget {
  final Function(int) onPageChanged;
  const CommunityFriendsAllFriends({
    super.key,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final CommunityFeedController communityFeedController = Get.find();
    //No need to call getMyFriend here, it called in controller init.
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                onPageChanged(0);
              },
              child: Transform.translate(
                offset: Offset(0, -2),
                child: svgViewer(
                  asset: "assets/svg/arrow_back_2.svg",
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: SlidableTabBar(
                options: ["Suggestion", "Your Friends"],
                index: 1,
                onChanged: (val) {
                  if (val == 0) {
                    onPageChanged(3);
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Obx(() {
          // Wrap the entire list with Obx
          return communityFeedController.isLoading.value
              ? Center(
                  child: CustomLoading(),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0;
                            i < communityFeedController.myFriends.length;
                            i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(999),
                                      child: Image.network(
                                        imageUrl(communityFeedController
                                                .myFriends[i].image ??
                                            ''), // Use friendDetails
                                        height: 52,
                                        width: 52,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            height: 52,
                                            width: 52,
                                            decoration: BoxDecoration(
                                              color: Colors.blueAccent,
                                              borderRadius:
                                                  BorderRadius.circular(999),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Obx(
                                      () => // Wrap with Obx for online status
                                          Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          height: 12,
                                          width: 12,
                                          decoration: BoxDecoration(
                                            color: Get.find<AuthController>()
                                                    .activeIds
                                                    .contains(
                                                        communityFeedController
                                                            .myFriends[i].id)
                                                ? Color(0xff04AB04)
                                                : Colors.grey, // Offline color
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Color(0xfff6fafc),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  '${communityFeedController.myFriends[i].name?.firstName ?? ''} ${communityFeedController.myFriends[i].name?.lastName ?? 'No Name'}', // Use friendDetails and handle nulls

                                  style: TextStyle(
                                    color: Color(0xff222222),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(ConversationScreen(
                                        friend: communityFeedController
                                            .myFriends[i]));
                                  },
                                  child: Container(
                                    height: 24,
                                    width: 32,
                                    decoration: BoxDecoration(
                                      color: Color(0xffDBE1E4),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: svgViewer(
                                        asset: "assets/svg/chat_dark.svg",
                                        height: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(999),
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        backgroundColor: Color(0xfffefeff),
                                        useSafeArea: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        builder: (context) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 24,
                                                  vertical: 16,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: Color(0xffDBE1E4),
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      999),
                                                          child: Image.asset(
                                                            "assets/images/faces/${(i % 9) + 1}.png", //This is a static image, you should use image from the api
                                                            height: 52,
                                                             filterQuality:
                                                                FilterQuality
                                                                    .none,
                                                          ),
                                                        ),
                                                        Obx(
                                                          () => Positioned(
                                                            // Wrap with Obx
                                                            bottom: 0,
                                                            right: 0,
                                                            child: Container(
                                                              height: 12,
                                                              width: 12,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: communityFeedController
                                                                        .myFriends[
                                                                            i]
                                                                        .isOnline
                                                                        .value // Use .value
                                                                    ? Color(
                                                                        0xff04AB04)
                                                                    : Colors
                                                                        .grey, // Offline color

                                                                shape: BoxShape
                                                                    .circle,
                                                                border:
                                                                    Border.all(
                                                                  color: Color(
                                                                      0xfff6fafc),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '${communityFeedController.myFriends[i].name?.firstName ?? ''} ${communityFeedController.myFriends[i].name?.lastName ?? 'No Name'}', // Use friendDetails
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff222222),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Friends since May 2024", //This is static, you should use dynamic date.
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff8B8B8B),
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 24),
                                                child: ListTile(
                                                  leading: svgViewer(
                                                    asset:
                                                        "assets/svg/messages.svg",
                                                    color: Color(0xff2D2D2D),
                                                  ),
                                                  title: Text(
                                                    "Message ${communityFeedController.myFriends[i].name?.firstName ?? 'User'}", // Use friendDetails
                                                    style: TextStyle(
                                                      color: Color(0xff2D2D2D),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 24),
                                                child: ListTile(
                                                  leading: svgViewer(
                                                      asset:
                                                          "assets/svg/block.svg"),
                                                  title: Text(
                                                    "Block ${communityFeedController.myFriends[i].name?.firstName ?? 'User'}", // Use friendDetails
                                                    style: TextStyle(
                                                      color: Color(0xff2D2D2D),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 24, bottom: 24),
                                                child: ListTile(
                                                  leading: svgViewer(
                                                      asset:
                                                          "assets/svg/unfriend.svg"),
                                                  title: Text(
                                                    "Unfriend ${communityFeedController.myFriends[i].name?.firstName ?? 'User'}", // Use friendDetails
                                                    style: TextStyle(
                                                      color: Color(0xffE71F1F),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Icon(
                                    Icons.more_horiz_rounded,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                );
        }),
      ],
    );
  }
}
