import 'package:flutter/material.dart';
import 'package:zenactive/utils/uitls.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final bool isDisabled;
  final bool multiline;
  final int? lines;
  final TextInputType? keyboardType;
  final Function()? onTap;
  final String? hintText;
  const CustomTextField({
    super.key,
    required this.title,
    this.controller,
    this.isDisabled = false,
    this.multiline = false,
    this.keyboardType,
    this.onTap,
    this.hintText,
    this.lines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kTextStyle.copyWith(
            color: Color(
              0xff2d2d2d,
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            // height: 52,
            constraints: BoxConstraints(
              minHeight: 52,
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Color(0xfffefeff),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 1.0,
                color: Color(
                  0xff79CDFF,
                ),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: TextField(
                  keyboardType: keyboardType,
                  controller: controller,
                  maxLines: multiline ? lines ?? 2 : 1,
                  enabled: !isDisabled,
                  style: kTextStyle.copyWith(
                    color: isDisabled ? Color(0xff757575) : Color(0xff4B4B4B),
                  ),
                  decoration: InputDecoration(
                    hintText: hintText ?? 'Enter your ${title.toLowerCase()}',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
