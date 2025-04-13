import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:zenactive/controllers/auth_controller.dart';
import 'package:zenactive/controllers/home_controller.dart';
import 'package:zenactive/models/user_meal_plan.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_loading.dart';
import 'package:zenactive/views/components/feature_button.dart';
import 'package:zenactive/views/components/food_item_card.dart';
import 'package:zenactive/views/components/random_popup.dart';
import 'package:zenactive/views/components/section_dev.dart';
import 'package:zenactive/views/components/slidable_tab_bar.dart';
import 'package:zenactive/views/components/suggestion_card.dart';
import 'package:zenactive/views/screen/challenges/challenge_details_page.dart';
import 'package:zenactive/views/screen/home/ai_screen.dart';
import 'package:zenactive/views/screen/home/daily_workout_page.dart';
import 'package:zenactive/views/screen/home/mode_tracker_form_screen.dart';
import 'package:zenactive/views/screen/home/notification_screen.dart';
import 'package:zenactive/views/screen/home/select_calculator_screen.dart';
import 'package:zenactive/views/screen/home/todays_meal_page.dart';
import 'package:zenactive/views/screen/home/track_workout_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(int)? changePage;
  const HomeScreen({super.key, this.changePage});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController authController = Get.find<AuthController>();
  final HomeController homeController = Get.put(HomeController());

  int slidableIndex = 0;
  List<String> images = [];

  bool checkPoint = true;
  late Future<void> _userFuture; // Add a future

  List<String> reminders = [
    'Feeling tired? A quick nap could recharge you!',
    'Remember to drink water!',
    'Take a break and stretch your legs for a while!',
    'Have you eaten your breakfast yet?',
    'Remember to take your vitamins!',
    'Don\'t forget to take a walk today!',
    'Remember to take a deep breath and relax!',
    'Have you had your lunch yet?',
    'Remember to take a break and rest your eyes!',
    'Don\'t forget to take your medication!',
    'Remember to take a break and stretch your legs!',
    'Have you had your dinner yet?',
  ];

  @override
  void initState() {
    super.initState();
    _userFuture = authController.getUserDetails(); // Initialize the future
    homeController.getUserMealPlan();
    homeController.getDailyChallenges();
    //add post frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showRandomPopup();
    });
  }

  void _showRandomPopup() {
    final random = Random();
    final delay =
        Duration(seconds: random.nextInt(checkPoint ? 100 : 1000) + 50);

    Timer(delay, () {
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              //Make color transparent padding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              content: RandomPopup(
                title: reminders[random.nextInt(reminders.length)],
                svgPath: 'assets/svg/nap.svg',
              ),
            );
          },
        );

        setState(() {
          checkPoint = false;
        });
        _showRandomPopup(); // Schedule the next popup
      }
    });
  }

  Future<void> _refreshData() async {
    homeController.getUserMealPlan();
    homeController.getDailyChallenges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: RefreshIndicator(
            onRefresh: _refreshData,
            child: FutureBuilder<void>(
              // Wrap with FutureBuilder
              future: _userFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CustomLoading());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  // Data is loaded, safe to access authController.user.value
                  return SingleChildScrollView(
                    // Wrap Column with SingleChildScrollView
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Image.network(
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                                imageUrl(authController.user.value.image ??
                                    ''), // Handle null image
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey,
                                    height: 40,
                                    width: 40,
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Hello, ',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryTextColor,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: authController
                                                .user.value.name?.firstName ??
                                            'User', // Handle null name
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Ready to conquer today',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Get.to(() => AIScreen());
                              },
                              child: svgViewer(asset: 'assets/svg/gemini.svg'),
                            ),
                            SizedBox(width: 12.w),
                            InkWell(
                              onTap: () {
                                Get.to(() => NotificationScreen());
                              },
                              child: svgViewer(asset: 'assets/svg/bell.svg'),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                    width: 0.5.w,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.r),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          svgViewer(
                                              asset:
                                                  'assets/svg/fire-flame.svg'),
                                          SizedBox(width: 4.w),
                                          Text(
                                            'Calorie Intake',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 7.h),
                                      SingleChildScrollView(
                                        clipBehavior: Clip.none,
                                        reverse: false,
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                                text: TextSpan(
                                              text: authController
                                                      .user
                                                      .value
                                                      .userAppData
                                                      ?.gainedCalories!
                                                      .toStringAsFixed(0) ??
                                                  '0', //safe null
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    AppColors.primaryTextColor,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "/${authController.user.value.userAppData?.tdee?.toStringAsFixed(0) ?? '0'}kcal", //safe null
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors
                                                        .secondaryTextColor,
                                                  ),
                                                ),
                                              ],
                                            )),
                                            MediaQuery.removePadding(
                                              context: context,
                                              child: CircularPercentIndicator(
                                                  radius: 15.r,
                                                  lineWidth: 4.0,
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                  percent: (authController
                                                              .user
                                                              .value
                                                              .userAppData
                                                              ?.gainedCalories ??
                                                          0) /
                                                      (authController
                                                              .user
                                                              .value
                                                              .userAppData
                                                              ?.tdee ??
                                                          1), //safe null and avoid 0
                                                  progressColor:
                                                      AppColors.splashColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 18.w),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                    width: 0.5.w,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12.r),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          svgViewer(
                                              asset: 'assets/svg/timer.svg'),
                                          SizedBox(width: 4.w),
                                          Text(
                                            'Workout Time',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 7.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RichText(
                                              text: TextSpan(
                                            text: secondToFormattedTime(
                                                authController
                                                        .user
                                                        .value
                                                        .userAppData
                                                        ?.completedWorkoutTime ??
                                                    0),
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primaryTextColor,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    "/ ${secondToFormattedTime(authController.user.value.userAppData?.workoutTime ?? 0)}", //safe null
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors
                                                      .secondaryTextColor,
                                                ),
                                              ),
                                            ],
                                          )),
                                          MediaQuery.removePadding(
                                            context: context,
                                            child: CircularPercentIndicator(
                                                radius: 15.r,
                                                lineWidth: 4.0,
                                                circularStrokeCap:
                                                    CircularStrokeCap.round,
                                                percent: 0.75,
                                                progressColor:
                                                    AppColors.splashColor),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          spacing: 18.w,
                          children: [
                            Expanded(
                              child: FeatureButton(
                                svgAsset: 'assets/svg/boost.svg',
                                title: 'Count Calorie',
                                onTap: () {
                                  Get.to(() => SelectCalculatorScreen());
                                },
                              ),
                            ),
                            Expanded(
                              child: FeatureButton(
                                svgAsset: 'assets/svg/workouts.svg',
                                title: 'Track Workout',
                                onTap: () {
                                  Get.to(() => TrackWorkOutScreen());
                                },
                              ),
                            ),
                            Expanded(
                              child: FeatureButton(
                                svgAsset: 'assets/svg/senti.svg',
                                title: 'Track Mood',
                                onTap: () {
                                  Get.to(() => ModeTrackerFormScreen());
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        //Today Workout --- see all
                        SectionDev(
                          sectionName: 'Today\'s Challenge',
                          onTap: () {
                            Get.to(() => DailyChallengesPage());
                          },
                        ),
                        SizedBox(height: 12.h),
                        Obx(() {
                          return homeController.isLoading.value
                              ? Center(child: CustomLoading())
                              : SizedBox(
                                  height: 130.h, // Adjust height as needed
                                  child: ListView.builder(
                                    clipBehavior: Clip.none,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        homeController.exercises.length > 5
                                            ? 5
                                            : homeController.exercises
                                                .length, // Limit to 5 items
                                    itemBuilder: (context, index) {
                                      final exercise =
                                          homeController.exercises[index];

                                      return Padding(
                                        padding: EdgeInsets.only(
                                            right: 12.w), // Add spacing
                                        child: SuggestionCard(
                                          title:
                                              exercise.description ?? 'Unknown',
                                          imageUrl: imageUrl(exercise.image),
                                          onTap: () {
                                            if (exercise.isCompleted ?? false) {
                                              Get.snackbar('Already Completed',
                                                  'You have already completed this challenge');
                                              return;
                                            }
                                            Get.to(() => ChallengeDetailsPage(
                                                  exercise: exercise,
                                                ));
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                );
                        }),
                        SizedBox(height: 24.h),
                        SectionDev(
                          sectionName: 'Today Meal',
                          onTap: () {
                            Get.to(() => TodaysMealScreen());
                          },
                        ),

                        SizedBox(height: 12.h),
                        SlidableTabBar(
                          options: ['All', 'Completed'],
                          onChanged: (index) {
                            debugPrint('Tab changed to $index');
                            setState(() {
                              slidableIndex = index;
                            });
                          },
                          index: slidableIndex,
                        ),

                        SizedBox(height: 16.h),
                        Obx(() {
                          if (homeController.isLoading.value) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            var filteredMealPlans = homeController.userMealPlans
                                .where((meal) => (slidableIndex == 0)
                                    ? !meal.isCompleted!
                                    : meal.isCompleted!)
                                .toList();

                            if (filteredMealPlans.isEmpty) {
                              return Column(
                                // Changed from Expanded to Column
                                children: [
                                  ListView.builder(
                                    shrinkWrap:
                                        true, // Important for nested lists
                                    physics:
                                        NeverScrollableScrollPhysics(), // Disable scrolling here
                                    itemCount:
                                        homeController.adminsMealPlans.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 12.h),
                                        child: FoodItemCard(
                                          foodName: homeController
                                              .adminsMealPlans[index].mealName!,
                                          imageUrl: imageUrl(homeController
                                              .adminsMealPlans[index].image!),
                                          kcal: homeController
                                              .adminsMealPlans[index]
                                              .nutritionalInfo!
                                              .calories!,
                                          carbs: homeController
                                              .adminsMealPlans[index]
                                              .nutritionalInfo!
                                              .carbs!,
                                          protein: homeController
                                              .adminsMealPlans[index]
                                              .nutritionalInfo!
                                              .proteins!,
                                          fat: homeController
                                              .adminsMealPlans[index]
                                              .nutritionalInfo!
                                              .fats!,
                                          amount: homeController
                                              .adminsMealPlans[index].amount!,
                                          taken: homeController
                                              .adminsMealPlans[index]
                                              .isCompleted!,
                                          isAdmins: true,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            } else {
                              debugPrint(
                                  'Filtered meal plans: ${filteredMealPlans.length}');
                              return Column(
                                // Changed from Expanded to Column
                                children: [
                                  ListView.builder(
                                    shrinkWrap:
                                        true, // Important for nested lists
                                    physics:
                                        NeverScrollableScrollPhysics(), // Disable scrolling here
                                    itemCount: filteredMealPlans.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 12.h),
                                        child: FoodItemCard(
                                          foodName: filteredMealPlans[index]
                                              .mealName!,
                                          imageUrl: imageUrl(
                                              filteredMealPlans[index].image!),
                                          kcal: filteredMealPlans[index]
                                              .nutritionalInfo!
                                              .calories!,
                                          carbs: filteredMealPlans[index]
                                              .nutritionalInfo!
                                              .carbs!,
                                          protein: filteredMealPlans[index]
                                              .nutritionalInfo!
                                              .proteins!,
                                          fat: filteredMealPlans[index]
                                              .nutritionalInfo!
                                              .fats!,
                                          amount:
                                              filteredMealPlans[index].amount!,
                                          taken: filteredMealPlans[index]
                                              .isCompleted!,
                                          isAdmins: false,
                                          onTap: () {
                                            if (filteredMealPlans[index]
                                                .isCompleted!) {
                                              return;
                                            }
                                            debugPrint(
                                                'Meal plan tapped $index');
                                            UserMealPlan mealPlan =
                                                filteredMealPlans[index]
                                                    .copyWith(
                                              isCompleted: true,
                                            );
                                            homeController.updateMealPlan(
                                              mealPlan,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            }
                          }
                        }),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
