import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/home_controller.dart';
import 'package:zenactive/models/user_meal_plan.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/components/food_item_card.dart';
import 'package:zenactive/views/components/slidable_tab_bar.dart';
import 'package:zenactive/views/screen/home/todays_meal_creation_page.dart';

class TodaysMealScreen extends StatefulWidget {
  const TodaysMealScreen({super.key});

  @override
  State<TodaysMealScreen> createState() => _TodaysMealScreenState();
}

class _TodaysMealScreenState extends State<TodaysMealScreen> {
  int selectedIndex = 0;
  final HomeController controller = Get.find<HomeController>();
  List<String> mealTypes = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
  ];
  List<UserMealPlan> listMeal = [];

  @override
  void initState() {
    super.initState();
    listMeal = controller.userMealPlans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  CustomAppBar(
                    backgroundColor: AppColors.backgroundColor,
                    title: 'Todays Meal',
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SlidableTabBar(
                          options: mealTypes,
                          index: selectedIndex,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.only(bottom: 12.h, left: 24.w, right: 24.w),
                    child: FoodItemCard(
                      foodName: listMeal[index].mealName!,
                      imageUrl: imageUrl(listMeal[index].image!),
                      kcal: listMeal[index].nutritionalInfo!.calories!,
                      carbs: listMeal[index].nutritionalInfo!.carbs!,
                      protein: listMeal[index].nutritionalInfo!.proteins!,
                      fat: listMeal[index].nutritionalInfo!.fats!,
                      amount: listMeal[index].amount!,
                      taken: listMeal[index].isCompleted!,
                      isAdmins: false,
                    ),
                  );
                },
                childCount: listMeal.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: CustomButton(
                  buttonName: "Create Meal Plan",
                  onPressed: () {
                    Get.to(() => TodaysMealCreationScreen());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
