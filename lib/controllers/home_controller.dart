import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zenactive/models/exercise_model.dart';
import 'package:zenactive/models/user_meal_plan.dart';
import 'package:zenactive/services/api_client.dart';
import 'package:zenactive/services/api_constant.dart';
import 'package:zenactive/utils/app_constants.dart';
import 'package:zenactive/utils/prefs_helper.dart';

class HomeController extends GetxController implements GetxService {
  String title = "Home Screen";
  RxBool isLoading = false.obs;

  RxList<UserMealPlan> userMealPlans = <UserMealPlan>[].obs;
  RxList<UserMealPlan> adminsMealPlans = <UserMealPlan>[].obs;
  RxList<ExerciseModel> exercises = <ExerciseModel>[].obs;

  // Computed property to get available meals
  List<UserMealPlan> get availableMeals {
    return adminsMealPlans.where((adminMeal) {
      // Check if any user meal plan has the same ID as the admin meal plan
      return !userMealPlans.any((userMeal) => userMeal.id == adminMeal.id);
    }).toList();
  }

  //GET USER MEAL PLAN
  void getUserMealPlan() async {
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      isLoading.value = true;

      final response = await ApiClient.getData(
        ApiConstant.getUserMealPlan,
        headers: headers,
      );
      if (response.statusCode == 200) {
        try {
          userMealPlans.value = response.body["data"]
              .map<UserMealPlan>((json) => UserMealPlan.fromJson(json))
              .toList();
          "Success with ${userMealPlans.length} User Meal plans".printInfo;
          //! TODO: Extra Task
          try {
            getadminMealPlan();
          } catch (e) {
            print(e.toString());
          }
        } catch (e) {
          debugPrint('Model Convertion Error: ${e.toString()}');
          isLoading.value = false;
        }
      }
    } catch (e) {
      debugPrint('------------${e.toString()}');
    }

    isLoading.value = false;
  }

  //GET USER MEAL PLAN
  void getadminMealPlan() async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.getData(
        ApiConstant.getMealPlan,
        headers: headers,
      );
      if (response.body["status"] == 200) {
        try {
          adminsMealPlans.value = response.body["data"]
              .map<UserMealPlan>((json) => UserMealPlan.fromJson(json))
              .toList();
          "Success with ${adminsMealPlans.length} meal plans".printInfo;
        } catch (e) {
          debugPrint('Model Convertion Error: ${e.toString()}');
          isLoading.value = false;
        }
      }
    } catch (e) {
      debugPrint('------------${e.toString()}');
    }

    isLoading.value = false;
  }

  void updateMealPlan(UserMealPlan mealPlan) async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    final index =
        userMealPlans.indexWhere((element) => element.id == mealPlan.id);

    try {
      final response = await ApiClient.patchData(
        ApiConstant.updateAsTaken + mealPlan.id!,
        {},
        headers: headers,
      );
      if (response.body["status"] == 200) {
        userMealPlans[index] = mealPlan;
        userMealPlans.refresh();
      }
    } catch (e) {
      debugPrint('------------${e.toString()}');
    }
    isLoading.value = false;
  }

  void getDailyChallenges() async {
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      isLoading.value = true;

      final response = await ApiClient.getData(
        ApiConstant.getDailyExercise,
        headers: headers,
      );
      if (response.statusCode == 200) {
        try {
          exercises.value = response.body["data"]
              .map<ExerciseModel>((e) => ExerciseModel.fromJson(e))
              .toList();
        } catch (e) {
          debugPrint('Model Convertion Error: ${e.toString()}');
          isLoading.value = false;
        }
      }
    } catch (e) {
      debugPrint('------------${e.toString()}');
    }
    isLoading.value = false;
  }

  void addMealPlan(String id) async {
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      isLoading.value = true;

      var body = {
        "mealId": id,
      };

      final response = await ApiClient.postData(
        ApiConstant.addMealPlan,
        jsonEncode(body),
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar("Success", "Meal Plan Added Successfully");
        getUserMealPlan();
      } else {
        Get.snackbar("Error", "Meal Plan Not Added");
      }
    } catch (e) {
      debugPrint('------------${e.toString()}');
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    debugPrint("On Init  $title");

    super.onInit();
  }

  @override
  void onReady() {
    debugPrint("On onReady  $title");
    super.onReady();
  }
}
