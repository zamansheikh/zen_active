import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/community_feed_controller.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_loading.dart';
import 'package:zen_active/views/components/friend_requests.dart';
import 'package:zen_active/views/components/slidable_tab_bar.dart';

class CommunityFriendsDefault extends StatelessWidget {
  final Function(int)? onPageChanged;
  const CommunityFriendsDefault({super.key, this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    final CommunityFeedController communityController = Get.find();
    communityController.getRequsted(type: "requestedList");
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
            svgViewer(
              asset: "assets/svg/search.svg",
              color: Color(0xff4B4B4B),
            ),
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
        friendRequestsSection(count: 155),
      ],
    );
  }

  //! Community Page - Online Section 1st Half
  Widget friendsOnlineSection(BuildContext context, {int count = 52}) {
    return Column(
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
                " 132",
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
        for (int i = 0; i < 3; i++)
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
                      child: Image.asset(
                        "assets/images/faces/${i + 4}.png",
                        height: 52,
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
                  "Random Name",
                  style: TextStyle(
                    color: Color(0xff222222),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Container(
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
                                          child: Image.asset(
                                            "assets/images/faces/${(i % 9) + 1}.png",
                                            height: 52,
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
                                          "Random Name",
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
                                    "Message Random",
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
                                  leading:
                                      svgViewer(asset: "assets/svg/block.svg"),
                                  title: Text(
                                    "Block Random",
                                    style: TextStyle(
                                      color: Color(0xff2D2D2D),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 24, bottom: 24),
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
    );
  }

  //! Community Page - Frined Section 2nd Half
  Widget friendRequestsSection({int count = 52}) {
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
                        " ${communityController.requestList.value.requestedList?.length}",
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
                    i <
                        communityController
                            .requestList.value.requestedList!.length;
                    i++)
                  FriendRequests(
                    image: communityController
                        .requestList.value.requestedList![i].image!,
                    name:
                        "${communityController.requestList.value.requestedList![i].name!.firstName!} ${communityController.requestList.value.requestedList![i].name!.lastName!}",
                    userId: communityController
                        .requestList.value.requestedList![i].id!,
                  ),
              ],
            );
    });
  }
}
