import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:zen_active/helpers/route.dart';
import 'package:zen_active/models/auth_model.dart';
import 'package:zen_active/services/api_client.dart';
import 'package:zen_active/services/api_constant.dart';
import 'package:zen_active/utils/app_logger.dart';
import 'package:zen_active/views/screen/Splash/controller/splash_controller.dart';

class AuthController extends GetxController implements GetxService {
  RxBool isLoading = false.obs;
  final SplashController _splashController = Get.find<SplashController>();
  final TextEditingController emailController =
      TextEditingController(text: 'zaman6545@gmail.com');
  final TextEditingController passwordController =
      TextEditingController(text: 'zaq12wsxcv');
  final TextEditingController confirmPasswordController =
      TextEditingController(text: 'zaq12wsxcv');
  final TextEditingController otpController = TextEditingController();
  final String fcmToken =
      'eZ0OZnAZSJaJbNaJb8cMhX:APA91bEj2zajj__PCCw-J5A8pUW52LkhEIeke3of5OybdJ9PJPYqKFZy5oQ21Ng1VW1FoO-cggY6hiVGurdcQG9VKiFfpcXN4mv8nwabjEBYvytQ0hrdmqY';

  void logIn({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      final response = await ApiClient.postData(
        ApiConstant.authLogin,
        {
          'email': email,
          'password': password,
        },
        headers: headers,
      );
      final AuthModel authModel = AuthModel.fromJson(response.body);
      authModel.message.logE();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      debugPrint('------------${e.toString()}');
    }
  }

  void signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      isLoading.value = true;
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      final response = await ApiClient.postData(
        ApiConstant.authSignUp,
        {
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
          'fcmToken': fcmToken,
        },
        headers: headers,
      );
      if (response.body["status"] == 200) {
        response.body.toString().logE();
        isLoading.value = false;
        Get.offNamed(
          AppRoutes.otpVerify,
          arguments: email,
        );
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint('------------${e.toString()}');
    }
  }

  void verifyOTP({
    required String email,
    required String otp,
  }) async {
    try {
      isLoading.value = true;
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      email.logE();
      final response = await ApiClient.patchData(
        ApiConstant.otpVerify,
        {
          'email': email,
          'code': otp,
        },
        headers: headers,
      );
      if (response.body["status"] == 200) {
        response.body.toString().logE();
        isLoading.value = false;
      } else {
        isLoading.value = false;
        print(
            "response.body['message']------------${response.body['message']}");
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint('------------${e.toString()}');
    }
  }

  void updateUserDetails() async {
    //wait for 2 seconds to simulate a network call
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    _splashController.onUserInfoCompleted();
    isLoading.value = false;
  }
}
