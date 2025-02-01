import 'package:flutter/material.dart';
import 'package:zen_active/views/components/custom_button.dart';

class FriendRequests extends StatelessWidget {
  final bool isAddFreind;
  const FriendRequests({
    super.key,
    required this.i,
    this.isAddFreind = false,
  });

  final int i;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: Image.asset(
            "assets/images/faces/${(i % 10) + 1}.png",
            height: 80,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Random Name",
              style: TextStyle(
                color: Color(0xff222222),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                CustomButton(
                  buttonName: isAddFreind ? "Add Friend" : "Confirm",
                  height: 35,
                  width: 125,
                  textSize: 16,
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 8,
                ),
                CustomButton(
                  buttonName: "Remove",
                  height: 35,
                  width: 125,
                  textSize: 16,
                  isSecondary: true,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
