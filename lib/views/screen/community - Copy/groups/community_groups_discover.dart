import 'package:flutter/material.dart';
import 'package:zen_active/views/components/custom_button.dart';

class CommunityGroupsDiscover extends StatelessWidget {
  const CommunityGroupsDiscover({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Suggested for you",
            style: TextStyle(
              color: Color(0xff000000),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.only(bottom: 24,),
              crossAxisCount: 2,
              mainAxisSpacing: 18,
              crossAxisSpacing: 18,
              childAspectRatio: (168 / 226),
              children: [
                for (int i = 0; i < 10; i++) groupInfo(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget groupInfo() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffFEFEFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(
            0xff79CDFF,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              child: Image.asset(
                "assets/images/challenges/1.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Group Name",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xff2D2D2D),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Public group · 520 members",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xff8B8B8B),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              buttonName: "Join",
              height: 35,
              textSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
