import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/services/api_client.dart';
import 'package:zenactive/services/api_constant.dart';
import 'package:zenactive/utils/app_constants.dart';
import 'package:zenactive/utils/prefs_helper.dart';
import 'package:zenactive/views/screen/splash/controller/splash_controller.dart';

class SettingsController extends GetxController implements GetxService {
  String title = "Settings Screen";
  RxBool isLoading = false.obs;
  RxBool isDeleting = false.obs;
  RxString privacyPolicy = "".obs;
  RxString termsAndCondition = "".obs;
  RxString aboutUs = "".obs;

  // Controller for delete confirmation input
  final TextEditingController deleteConfirmationController =
      TextEditingController();

  void getPrivacy() async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.getData(
        ApiConstant.getPrivacy,
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          privacyPolicy.value = response.body["data"]["privacy"];
          isLoading.value = false;
        } catch (e) {
          debugPrint('Model Convertion Error: ${e.toString()}');
          isLoading.value = false;
        }
      }
    } catch (e) {
      debugPrint('------------${e.toString()}');
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  void getAboutUs() async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.getData(
        ApiConstant.getAboutUs,
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          aboutUs.value = response.body["data"]["about"];
          isLoading.value = false;
        } catch (e) {
          debugPrint('Model Convertion Error: ${e.toString()}');
          isLoading.value = false;
        }
      }
    } catch (e) {
      debugPrint('------------${e.toString()}');
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  void getTermOfServices() async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.getData(
        ApiConstant.getTerms,
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          termsAndCondition.value = response.body["data"]["terms"];
          isLoading.value = false;
        } catch (e) {
          debugPrint('Model Convertion Error: ${e.toString()}');
          isLoading.value = false;
        }
      }
    } catch (e) {
      debugPrint('------------${e.toString()}');
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  // Delete account method
  void deleteAccount() async {
    isDeleting.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };

    try {
      final response = await ApiClient.deleteData(
        '/user/delete-me',
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Clear all user data
        await PrefsHelper.setBool("isUserLoggedIn", false);
        await PrefsHelper.setBool("isUserInfoCompleted", false);
        await PrefsHelper.setString(AppConstants.bearerToken, '');
        await PrefsHelper.setString(AppConstants.userId, '');

        // Show success message
        Get.snackbar(
          'Account Deleted',
          'Your account has been permanently deleted.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to login screen
        Get.find<SplashController>().checkNavigationFlow();
      } else {
        Get.snackbar(
          'Error',
          response.body?["message"] ??
              'Failed to delete account. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint('Delete account error: ${e.toString()}');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    isDeleting.value = false;
  }

  @override
  void onInit() {
    debugPrint("On Init  $title");
    getPrivacy();
    getAboutUs();
    getTermOfServices();
    super.onInit();
  }

  @override
  void onReady() {
    debugPrint("On onReady  $title");
    super.onReady();
  }

  @override
  void onClose() {
    deleteConfirmationController.dispose();
    super.onClose();
  }
}
