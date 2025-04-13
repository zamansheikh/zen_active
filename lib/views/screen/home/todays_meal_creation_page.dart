import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/home_controller.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/components/custom_loading.dart';
import 'package:zenactive/views/components/custom_search_bar.dart';
import 'package:zenactive/views/components/food_item_card.dart';
import 'package:zenactive/views/components/slidable_tab_bar.dart';

class TodaysMealCreationScreen extends StatefulWidget {
  const TodaysMealCreationScreen({super.key});

  @override
  State<TodaysMealCreationScreen> createState() =>
      _TodaysMealCreationScreenState();
}

class _TodaysMealCreationScreenState extends State<TodaysMealCreationScreen> {
  int selectedIndex = 0;
  final HomeController controller = Get.find<HomeController>();
  List<String> mealTypes = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
  ];
  @override
  void initState() {
    super.initState();
    controller.getUserMealPlan();
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
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 12.h),
                child: CustomSearchBar(
                  hintText: "Search food",
                  controller: TextEditingController(),
                ),
              ),
            ),
            Obx(() {
              // Use Obx for reactivity
              if (controller.isLoading.value) {
                return SliverToBoxAdapter(
                  child: Center(child: CustomLoading()),
                );
              }

              // Use the computed property for the filtered list
              final availableMeals = controller.availableMeals;

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: 12.h, left: 24.w, right: 24.w),
                      child: FoodItemCard(
                        foodName: availableMeals[index].mealName!,
                        imageUrl: imageUrl(availableMeals[index].image!),
                        kcal: availableMeals[index].nutritionalInfo!.calories!,
                        carbs: availableMeals[index].nutritionalInfo!.carbs!,
                        protein:
                            availableMeals[index].nutritionalInfo!.proteins!,
                        fat: availableMeals[index].nutritionalInfo!.fats!,
                        amount: availableMeals[index].amount!,
                        taken: availableMeals[index]
                            .isCompleted!, // This should probably be false or based on user data, not admin data
                        isAdmins:
                            false, // You probably want this to be true, as these *are* admin meals
                        onTap: () {
                          controller.addMealPlan(availableMeals[index].id!);
                        },
                      ),
                    );
                  },
                  childCount: availableMeals.length,
                ),
              );
            }),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: CustomButton(
                  buttonName: "Create Meal Plan",
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
