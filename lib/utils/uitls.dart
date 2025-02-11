import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zen_active/services/api_constant.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:flutter/foundation.dart';

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

void showSnackBar({
  required String? message,
  required bool isSucess,
}) {
  Get.snackbar(
    isSucess ? "Success" : "Error",
    message ?? (isSucess ? "No error Found" : "Something went wrong"),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.splashColor,
    colorText: AppColors.primaryTextColor,
  );
}

const TextStyle kTextStyle = TextStyle(
  fontFamily: "Khula",
  color: Color(0xff222222),
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

void llg(dynamic message) {
  var toString = message.toString();
  if (kDebugMode) {
    print("Logged from Here: $toString");
  }
}

String imageUrl(String? url) {
  if (url == null || url.isEmpty) {
    return "https://via.placeholder.com/150";
  } else {
    print("Image URL: ${ApiConstant.imageBaseUrl + url}");
    return ApiConstant.imageBaseUrl + url;
  }
}
