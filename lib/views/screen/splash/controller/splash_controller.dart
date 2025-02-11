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
    laodState();
  }

  void laodState() async {
    isSplashPassed.value = await PrefsHelper.getBool("isSplashPassed");
    isUserLoggedIn.value = await PrefsHelper.getBool("isUserLoggedIn");
    isUserInfoCompleted.value =
        await PrefsHelper.getBool("isUserInfoCompleted");
  }

  void checkNavigationFlow() async {
    laodState();
    if (isSplashPassed.value &&
        isUserLoggedIn.value &&
        isUserInfoCompleted.value) {
      Get.offAllNamed(AppRoutes.app);
    } else if (isSplashPassed.value && !isUserLoggedIn.value) {
      Get.offAllNamed(AppRoutes.signInScreen);
    } else if (isSplashPassed.value &&
        isUserLoggedIn.value &&
        !isUserInfoCompleted.value) {
      Get.offAllNamed(AppRoutes.userInfoStack);
    }
  }

  /// Call this when the user skips the splash screen
  void skipSplash() async {
    await PrefsHelper.setBool("isSplashPassed", true);
    isSplashPassed.value = true;
    checkNavigationFlow();
  }

  /// Call this when the user logs in
  void onLoginSuccess() async {
    await PrefsHelper.setBool("isUserLoggedIn", true);
    isUserLoggedIn.value = true;
    checkNavigationFlow();
  }

  /// Call this when the user completes the required info
  void onUserInfoCompleted() async {
    await PrefsHelper.setBool("isUserInfoCompleted", true);
    isUserInfoCompleted.value = true;
    checkNavigationFlow();
  }
}
