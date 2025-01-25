import 'package:flutter/material.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/uitls.dart';

class CustomNavBar extends StatelessWidget {
  final int index;
  final Function(int) onItemTap;
  const CustomNavBar({super.key, required this.index, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: Color(0xffC9C9C9),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 14,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem("assets/svg/home.svg", "Home", 0),
            navItem("assets/svg/challenges.svg", "Challenges", 1),
            navItem("assets/svg/community.svg", "Community", 2),
            navItem("assets/svg/workouts.svg", "Workouts", 3),
            navItem("assets/svg/profile.svg", "Profile", 4),
          ],
        ),
      ),
    );
  }

  Widget navItem(String iconPath, String title, int itemIndex) {
    bool isSelected = index == itemIndex;
    return GestureDetector(
      onTap: () {
        onItemTap(itemIndex);
      },
      child: SizedBox(
        width: isSelected ? 60 : 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            svgViewer(
                asset: iconPath,
                color: isSelected ? Color(0xff222222) : Color(0xff8B8B8B)),
            if (isSelected)
              Text(
                title,
                style: kTextStyle.copyWith(fontSize: 11),
              ),
          ],
        ),
      ),
    );
  }
}
