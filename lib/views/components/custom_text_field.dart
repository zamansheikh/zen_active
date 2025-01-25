import 'package:flutter/material.dart';
import 'package:zen_active/utils/uitls.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final bool isDisabled;
  const CustomTextField({
    super.key,
    required this.title,
    this.controller,
    this.isDisabled = false,
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
        Container(
          height: 52,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Color(0xfffefeff),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 0.5,
              color: Color(
                0xff79CDFF,
              ),
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: TextField(
                controller: controller,
                enabled: !isDisabled,
                style: kTextStyle.copyWith(
                  color: isDisabled ? Color(0xff757575) : Color(0xff4B4B4B),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
