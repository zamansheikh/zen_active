import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zen_active/models/user_meal_plan.dart';
import 'package:zen_active/services/api_client.dart';
import 'package:zen_active/services/api_constant.dart';
import 'package:zen_active/utils/app_constants.dart';
import 'package:zen_active/utils/prefs_helper.dart';

class HomeController extends GetxController implements GetxService {
  String title = "Home Screen";
  RxBool isLoading = false.obs;

  RxList<UserMealPlan> userMealPlans = <UserMealPlan>[].obs;
  RxList<UserMealPlan> adminsMealPlans = <UserMealPlan>[].obs;

  //GET USER MEAL PLAN
  void getUserMealPlan() async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.getData(
        ApiConstant.getUserMealPlan,
        headers: headers,
      );
      if (response.body["status"] == 200) {
        try {
          userMealPlans.value = response.body["data"]
              .map<UserMealPlan>((json) => UserMealPlan.fromJson(json))
              .toList();
          "Success with ${userMealPlans.length} meal plans".printInfo;
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
