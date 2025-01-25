import 'package:flutter/cupertino.dart';

class AppColors {
  //Splash Screen
  static Color splashColor = const Color(0xFF37B5FF);
  static Color splashBackgrond = const Color(0xFFFFFFFF);
  static Color splashTextColor = const Color(0xFF124A6A);
  static Color splashSubTextColor = const Color(0xFF757575);
  static Color splashHeaderTextColor = const Color(0xFF4B4B4B);
  static Color splashButtonColor = const Color(0xFF174C6B);

  //Basic Colors
  static Color backgroundColor = const Color(0xFFFFFFFF);
  static Color textInputBorderColor = const Color(0xFF79CDFF);
  static Color textColorSub = const Color(0xFF2781B5);

  static Color primaryColor = const Color(0xFF2683EB);
  static Color cardColor = const Color(0xFF2F2F2F);
  static Color cardLightColor = const Color(0xFF555555);
  static Color borderColor = const Color(0xFF2683EB);
  static Color subTextColor = const Color(0xFFE8E8E8);
  static Color hintColor = const Color(0xFF8B8B8B);
  static Color greyColor = const Color(0xFFB5B5B5);
  static Color fillColor = const Color(0xFFE9F3FD).withAlpha(30);
  static Color dividerColor = const Color(0xFF555555);
  static Color shadowColor = const Color(0xFF2B2A2A);
  static Color bottomBarColor = const Color(0xFF343434);

  static BoxShadow shadow = BoxShadow(
    blurRadius: 4,
    spreadRadius: 0,
    color: shadowColor,
    offset: const Offset(0, 2),
  );
}
