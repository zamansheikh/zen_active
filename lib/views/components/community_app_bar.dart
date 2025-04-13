import 'package:flutter/cupertino.dart';
import 'package:zenactive/utils/uitls.dart';

class CommunityAppBar extends StatelessWidget {
  final int index;
  final Function(int newIndex)? onTap;
  const CommunityAppBar({super.key, required this.index, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Color(0xffDBE1E4),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(child: navItem("feed", 0)),
          Expanded(child: navItem("friends", 1)),
          Expanded(child: navItem("messages", 2)),
          Expanded(child: navItem("groups", 3)),
          Expanded(child: navItem("notification", 4)),
        ],
      ),
    );
  }

  Widget navItem(String iconName, int position) {
    bool isSelected = index == position;
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(position);
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: [
          Spacer(flex: isSelected ? 2 : 1,),
          svgViewer(
            asset: "assets/svg/$iconName${isSelected ? "_dark" : ""}.svg",
          ),
          const Spacer(flex: 1,),
          if(isSelected)
          Container(
            width: 32,
            height: 2,
            decoration: BoxDecoration(
              color: Color(0xff174C6B),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(4),
              ),
            ),
          )
        ],
      ),
    );
  }
}
