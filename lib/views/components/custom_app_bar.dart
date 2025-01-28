import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/uitls.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final Color? backgroundColor;
  const CustomAppBar({super.key, this.title, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.scaffoldBackgroundColor,
      ),
      child: Row(
        children: [
          const SizedBox(width: 24),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: svgViewer(asset: "assets/svg/arrow_back.svg"),
          ),
          const Spacer(),
          Text(
            title ?? "",
            style: kTextStyle.copyWith(
              fontSize: 20,
              color: (backgroundColor != null)
                  ? Color(0xff525252)
                  : Color(0xff222222),
            ),
            textAlign: TextAlign.center,
            textHeightBehavior: TextHeightBehavior(
              applyHeightToFirstAscent: false,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
