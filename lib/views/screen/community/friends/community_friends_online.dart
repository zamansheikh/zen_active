import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/auth_controller.dart';
import 'package:zenactive/controllers/community_feed_controller.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/screen/community/groups/community_chat_screen.dart';

class CommunityFriendsOnline extends StatelessWidget {
  final Function(int) onPageChanged;
  const CommunityFriendsOnline({super.key, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    final CommunityFeedController communityFeedController = Get.find();
    communityFeedController.getMyFiends();
    return Column(
      children: [
        const SizedBox(
          height: 12,
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
            Text(
              "Friend Online",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff4B4B4B),
              ),
            ),
            Obx(() {
              return Text(
                " ${communityFeedController.myFriends.where((element) => Get.find<AuthController>().activeIds.contains(element.id)).length}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff1E648C),
                ),
              );
            }),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Expanded(
          child: Obx(() {
            final onlineFriends = communityFeedController.myFriends
                .where((element) =>
                    Get.find<AuthController>().activeIds.contains(element.id))
                .toList();
            return SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < onlineFriends.length; i++)
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
                                  imageUrl(onlineFriends[i].image!),
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
                            "${onlineFriends[i].name!.firstName!} ${onlineFriends[i].name!.lastName!}",
                            style: TextStyle(
                              color: Color(0xff222222),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Get.to(
                                  ConversationScreen(friend: onlineFriends[i]));
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
                                                        BorderRadius.circular(
                                                            999),
                                                    child: Image.network(
                                                      imageUrl(onlineFriends[i]
                                                          .image!),
                                                      height: 52,
                                                      fit: BoxFit.cover,
                                                      width: 52,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return Container(
                                                          height: 52,
                                                          width: 52,
                                                          color: Colors.grey,
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .error_outline_rounded,
                                                              color:
                                                                  Colors.white,
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
                                                        color:
                                                            Color(0xff04AB04),
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color:
                                                              Color(0xfff6fafc),
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
                                                    "${onlineFriends[i].name!.firstName!} ${onlineFriends[i].name!.lastName!}",
                                                    style: TextStyle(
                                                      color: Color(0xff222222),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                          padding:
                                              const EdgeInsets.only(left: 24),
                                          child: ListTile(
                                            leading: svgViewer(
                                              asset: "assets/svg/messages.svg",
                                              color: Color(0xff2D2D2D),
                                            ),
                                            title: Text(
                                              "Message ${onlineFriends[i].name!.firstName!}",
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
                                              const EdgeInsets.only(left: 24),
                                          child: ListTile(
                                            leading: svgViewer(
                                                asset: "assets/svg/block.svg"),
                                            title: Text(
                                              "Block ${onlineFriends[i].name!.firstName!}",
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
                                                asset:
                                                    "assets/svg/unfriend.svg"),
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
              ),
            );
          }),
        ),
      ],
    );
  }
}
