import 'package:get/get.dart';
import 'package:zen_active/views/screen/auth/forget_password.dart';
import 'package:zen_active/views/screen/auth/sign_in_screen.dart';
import 'package:zen_active/views/screen/auth/signup_screen.dart';
import 'package:zen_active/views/screen/home/home_screen.dart';

import '../views/screen/splash/splash_screen.dart';

class AppRoutes {
  static String splashScreen = "/splash_screen";
  static String homeScreen = "/home_screen";
  static String signUpScreen = "/sign_up_screen";
  static String signInScreen = "/sign_in_screen";
  static String forgetPassword = "/forget_password";

  static List<GetPage> page = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(
        name: homeScreen,
        page: () => const HomeScreen(),
        transition: Transition.noTransition),
    GetPage(name: signUpScreen, page: () => SignupScreen()),
    GetPage(name: signInScreen, page: () => SigninScreen()),
    GetPage(name: forgetPassword, page: () => ForgetPassword())
  ];
}
