import 'package:get/get.dart';
import 'package:zen_active/helpers/route.dart';
import 'package:zen_active/utils/prefs_helper.dart';

class SplashController extends GetxController implements GetxService {
  RxBool isSplashPassed = false.obs;
  RxBool isUserLoggedIn = false.obs;
  RxBool isUserInfoCompleted = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkNavigationFlow();
  }

  void checkNavigationFlow() async {
    if (Get.currentRoute == AppRoutes.splashScreen && !isSplashPassed.value) {
      return;
    }

    if (Get.currentRoute == AppRoutes.signInScreen && !isUserLoggedIn.value) {
      return;
    }
    if (Get.currentRoute == AppRoutes.userInfoStack &&
        !isUserInfoCompleted.value) {
      return;
    }

    if (!isSplashPassed.value) {
      Get.offAllNamed(AppRoutes.splashScreen);
    } else if (!isUserLoggedIn.value) {
      Get.offAllNamed(AppRoutes.signInScreen);
    } else if (!isUserInfoCompleted.value) {
      Get.offAllNamed(AppRoutes.userInfoStack);
    } else {
      Get.offAllNamed(AppRoutes.app);
    }
  }

  /// Call this when the user skips the splash screen
  void skipSplash() async {
    await PrefsHelper.setBool("isSplashPassed", true);
    checkNavigationFlow();
  }

  /// Call this when the user logs in
  void onLoginSuccess() async {
    await PrefsHelper.setBool("isUserLoggedIn", true);
    checkNavigationFlow();
  }

  /// Call this when the user completes the required info
  void onUserInfoCompleted() async {
    await PrefsHelper.setBool("isUserInfoCompleted", true);
    checkNavigationFlow();
  }
}
