import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:zen_active/controllers/auth_controller.dart';
import 'package:zen_active/controllers/home_controller.dart';
import 'package:zen_active/models/user_meal_plan.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/feature_button.dart';
import 'package:zen_active/views/components/food_item_card.dart';
import 'package:zen_active/views/components/random_popup.dart';
import 'package:zen_active/views/components/section_dev.dart';
import 'package:zen_active/views/components/slidable_tab_bar.dart';
import 'package:zen_active/views/components/suggestion_card.dart';
import 'package:zen_active/views/screen/home/ai_screen.dart';
import 'package:zen_active/views/screen/home/mode_tracker_form_screen.dart';
import 'package:zen_active/views/screen/home/notification_screen.dart';
import 'package:zen_active/views/screen/home/select_calculator_screen.dart';
import 'package:zen_active/views/screen/home/track_workout_screen.dart';

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
  void apiCall() async {
    authController.getUserDetails();
    homeController.getUserMealPlan();
  }

  @override
  void initState() {
    super.initState();
    // _showRandomPopup();
    apiCall();
  }

  _showDistructPopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //Make color transparent padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            content: RandomPopup(
              hasCrossButton: true,
              title: 'Feeling tired? A quick nap could recharge you!',
              svgPath: 'assets/svg/nap.svg',
            ),
          );
        });
  }

  void _showRandomPopup() {
    final random = Random();
    final delay = Duration(seconds: random.nextInt(checkPoint ? 10 : 1000) + 5);

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
                title: 'Feeling tired? A quick nap could recharge you!',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Obx(() {
            if (authController.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: Image.network(imageUrl(
                          authController.user.value.image!,
                        )).image,
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
                                  text:
                                      authController.user.value.name!.firstName,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    svgViewer(
                                        asset: 'assets/svg/fire-flame.svg'),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                      text: authController.user.value
                                          .userAppData!.gainedCalories!
                                          .toStringAsFixed(0),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              "/${authController.user.value.userAppData!.tdee!.toStringAsFixed(0)}kcal",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.secondaryTextColor,
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
                                          percent: authController
                                                  .user
                                                  .value
                                                  .userAppData!
                                                  .gainedCalories! /
                                              authController.user.value
                                                  .userAppData!.tdee!,
                                          progressColor: AppColors.splashColor),
                                    ),
                                  ],
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    svgViewer(asset: 'assets/svg/timer.svg'),
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
                                      text: secondToFormattedTime(6100),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              "/ ${secondToFormattedTime(authController.user.value.userAppData!.workoutTime!)}",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.secondaryTextColor,
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
                                          progressColor: AppColors.splashColor),
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
                    sectionName: 'Today Workout',
                    onTap: () {
                      setState(() {
                        widget.changePage!(1);
                      });
                    },
                  ),
                  SizedBox(height: 12.h),
                  SingleChildScrollView(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    child: Row(spacing: 12.w, children: [
                      SuggestionCard(
                          title:
                              'Boost your focus with a 5-minute guided meditation',
                          imageUrl: 'assets/images/banner1.jpg'),
                      SuggestionCard(
                          title:
                              'Feeling energetic? Go for a 30-minute HIIT session!',
                          imageUrl: 'assets/images/banner2.jpg'),
                    ]),
                  ),
                  SizedBox(height: 24.h),
                  SectionDev(
                    sectionName: 'Today Meal',
                    onTap: () {},
                  ),

                  SizedBox(height: 12.h),
                  SlidableTabBar(
                    options: ['All', 'Completed'],
                    onChanged: (index) {
                      print('Tab changed to $index');
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
                        return Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: homeController.adminsMealPlans.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: FoodItemCard(
                                  foodName: homeController
                                      .adminsMealPlans[index].mealName!,
                                  imageUrl: imageUrl(homeController
                                      .adminsMealPlans[index].image!),
                                  kcal: homeController.adminsMealPlans[index]
                                      .nutritionalInfo!.calories!,
                                  carbs: homeController.adminsMealPlans[index]
                                      .nutritionalInfo!.carbs!,
                                  protein: homeController.adminsMealPlans[index]
                                      .nutritionalInfo!.proteins!,
                                  fat: homeController.adminsMealPlans[index]
                                      .nutritionalInfo!.fats!,
                                  amount: homeController
                                      .adminsMealPlans[index].amount!,
                                  taken: homeController
                                      .adminsMealPlans[index].isCompleted!,
                                  isAdmins: true,
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        print(
                            'Filtered meal plans: ${filteredMealPlans.length}');
                        return Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: filteredMealPlans.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: FoodItemCard(
                                  foodName: filteredMealPlans[index].mealName!,
                                  imageUrl:
                                      imageUrl(filteredMealPlans[index].image!),
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
                                  amount: filteredMealPlans[index].amount!,
                                  taken: filteredMealPlans[index].isCompleted!,
                                  isAdmins: false,
                                  onTap: () {
                                    if (filteredMealPlans[index].isCompleted!) {
                                      return;
                                    }
                                    print('Meal plan tapped $index');
                                    UserMealPlan mealPlan =
                                        filteredMealPlans[index].copyWith(
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
                        );
                      }
                    }
                  }),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
