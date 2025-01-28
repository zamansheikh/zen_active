import 'package:flutter/material.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_button.dart';

class SubscriptionWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final List<String> benifits;
  final String? buttonText;
  final bool isDark;
  final Function()? onTap;
  const SubscriptionWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.benifits,
    this.buttonText,
    this.isDark = false, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Color(0xff1e648c) : Color(0xfffefeff),
        border: Border.all(
          color: Color(0xff37B5FF),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Text(
            title,
            style: kTextStyle.copyWith(
              color: isDark ? Color(0xffebf8ff) : Color(0xff174C6B),
              fontSize: 20,
              height: 1,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            subTitle,
            style: kTextStyle.copyWith(
              color: isDark ? Color(0xffebf8ff) : Color(0xff2781B5),
              fontSize: 18,
              height: 1,
            ),
          ),
          const SizedBox(height: 26),
          Container(
            width: double.infinity,
            height: 1,
            color: isDark ? Color(0xffEBF8FF) : Color(0xff37B5FF),
          ),
          const SizedBox(
            height: 28,
          ),
          for (var i in benifits)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 32,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  svgViewer(
                    asset: isDark
                        ? "assets/svg/check_white.svg"
                        : "assets/svg/check.svg",
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Baseline(
                      baseline: 15,
                      baselineType: TextBaseline.ideographic,
                      child: Text(
                        i,
                        style: kTextStyle.copyWith(
                          height: 1,
                          color: isDark ? Color(0xffebf8ff) : Color(0xff525252),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          buttonText == null
              ? const SizedBox(height: 26)
              : Padding(
                  padding: const EdgeInsets.only(
                    top: 32,
                    bottom: 32,
                  ),
                  child: CustomButton(
                    buttonName: buttonText!,
                    buttonColor: isDark ? Color(0xfffefeff) : null,
                    textColor: isDark ? Color(0xff1E648C) : null,
                    width: 170,
                    textSize: 16,
                    onPressed: onTap,
                  ),
                ),
        ],
      ),
    );
  }
}
