import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/user_info_controller.dart';
import 'package:zen_active/views/screen/auth/user_info/user_info_five.dart';
import 'package:zen_active/views/screen/auth/user_info/user_info_four.dart';
import 'package:zen_active/views/screen/auth/user_info/user_info_one.dart';
import 'package:zen_active/views/screen/auth/user_info/user_info_three.dart';
import 'package:zen_active/views/screen/auth/user_info/user_info_two.dart';

class UserInfoPageStack extends StatefulWidget {
  const UserInfoPageStack({super.key});

  @override
  State<UserInfoPageStack> createState() => _UserInfoPageStackState();
}

class _UserInfoPageStackState extends State<UserInfoPageStack> {
  final controller = Get.put(UserInfoController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: controller.currentIndex.value,
        children: [
          UserInfoOne(),
          UserInfoTwo(),
          UserInfoThree(),
          UserInfoFour(),
          UserInfoFive()
        ],
      ),
    );
  }
}
