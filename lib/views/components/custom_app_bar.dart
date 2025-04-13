import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/utils/uitls.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final String? tailingIconPath;
  final Function()? tailingCallback;
  final Function()? overridedBackFunction;
  final Color? backgroundColor;
  const CustomAppBar({
    super.key,
    this.title,
    this.backgroundColor,
    this.tailingIconPath,
    this.tailingCallback,
    this.overridedBackFunction,
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
              if (overridedBackFunction != null) {
                overridedBackFunction!();
              } else {
                Get.back();
              }
            },
            child: svgViewer(asset: "assets/svg/arrow_back.svg"),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title ?? "",
              style: kTextStyle.copyWith(
                fontSize: 20,
                color: (backgroundColor != null)
                    ? Color(0xff525252)
                    : Color(0xff222222),
              ),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
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
          const SizedBox(width: 24), // Add some space at the end
        ],
      ),
    );
  }
}
