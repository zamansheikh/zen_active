import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget svgViewer({
  required String asset,
  double height = 24.0,
  double width = 24.0,
  Color? color,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8),
    child: SvgPicture.asset(
      asset,
      height: height.h,
      width: width.w,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    ),
  );
}
