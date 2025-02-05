import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/feature_button.dart';
import 'package:zen_active/views/components/food_item_card.dart';
import 'package:zen_active/views/components/random_popup.dart';
import 'package:zen_active/views/components/section_dev.dart';
import 'package:zen_active/views/components/slidable_tab_bar.dart';
import 'package:zen_active/views/components/suggestion_card.dart';
import 'package:zen_active/views/screen/Home/ai_screen.dart';
import 'package:zen_active/views/screen/Home/mood_tracker_form_screen.dart';
import 'package:zen_active/views/screen/Home/notification_screen.dart';
import 'package:zen_active/views/screen/Home/select_calculator_screen.dart';
import 'package:zen_active/views/screen/Home/track_workout_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(int)? changePage;
  const HomeScreen({super.key, this.changePage});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> images = [
    'https://s3-alpha-sig.figma.com/img/b97f/3445/3cfa17c61a357bcf8fad128ff59de03c?Expires=1739145600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=bv7rgBpTMMnwpZBFHt4cmRD5xU1GSvRfC7dktCEsa6CzxnqQ1C8ILEQP5On8Xem7G4~DT8nbU30FTB7H-8Po8ggmO9rsijf18GPoAlKWa-8lI3EAL9SSpA4R9iA5URZmrbuG4SME~D-XSiJEb0blMQhOPZeUA7cVZV1JPQgm02dsZWU1Es1ttxUMMWACx2rM4bDfeZ5PxJ9C~RtHNyVOyv3VOytr~dBuzeJNGvitxUCBLNoEbieH9pkQrLSBPnLT8KDkRvzH6PC577J3b-0xve83Es7p0vTyPcm44ie5xb-ucci6ZEgtTQ7VmEAwlN-R1uY6wcxugd8flbWto5sx0A__',
    'https://s3-alpha-sig.figma.com/img/212f/a1f9/ed913cb886d076193af6cf5481359d7b?Expires=1739145600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=cQpBPet31O3XPxW4asZCO8HoYnAsjv8msO-jenKvaWY4R7cM4spgp0sRK-EMvT5aAIdHkUII1~udVaG9ztsaMsUynf5bVX90q3pyX8PGdNGppKXSEyV~z~pUy0~pdW7othx1kEbrYQI2azeN~nif3JH6Rkekpf5nnDygdJrDnWHjHnQ3NsqmUBzkDmHClX~wjPXhzQ4rQyJceM4YXARdgWaiJnGb7x8qoAJ~ooLCODk~MnFyOlheyN13GWW3JGYE9CR2naI~ogJq3u1OlJSPo3ZVxfar2Q5Z1p4oqDJsSUyBGg0vh~SSOwKIwWY56WDVCKwWi4Q5MfUaXom0a3sO8Q__',
    'https://s3-alpha-sig.figma.com/img/bd59/bedf/c81d55cf2715d16603e71c8bf7746754?Expires=1739145600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=uZDoiQwGin1lBJXfA7Rb3JeG9dD0zbXqPCenTC1jHNMAZryxk9lWEMOEeAXC3axY6rmp4Y3-nct4zIIySj0Id2FiwssNCLPP-SeWOVriE3FZU4u-Pl5aTDLzN~8cCZfoGHdnQhgsD9DjUnGSzyR8BUO2KASconXE2r7CTQwxTAaGMcIiQwO6VXxdOpAA2zLnVW7qcLRrJLsyy~Nc8aGBfIPZ0nBEQgWBvCAvvhYoikdvs0mlEJXKudNzDilsUAKgMaWl7AkSBe4VSQU5Tu65SlGj4iQIV0tJ1Bfsddq8yuhPYCSPxjG9EoSaP-gE6L7I09OtSJm4baGVHCCO-eMGzA__',
  ];

  bool checkPoint = true;

  @override
  void initState() {
    super.initState();
    _showRandomPopup();
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
          child: Column(
            children: [
              const SizedBox(height: 24),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/user.png'),
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
                              text: 'Arlene',
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
                                svgViewer(asset: 'assets/svg/fire-flame.svg'),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                  text: '350',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryTextColor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '/1,800kcal',
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
                                      percent: 0.25,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    text: TextSpan(
                                  text: '1h 30m',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryTextColor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' / 2h',
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
                        Get.to(() => MoodTrackerFormScreen());
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
                },
                index: 0,
              ),

              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: FoodItemCard(
                        foodName: 'Grilled Chicken Salad',
                        imageUrl: images[index],
                        kcal: 320,
                        carbs: 12,
                        protein: 32,
                        fat: 8,
                        amount: 1,
                        taken: index == 0,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
