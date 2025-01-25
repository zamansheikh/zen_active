import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SplashController extends GetxController implements GetxService {
  String title = "Home Screen";

  @override
  void onInit() {
    debugPrint("On Init  $title");

    super.onInit();
  }

  void letsGo() {
    debugPrint("Lets Go");
  }

  @override
  void onReady() {
    debugPrint("On onReady  $title");
    super.onReady();
  }
}
