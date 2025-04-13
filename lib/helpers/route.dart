import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/views/screen/auth/otp_verify_screen.dart';
import 'package:zenactive/views/screen/challenges/challenges_page.dart';
import 'package:zenactive/views/screen/app.dart';
import 'package:zenactive/views/screen/auth/forget_password.dart';
import 'package:zenactive/views/screen/auth/sign_in_screen.dart';
import 'package:zenactive/views/screen/auth/signup_screen.dart';
import 'package:zenactive/views/screen/auth/user_info_page_stack.dart';
import 'package:zenactive/views/screen/splash/splash_screen.dart';

import 'package:zenactive/views/screen/workout/optimize_traning_completion_page.dart';
import 'package:zenactive/views/screen/workout/optimize_traning_page.dart';
import 'package:zenactive/views/screen/workout/plan_details_page.dart';
import 'package:zenactive/views/screen/workout/workout_page.dart';
import 'package:zenactive/views/screen/workout/workout_plans_page.dart';
import 'package:zenactive/views/screen/workout/workout_progress_page.dart';
import 'package:zenactive/views/screen/workout/workout_videos_page.dart';
import 'package:zenactive/views/screen/workout/workout_video_comments_page.dart';
import 'package:zenactive/views/screen/workout/workout_video_playing_page.dart';

import 'package:zenactive/views/screen/profile/about_us_page.dart';
import 'package:zenactive/views/screen/profile/card_details_page.dart';
import 'package:zenactive/views/screen/profile/current_subscription_page.dart';
import 'package:zenactive/views/screen/profile/leaderboard_page.dart';
import 'package:zenactive/views/screen/profile/offline_videos_page.dart';
import 'package:zenactive/views/screen/profile/payment_method_page.dart';
import 'package:zenactive/views/screen/profile/privary_policy_page.dart';
import 'package:zenactive/views/screen/profile/profile_information_screen.dart';
import 'package:zenactive/views/screen/profile/profile_page.dart';
import 'package:zenactive/views/screen/profile/rewards_store_page.dart';
import 'package:zenactive/views/screen/profile/settings_page.dart';
import 'package:zenactive/views/screen/profile/subscription_confirmation_page.dart';
import 'package:zenactive/views/screen/profile/subscription_page.dart';
import 'package:zenactive/views/screen/profile/terms_of_services_page.dart';

class AppRoutes {
  static String app = "/app";
  static String splashScreen = "/splash_screen";
  static String signUpScreen = "/sign_up_screen";
  static String signInScreen = "/sign_in_screen";
  static String forgetPassword = "/forget_password";
  static String userInfoStack = "/user_info_stack";
  static String otpVerify = "/otp_verify";

  // Challenges
  static String challengesPage = "/challenges_page";
  static String challengeDetailsPage = '/challenge_details_page';
  static String challengeProgressPage = '/challenge_progress_page';

  // Workout Pages
  static String workoutPage = "/workout_page";
  static String workoutPlansPage = "/workout_plans_page";
  static String workoutPlansDetailsPage = "/workout_plan_details_page";
  static String optimizeTrainingPage = "/optimize_training_page";
  static String optimizeTrainingCompletionPage =
      "/optimize_training_completion_page";
  static String workoutProgressPage = "/workout_progress_page";
  static String workoutVideosPage = "/workout_videos_page";
  static String workoutVideoPlayingPage = "/workout_video_playing_page";
  static String workoutVideoCommentsPage = "/workout_video_comments_page";

  // Profile Pages
  static String aboutUsPage = "/about_us_page";
  static String cardDetailsPage = "/card_details_page";
  static String currentSubscriptionPage = "/current_subscription_page";
  static String leaderboardPage = "/leaderboard_page";
  static String offlineVideosPage = "/offline_videos_page";
  static String paymentMethodPage = "/payment_method_page";
  static String privacyPolicyPage = "/privacy_policy_page";
  static String profileInformationScreen = "/profile_information_screen";
  static String profilePage = "/profile_page";
  static String redeemRewardsStorePage = "/redeem_rewards_store_page";
  static String rewardsStorePage = "/rewards_store_page";
  static String rewardConfirmationPage = "/reward_confirmation_page";
  static String settingsPage = "/settings_page";
  static String subscriptionConfirmationPage =
      "/subscription_confirmation_page";
  static String subscriptionPage = "/subscription_page";
  static String termsOfServicesPage = "/terms_of_services_page";

  static List<GetPage> pages = [
    GetPage(
      name: app,
      page: () => const App(key: PageStorageKey('app')),
    ),
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: signUpScreen, page: () => SignupScreen()),
    GetPage(name: signInScreen, page: () => SigninScreen()),
    GetPage(name: forgetPassword, page: () => ForgetPassword()),
    GetPage(name: userInfoStack, page: () => UserInfoPageStack()),
    GetPage(name: otpVerify, page: () => OtpVerifyScreen()),

    // Challenges
    GetPage(name: challengesPage, page: () => ChallengesPage()),
    // GetPage(name: challengeProgressPage, page: () => ChallengeProgressPage()),

    // Workout Pages
    GetPage(name: workoutPage, page: () => WorkoutPage()),
    GetPage(name: workoutPlansPage, page: () => WorkoutPlansPage()),
    GetPage(name: workoutPlansDetailsPage, page: () => PlanDetailsPage()),
    GetPage(name: optimizeTrainingPage, page: () => OptimizeTraningPage()),
    GetPage(
        name: optimizeTrainingCompletionPage,
        page: () => OptimizeTraningCompletionPage()),
    GetPage(name: workoutProgressPage, page: () => WorkoutProgressPage()),
    GetPage(name: workoutVideosPage, page: () => WorkoutVideosPage()),
    GetPage(
        name: workoutVideoPlayingPage, page: () => WorkoutVideoPlayingPage()),
    GetPage(
        name: workoutVideoCommentsPage, page: () => WorkoutVideoCommentsPage()),

    // Profile Pages
    GetPage(name: aboutUsPage, page: () => AboutUsPage()),
    GetPage(name: cardDetailsPage, page: () => CardDetailsPage()),
    GetPage(
        name: currentSubscriptionPage, page: () => CurrentSubscriptionPage()),
    GetPage(name: leaderboardPage, page: () => LeaderboardPage()),
    GetPage(name: offlineVideosPage, page: () => OfflineVideosPage()),
    GetPage(name: paymentMethodPage, page: () => PaymentMethodPage()),
    GetPage(name: privacyPolicyPage, page: () => PrivaryPolicyPage()),
    GetPage(
        name: profileInformationScreen, page: () => ProfileInformationScreen()),
    GetPage(name: profilePage, page: () => ProfilePage()),
    // GetPage(name: redeemRewardsStorePage, page: () => RedeemRewardsStorePage()),
    GetPage(name: rewardsStorePage, page: () => RewardsStorePage()),
    // GetPage(name: rewardConfirmationPage, page: () => RewardConfirmationPage()),
    GetPage(name: settingsPage, page: () => SettingsPage()),
    GetPage(
        name: subscriptionConfirmationPage,
        page: () => SubscriptionConfirmationPage()),
    GetPage(name: subscriptionPage, page: () => SubscriptionPage()),
    GetPage(name: termsOfServicesPage, page: () => TermsOfServicesPage()),
  ];
}
