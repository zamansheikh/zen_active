import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/auth_controller.dart';
import 'package:zenactive/controllers/community_feed_controller.dart';
import 'package:zenactive/models/my_friend_model.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_loading.dart';
import 'package:zenactive/views/components/friend_requests.dart';
import 'package:zenactive/views/components/slidable_tab_bar.dart';
import 'package:zenactive/views/screen/community/groups/community_chat_screen.dart';

class CommunityFriendsDefault extends StatelessWidget {
  final Function(int)? onPageChanged;
  const CommunityFriendsDefault({super.key, this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    final CommunityFeedController communityController = Get.find();
    // if (WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
    //   communityController.getRequsted(type: "requestedList");
    // } else {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     communityController.getRequsted(type: "requestedList");
    //   });
    // }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      communityController.getRequsted(type: "requestedList");
      communityController.getMyFiends();
    });
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Text(
              "Friends",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xff4B4B4B),
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        SlidableTabBar(
          options: ["Suggestion", "Your Friends"],
          index: -1,
          onChanged: (val) {
            if (val == 0) {
              if (onPageChanged != null) {
                onPageChanged!(3);
              }
            } else {
              if (onPageChanged != null) {
                onPageChanged!(4);
              }
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          child: const Divider(
            height: 0.5,
            color: Color(0xffDBE1E4),
          ),
        ),
        friendsOnlineSection(context),
        const SizedBox(
          height: 32,
        ),
        friendRequestsSection(context),
      ],
    );
  }

  //! Community Page - Online Section 1st Half
  Widget friendsOnlineSection(BuildContext context) {
    final CommunityFeedController communityController = Get.find();

    List<MyFriendModel> friends = communityController.myFriends
        .where((friend) =>
            Get.find<AuthController>().activeIds.contains(friend.id))
        .toList();
    friends = friends.length > 3 ? friends.sublist(0, 3) : friends;
    return Obx(() => communityController.isLoading.value
        ? Center(child: CustomLoading())
        : Column(
            // spacing: 16,
            children: [
              GestureDetector(
                onTap: () {
                  if (onPageChanged != null) {
                    onPageChanged!(1);
                  }
                },
                behavior: HitTestBehavior.translucent,
                child: Row(
                  children: [
                    Text(
                      "Friends Online",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff525252),
                      ),
                    ),
                    Text(
                      " ${friends.length}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1E648C),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff525252),
                      ),
                    ),
                    svgViewer(asset: "assets/svg/see_all.svg"),
                  ],
                ),
              ),
              for (int i = 0; i < friends.length; i++)
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
                              imageUrl(friends[i].image!),
                              height: 52,
                              fit: BoxFit.cover,
                              width: 52,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 52,
                                  width: 52,
                                  color: Colors.grey,
                                  child: Center(
                                    child: Icon(
                                      Icons.error_outline_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                color: Color(0xff04AB04),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xfff6fafc),
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
                        "${friends[i].name!.firstName!} ${friends[i].name!.lastName!}",
                        style: TextStyle(
                          color: Color(0xff222222),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.to(ConversationScreen(friend: friends[i]));
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
                        borderRadius: BorderRadius.circular(9999),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Color(0xfffefeff),
                              useSafeArea: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
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
                                                    BorderRadius.circular(999),
                                                child: Image.network(
                                                  imageUrl(friends[i].image!),
                                                  height: 52,
                                                  fit: BoxFit.cover,
                                                  width: 52,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Container(
                                                      height: 52,
                                                      width: 52,
                                                      color: Colors.grey,
                                                      child: Center(
                                                        child: Icon(
                                                          Icons
                                                              .error_outline_rounded,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: Container(
                                                  height: 12,
                                                  width: 12,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff04AB04),
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Color(0xfff6fafc),
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
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${friends[i].name!.firstName!} ${friends[i].name!.lastName!}",
                                                style: TextStyle(
                                                  color: Color(0xff222222),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                "Friends since May 2024",
                                                style: TextStyle(
                                                  color: Color(0xff8B8B8B),
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24),
                                      child: ListTile(
                                        leading: svgViewer(
                                          asset: "assets/svg/messages.svg",
                                          color: Color(0xff2D2D2D),
                                        ),
                                        title: Text(
                                          "Message ${friends[i].name!.firstName!}",
                                          style: TextStyle(
                                            color: Color(0xff2D2D2D),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 24),
                                      child: ListTile(
                                        leading: svgViewer(
                                            asset: "assets/svg/block.svg"),
                                        title: Text(
                                          "Block ${friends[i].name!.firstName!}",
                                          style: TextStyle(
                                            color: Color(0xff2D2D2D),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 24, bottom: 24),
                                      child: ListTile(
                                        leading: svgViewer(
                                            asset: "assets/svg/unfriend.svg"),
                                        title: Text(
                                          "Unfriend Random",
                                          style: TextStyle(
                                            color: Color(0xffE71F1F),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
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
          ));
  }

  //! Community Page - Frined Section 2nd Half
  Widget friendRequestsSection(BuildContext context) {
    final CommunityFeedController communityController = Get.find();
    return Obx(() {
      return communityController.isLoading.value
          ? Center(child: CustomLoading())
          : Column(
              spacing: 16,
              children: [
                GestureDetector(
                  onTap: () {
                    if (onPageChanged != null) {
                      onPageChanged!(2);
                    }
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    children: [
                      Text(
                        "Friend Requests",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff525252),
                        ),
                      ),
                      Text(
                        " ${communityController.requestList.length}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff1E648C),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff525252),
                        ),
                      ),
                      svgViewer(asset: "assets/svg/see_all.svg"),
                    ],
                  ),
                ),
                for (int i = 0;
                    i < (communityController.requestList.length);
                    i++)
                  FriendRequests(
                    image: communityController.requestList[i].image!,
                    name:
                        "${communityController.requestList[i].name!.firstName!} ${communityController.requestList[i].name!.lastName!}",
                    userId: communityController.requestList[i].id!,
                  ),
              ],
            );
    });
  }
}
