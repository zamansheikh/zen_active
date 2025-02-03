import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityGroupController extends GetxController {
  RxList<Widget> customPages = <Widget>[].obs;

  void push(Widget page) {
    customPages.add(page);
  }

  void pop() {
    if (customPages.isNotEmpty) {
      customPages.removeAt(customPages.length - 1);
    }
  }
}
