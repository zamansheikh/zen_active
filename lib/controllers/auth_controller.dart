import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zenactive/Utils/app_constants.dart';
import 'package:zenactive/controllers/user_info_controller.dart';
import 'package:zenactive/helpers/route.dart';
import 'package:zenactive/helpers/socket_service.dart';
import 'package:zenactive/models/reward_model.dart';
import 'package:zenactive/models/user_model.dart';
import 'package:zenactive/services/api_checker.dart';
import 'package:zenactive/services/api_client.dart';
import 'package:zenactive/services/api_constant.dart';
import 'package:zenactive/utils/app_logger.dart';
import 'package:zenactive/utils/prefs_helper.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/screen/Splash/controller/splash_controller.dart';
import 'package:zenactive/views/screen/profile/reward_confirmation_page.dart';

class AuthController extends GetxController implements GetxService {
  RxBool isEditing = false.obs;
  RxBool isLoading = false.obs;
  RxList<String> activeIds = <String>[].obs;
  Rx<UserModel> user = UserModel().obs;
  RxList<RewardModel> badges = <RewardModel>[].obs;
  final SplashController _splashController = Get.find<SplashController>();
  final TextEditingController emailController =
      TextEditingController(text: 'zaman6545@gmail.com');
  final TextEditingController passwordController =
      TextEditingController(text: 'zaq12wsxcv');
  final TextEditingController confirmPasswordController =
      TextEditingController(text: 'zaq12wsxcv');
  final TextEditingController otpController = TextEditingController();
  final String fcmToken =
      'eDKZa9gxSDaabXScFC8qrg:APA91bGsdACURbWvW_YaEe5izll5TWZCfV9RcU6rY7Tv4J3eIf2MHZ-dFHUuulH7YJ06ufa5pmKBEYg74fXhqVc17Bc8rY39ZNOqq3efJKHbsqAOCvZ2sVY';

  //Make logout function that only clears the userLoggedIn value
  void logout() async {
    await PrefsHelper.setBool("isUserLoggedIn", false);
    await PrefsHelper.setString(AppConstants.bearerToken, '');
    Get.find<SplashController>().checkNavigationFlow();
  }

  void logIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      print(fcmToken);
      final response = await ApiClient.postData(
        ApiConstant.authLogin,
        {
          'email': email,
          'password': password,
          "fcmToken": fcmToken,
        },
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showSnackBar(
            message: response.body["message"],
            isSucess: response.statusCode == 200);
        await PrefsHelper.setString(
            AppConstants.bearerToken, response.body["data"]["token"]);
        await PrefsHelper.setString(
            AppConstants.userId, response.body["data"]["user"]["_id"]);
        _splashController.onLoginSuccess();
        try {
          final response = await ApiClient.getData(
            ApiConstant.getMe,
          );
          if (response.statusCode == 200 || response.statusCode == 201) {
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
      if (response.statusCode == 200 || response.statusCode == 201) {
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
      final response = await ApiClient.patchData(
        ApiConstant.otpVerify,
        {
          'email': email,
          'code': otp,
        },
        headers: headers,
      );
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        showSnackBar(
            message: response.body["message"],
            isSucess: response.statusCode == 200 || response.statusCode == 201);
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
      "restriction": userInfoController.restrictinController.text.trim(),
      "name": {
        "firstName": userInfoController.firstNameController.text.trim(),
        "lastName": userInfoController.lastNameControler.text.trim()
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

  void updateUserProfile({
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String restriction,
    required String gender,
    required String height,
    required String weight,
    required String primaryGoal,
    required String diet,
    required String activityLevel,
  }) async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    List<MultipartBody> multipartBody = [];
    Map<String, dynamic> data = {
      "activityLevel": activityLevel,
      "diet": diet,
      "primaryGoal": primaryGoal,
      "weight": int.tryParse(weight),
      "height": int.tryParse(height),
      "gender": gender,
      "dateOfBirth": dateOfBirth,
      "restriction": restriction,
      "name": {"firstName": firstName, "lastName": lastName},
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
        isEditing.value = false;
        getUserDetails();
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
  Future<void> getUserDetails() async {
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      isLoading.value = true;
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
    } finally {
      isLoading.value = false;
    }
  }

  pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
      List<MultipartBody> multipartBody = [MultipartBody("image", file)];
      // var body = {
      //   "data": jsonEncode(data),
      // };
      Map<String, String> body = {};
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
          getUserDetails();
        } else {
          ApiChecker.checkApi(response);
        }
      } catch (e) {
        debugPrint('Model Convertion Error: ${e.toString()}');
        isLoading.value = false;
      }
    }
  }

  //GET USER DETAILS
  void getAlluserBadges() async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.getData(
        ApiConstant.userBadges,
        headers: headers,
      );
      if (response.body["status"] == 200) {
        try {
          badges.value = response.body["data"]
              .map<RewardModel>((e) => RewardModel.fromJson(e))
              .toList();
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

  //Buy a badge
  void buyBadge({required RewardModel reward}) async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.postData(
        ApiConstant.buyUseBadges,
        {
          'badgeId': reward.id,
        },
        headers: headers,
      );
      if (response.body["status"] == 200 || response.body["status"] == 201) {
        showSnackBar(
            message: response.body["message"],
            isSucess: response.body["status"] == 200 ||
                response.body["status"] == 201);
        Get.to(RewardConfirmationPage(reward: reward));
        getUserDetails();
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      debugPrint('------------${e.toString()}');
    }
    isLoading.value = false;
  }

  void listenActiveFriends() async {
    final userId = await PrefsHelper.getString(AppConstants.userId);
    SocketServices.socket.emit("register", userId);
    try {
      SocketServices.socket.on("onlineUsers", (data) {
        // Convert data to List<String>
        activeIds.value = List<String>.from(data.map((e) => e.toString()));
        llg("OnLine Now: $activeIds and listLength: ${activeIds.length}");
        activeIds.refresh();
      });
    } catch (e) {
      debugPrint("Socket Error: $e");
    }
  }

  //oninit
  @override
  void onInit() {
    debugPrint("AuthController Initialized");
    super.onInit();
    listenActiveFriends();
  }
}
