import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/leader_board_controller.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_loading.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaderBoardController());

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CustomLoading());
        }

        if (controller.leaderBoardList.isEmpty) {
          return _buildEmptyState();
        }

        return Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffEBF8FF), Color(0xff2781B5)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SafeArea(
                  child: CustomAppBar(
                    title: "Leaderboard",
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        _buildTopThree(controller),
                        const SizedBox(height: 16),
                        Expanded(
                          child: _buildLeaderboardList(controller),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  /// Builds the Top 3 leaderboard section safely
  Widget _buildTopThree(LeaderBoardController controller) {
    List<dynamic> topUsers = controller.leaderBoardList.length > 3
        ? controller.leaderBoardList.sublist(0, 3)
        : controller.leaderBoardList;

    return SizedBox(
      width: double.infinity,
      height: 236,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 113,
              decoration: BoxDecoration(
                color: const Color(0xff1E648C),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: 122,
              height: 159,
              decoration: BoxDecoration(
                color: const Color(0xff2781B5),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          if (topUsers.length > 2)
            _buildTopUser(topUsers[2], "3", "assets/images/crown_bronze.png",
                Color(0xff32A5E8),
                right: 26, bottom: 80),
          if (topUsers.length > 1)
            _buildTopUser(topUsers[1], "2", "assets/images/crown_silver.png",
                Color(0xff32A5E8),
                left: 26, bottom: 80),
          if (topUsers.isNotEmpty)
            _buildTopUser(topUsers[0], "1", "assets/images/crown_gold.png",
                Color(0xffFFAA00),
                bottom: 128),
        ],
      ),
    );
  }

  /// Builds a single top user UI safely
  Widget _buildTopUser(user, String rank, String crownImage, Color borderColor,
      {double? left, double? right, required double bottom}) {
    return Positioned(
      left: left,
      right: right,
      bottom: bottom,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(top: -30, child: Image.asset(crownImage, width: 60)),
          Container(
            height: 68,
            width: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 3, color: borderColor),
            ),
            child: avatar(user.userId!.image!, size: 82),
          ),
          Positioned(
            bottom: -8,
            child: Container(
              height: 17,
              width: 17,
              decoration:
                  BoxDecoration(color: borderColor, shape: BoxShape.circle),
              child: Center(
                child: Text(rank,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700)),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            child: Column(
              children: [
                Text(user.userId!.name!.firstName!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1)),
                const SizedBox(height: 5),
                Text(user.points!.toStringAsFixed(0),
                    style: TextStyle(
                        color: rank == "1" ? borderColor : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        height: 1)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the full leaderboard list
  Widget _buildLeaderboardList(LeaderBoardController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xfffefeff),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        border: Border.all(color: const Color(0xff37B5FF)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (controller.myself.value.userId != null)
              _buildUserRow(controller.myself.value, isCurrentUser: true),
            for (int index = 0;
                index < controller.leaderBoardList.length;
                index++)
              if (controller.leaderBoardList[index].userId!.id !=
                  controller.myself.value.userId!.id)
                _buildUserRow(controller.leaderBoardList[index]),
          ],
        ),
      ),
    );
  }

  /// Builds a single row in the leaderboard list
  Widget _buildUserRow(user, {bool isCurrentUser = false}) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: 1,
                color: isCurrentUser ? Color(0xff2781B5) : Color(0xff79CDFF))),
      ),
      child: Row(
        children: [
          avatar(user.userId!.image!, size: 40),
          const SizedBox(width: 12),
          Text(isCurrentUser ? "You" : user.userId!.name!.firstName!,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xff4B4B4B),
                  height: 1)),
          const Spacer(),
          Text(user.points!.toStringAsFixed(0),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xff4B4B4B),
                  height: 1)),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  /// Handles empty leaderboard UI
  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        "No leaderboard data available",
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey),
      ),
    );
  }

  Widget avatar(String avater, {double size = 50}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: Image.network(
        imageUrl(avater),
        height: size,
        width: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset("assets/images/faces/1.png",
              height: size, width: size);
        },
      ),
    );
  }
}
