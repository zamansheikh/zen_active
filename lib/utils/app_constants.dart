// ignore_for_file: non_constant_identifier_names, constant_identifier_names
import '../models/language_model.dart';

class AppConstants {
  static String APPNAME = "ZenActive";
  static String logo = "assets/logo/zen_logo.png";
  static String splashImage = "assets/svg/splash.svg";
  static String fcmToken = "fcmToken";
  static String user = "user";
  static String userId = "userId";

  //Icons
  static String mailIcon = "assets/svg/mail.svg";
  static String eyeOff = "assets/svg/eye-off.svg";
  static String eyeOn = "assets/svg/eye-empty.svg";
  static String lockIcon = "assets/svg/lock.svg";
  static String appLogo = "assets/svg/logo.svg";
  static String backIcon = "assets/svg/backIcon.svg";
  static String maleIcon = "assets/svg/male.svg";
  static String femaleIcon = "assets/svg/female.svg";
  static String boostIcon = "assets/svg/flash.svg";
  static String walkIcon = "assets/svg/walk.svg";
  static String walkWithStyle = "assets/svg/walk_with_style.svg";
  static String uploadIcon = "assets/svg/upload.svg";
  static String downloadIcon = "assets/svg/download.svg";
  static String gymIcon = "assets/svg/gym.svg";
  static String maditationIcon = "assets/svg/maditation.svg";
  static String glutenIcon = "assets/svg/gluten.svg";
  static String ketoIcon = "assets/svg/keto.svg";
  static String vegitableIcon = "assets/svg/vegitable.svg";
  static String veganIcon = "assets/svg/vegan.svg";
  static String noPrefIcon = "assets/svg/no_pref.svg";

  // share preference Key
  static String THEME = "theme";

  static const String LANGUAGE_CODE = 'language_code';
  static const String COUNTRY_CODE = 'country_code';

  static RegExp emailValidator = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static RegExp passwordValidator = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
  static List<LanguageModel> languages = [
    LanguageModel(
        languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(languageName: 'عربى', countryCode: 'SA', languageCode: 'ar'),
    LanguageModel(
        languageName: 'Spanish', countryCode: 'ES', languageCode: 'es'),
  ];

  //Splash Screen Texts
  static String SPLASH_HEADER = "Achieve Your Fitness Goals!";
  static String SPLASH_SUB_HEADER =
      "Track your progress, take on challenges, and connect with a community of achievers";
  static String bearerToken = "bearerToken";
}
