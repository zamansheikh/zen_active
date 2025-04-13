import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ApiChecker {
  static void checkApi(Response response, {bool getXSnackBar = false}) async {
    if (response.statusCode != 200) {
      if (response.statusCode == 401) {
      } else {
        showCustomSnackBar(response.statusText!, getXSnackBar: getXSnackBar);
      }
    }
  }

  static void showCustomSnackBar(String message, {bool getXSnackBar = false}) {
    if (getXSnackBar) {
      if (Get.isSnackbarOpen) {
        Get.closeAllSnackbars();
      }
      Get.snackbar('Error', message);
    } else {
      CustomSnackBar.show(Get.context!, message);
    }
  }
}

class CustomSnackBar {
  static void show(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
