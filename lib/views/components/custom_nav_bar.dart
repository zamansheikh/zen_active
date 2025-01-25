import 'package:flutter/cupertino.dart';
import 'package:zen_active/utils/style.dart';

class CustomNavBar extends StatelessWidget {
  final int index;
  const CustomNavBar({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 77,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          navItem("", "Home", index == 0),
          navItem("", "Challenges", index == 1),
          navItem("", "Community", index == 2),
          navItem("", "Workouts", index == 3),
          navItem("", "Profile", index == 4),
        ],
      ),
    );
  }

  Widget navItem(String iconPath, String title, bool isSelected) {
    return Container(
      width: 33,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppStyles.h6(),
          ),
        ],
      ),
    );
  }
}
