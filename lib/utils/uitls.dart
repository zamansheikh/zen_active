import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget svgViewer({
  required String asset,
  double height = 24.0,
  double width = 24.0,
  Color? color,
}) {
  return SvgPicture.asset(
    asset,
    height: height,
    width: width,
    colorFilter:
        color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
  );
}

const TextStyle kTextStyle = TextStyle(
  fontFamily: "Khula",
  color: Color(0xff222222),
  fontSize: 16,
  fontWeight: FontWeight.w600,
);
