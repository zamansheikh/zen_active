class ApiConstant {
  static String baseUrl = "http://192.168.10.18:3500/api";
  static String imageBaseUrl = "http://192.168.10.18:3500";

  //  Socket service
  static String socketUrl = "http://192.168.10.18:3500";
  //Auth Service
  static String authLogin = "/auth/login";
  static String getMe = "/user/me";
  static String authSignUp = "/user/create-user";
  static String otpVerify = "/auth/verify-user";
  static String updateUser = "/user/update-user";
  static String getUserMealPlan = "/meal-plan";
  static String getMealPlan = "/meal";
  static String updateAsTaken = "/meal-plan/";
}
