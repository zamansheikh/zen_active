import 'package:flutter/material.dart';
import 'package:zenactive/utils/uitls.dart';

class CustomSearchBar extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
   const CustomSearchBar({
    super.key,
    this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xffFEFEFF),
        border: Border.all(
          color: Color(0xff79CDFF),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffAFAFAF),
                  height: 2,
                ),
                hintText: hintText,
              ),
            ),
          ),
          svgViewer(
            asset: "assets/svg/search.svg",
            color: Color(0xff174C6B),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
    );
  }
}
