import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/uitls.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final String? tailingIconPath;
  final Function()? tailingCallback;
  final Color? backgroundColor;
  const CustomAppBar({
    super.key,
    this.title,
    this.backgroundColor,
    this.tailingIconPath,
    this.tailingCallback,
  });

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
              color: Color(0xff222222),
            ),
            textAlign: TextAlign.center,
            textHeightBehavior: TextHeightBehavior(
              applyHeightToFirstAscent: false,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 48,
            child: tailingIconPath != null
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: tailingCallback,
                      child: svgViewer(asset: tailingIconPath!),
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
