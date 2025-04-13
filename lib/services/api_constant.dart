class ApiConstant {
  static String baseUrl = "http://82.25.85.126:3500/api";
  static String imageBaseUrl = "http://82.25.85.126:3500/";
  
  //  Socket service
  static String socketUrl = "http://82.25.85.126:3500/";
  //Auth Service
  static String authLogin = "/auth/login";
  static String getMe = "/user/me";
  static String authSignUp = "/user/create-user";
  static String otpVerify = "/auth/verify-user";
  static String updateUser = "/user/update-user";
  static String getUserMealPlan = "/meal-plan";
  static String getDailyWorkout = "/workout";
  static String getMealPlan = "/meal";
  static String updateAsTaken = "/meal-plan/";
  static String addMealPlan = "/meal-plan/";
  static String getExercise = "/exercise/";
  static String getDailyExercise = "/daily-exercise/daily-challenge";
  static String addWorkOutTime = "/app-data/add-workout-time";
  static String dailyWorkOut = "/daily-exercise";
  static String workoutPlan(int num) => "/workout-plan/?duration=$num";
  static String allPost = "/post/all-user-post/";
  static String allGroupPost = "/post/user-all-group-post/?page=1";
  static String allGroupPostbyId(String id) => "/post/group-post/$id?page=1";
  static String getSinglePostCommnent(String id) => "/comment/post/$id";
  static String allMyGroup = "/user-group/all-user-group";
  static String inviteToAGroup(String id) => "/user-group/invite-user-list/$id";
  static String inviteFriendToAGroup = "/user-group/invite-user";
  static String getAllGroup = "/group/";
  static String joinAGroup(String id) => "/user-group/join/$id";
  static String allMyGroupWithSearch(String searchKey) =>
      "/user-group/all-user-group?searchTerm=$searchKey";
  static String getAllFriend = "/friend/suggested";
  static String getMyFriends = "/friend";
  static String sendRequest = "/friend/send-request";
  static String acceptRequest = "/friend/accept-request";
  static String requestedList = "friend/pending";
  static String addPost = "/post/create/";
  static String createUserWorkoutPlan =
      "/workout-plan/create-user-workout-plan";
  static String geSignleWorkoutPlan(String id) =>
      "/workout-plan/get-user-workout-plan/$id";
  static String hitNextWorkOut(String id) =>
      "/workout-plan/update-user-workout-plan/$id";
  static String getUserMessages(String id) => "chat/get-user-chat/$id";
  static String userBadges = "/badge";
  static String buyUseBadges = "/user-badge/";

  //Settings
  static String getPrivacy = "/privacy&terms/privacy";
  static String getTerms = "/privacy&terms/terms";
  static String getAboutUs = "/privacy&terms/about-us";

  //LeaderBoard
  static String getLeaderBoard = "/app-data/leaderboard";
  //Video Section
  static String getWorkOutVideos = "/workout-video/";
  static String getCommnentOfASignleVideo(String id) => "/comment/video/$id";

  //Community
  static String getNotifications = "/notification";
  static String readNotification(String id) => "/notification/$id";
  static String updateGroup(String id) => "/group/$id";
  static String getSingleGroupDetails(String id) => "/group/$id";
  static String joinGroup(String id) => "/user-group/join/$id";
  static String createGroup = "/group/create-group";
  static String addComment = "/comment/add-comment";
  static String togglelike = "/like/toggle-like";
  static String getLastMessages = "/friend/with-last-message";
}
