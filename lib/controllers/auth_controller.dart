import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:zen_active/Utils/app_constants.dart';
import 'package:zen_active/controllers/user_info_controller.dart';
import 'package:zen_active/helpers/route.dart';
import 'package:zen_active/models/user_meal_plan.dart';
import 'package:zen_active/models/user_model.dart';
import 'package:zen_active/services/api_checker.dart';
import 'package:zen_active/services/api_client.dart';
import 'package:zen_active/services/api_constant.dart';
import 'package:zen_active/utils/app_logger.dart';
import 'package:zen_active/utils/prefs_helper.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/screen/Splash/controller/splash_controller.dart';

class AuthController extends GetxController implements GetxService {
  RxBool isLoading = false.obs;
  Rx<UserModel> user = UserModel().obs;
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
    isLoading.value = true;
    try {
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

      if (response.statusCode == 200) {
        showSnackBar(
            message: response.body["message"],
            isSucess: response.body["status"] == 200);
        await PrefsHelper.setString(
            AppConstants.bearerToken, response.body["data"]["token"]);
        _splashController.onLoginSuccess();
        try {
          final response = await ApiClient.getData(
            ApiConstant.getMe,
          );
          if (response.body["status"] == 200) {
            try {
              user.value = UserModel.fromJson(response.body["data"]);
              if (user.value.isProfileUpdated!) {
                _splashController.onUserInfoCompleted();
              } else {
                Get.offAllNamed(
                  AppRoutes.userInfoStack,
                );
              }
            } catch (e) {
              debugPrint('Model Convertion Error: ${e.toString()}');
              isLoading.value = false;
            }
          }
        } catch (e) {
          debugPrint('------------${e.toString()}');
        }

        isLoading.value = false;
      } else {
        ApiChecker.checkApi(response);
        isLoading.value = false;
      }

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
        showSnackBar(
            message: response.body["message"],
            isSucess: response.body["status"] == 200);
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
      otp.logE();
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
        Get.offAllNamed(
          AppRoutes.signInScreen,
        );
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint('------------${e.toString()}');
    }
  }

  void updateUserDetails() async {
    isLoading.value = true;
    final userInfoController = Get.find<UserInfoController>();
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    List<MultipartBody> multipartBody = [];
    Map<String, dynamic> data = {
      "medicalCondition":
          userInfoController.medicalConditionController.text.trim(),
      "movementDifficulty":
          userInfoController.movementDifficultyController.text.trim(),
      "injury": userInfoController.injuryController.text.trim(),
      "activityLevel": userInfoController.activityLevelController.text.trim(),
      "diet": userInfoController.dietController.text.trim(),
      "primaryGoal": userInfoController.primaryGoalController.text.trim(),
      "weight": int.tryParse(userInfoController.weightController.text.trim()),
      "height": int.tryParse(userInfoController.heightController.text.trim()),
      "gender": userInfoController.gender.value,
      "dateOfBirth": userInfoController.dateTimeStr.value,
      "name": {
        "firstName": userInfoController.firstNameController.text.trim(),
        "lastName": userInfoController.firstNameController.text.trim()
      },
    };

    var body = {
      "data": jsonEncode(data),
    };

    final headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.patchMultipartData(
        ApiConstant.updateUser,
        body,
        multipartBody: multipartBody,
        headers: headers,
      );
      if (response.statusCode == 200) {
        showSnackBar(
            message: response.body["message"],
            isSucess: response.body["status"] == 200);
        _splashController.onUserInfoCompleted();
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      debugPrint('Model Convertion Error: ${e.toString()}');
      isLoading.value = false;
    }

    isLoading.value = false;
  }

  //GET USER DETAILS
  void getUserDetails() async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.getData(
        ApiConstant.getMe,
        headers: headers,
      );
      if (response.body["status"] == 200) {
        try {
          user.value = UserModel.fromJson(response.body["data"]);
        } catch (e) {
          debugPrint('Model Convertion Error: ${e.toString()}');
          isLoading.value = false;
        }
      }
    } catch (e) {
      debugPrint('------------${e.toString()}');
    }
    isLoading.value = false;
  }
}
