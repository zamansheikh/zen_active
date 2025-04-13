import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLineBar extends StatelessWidget {
  final int selectedIndex;
  const CustomLineBar({
    super.key,
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: List.generate(
        5,
        (index) => Expanded(
          child: Container(
            height: 6.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: index == selectedIndex
                  ? Color(0xFF37B5FF)
                  : Color(0xffEEEEEE),
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
        ),
      ),
    );
  }
}
