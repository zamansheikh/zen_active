import 'package:get/get.dart';
import 'package:zen_active/views/screen/Splash/controller/splash_controller.dart';

class AuthController extends GetxController implements GetxService {
  RxBool isLoading = false.obs;
  final SplashController _splashController = Get.find<SplashController>();

  void logIn({
    required String email,
    required String password,
  }) async {
    //wait for 2 seconds to simulate a network call
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    _splashController.onLoginSuccess();
    isLoading.value = false;
  }

  void updateUserDetails() async {
    //wait for 2 seconds to simulate a network call
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    _splashController.onUserInfoCompleted();
    isLoading.value = false;
  }
}
