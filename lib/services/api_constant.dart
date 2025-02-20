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
  static String getExercise = "/exercise/";
  static String addWorkOutTime = "/app-data/add-workout-time";
  static String dailyWorkOut = "/daily-exercise";
  static String workoutPlan = "/workout-plan/";
  static String createUserWorkoutPlan =
      "/workout-plan/create-user-workout-plan";
  static String geSignleWorkoutPlan(String id) =>
      "workout-plan/get-user-workout-plan/$id";
}
