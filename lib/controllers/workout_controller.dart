import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/models/single_workout_model.dart';
import 'package:zen_active/models/workout_plan_model.dart';
import 'package:zen_active/services/api_client.dart';
import 'package:zen_active/services/api_constant.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/app_constants.dart';
import 'package:zen_active/utils/prefs_helper.dart';

class WorkoutController extends GetxController implements GetxService {
  String title = "WorkOut Screen";
  RxBool isLoading = false.obs;
  RxBool hasJoined = false.obs;

  RxList<WorkoutModel> workOutPlan = <WorkoutModel>[].obs;
  Rx<SingleWorkoutModel> singleWorkout = SingleWorkoutModel().obs;

  void getAllWorkOutPlan() async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.getData(
        ApiConstant.workoutPlan,
        headers: headers,
      );
      if (response.body["status"] == 200) {
        try {
          workOutPlan.value = response.body["data"]
              .map<WorkoutModel>((e) => WorkoutModel.fromJson(e))
              .toList();
          hasJoined.value = false;
        } catch (e) {
          debugPrint('Model Convertion Error: ${e.toString()}');
          isLoading.value = false;
          hasJoined.value = false;
        }
      }
    } catch (e) {
      debugPrint('------------${e.toString()}');
    }
    isLoading.value = false;
  }

  void getSingleWorkOutPlan(String id) async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.getData(
        ApiConstant.geSignleWorkoutPlan(id),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Single Workout Plan: ${response.body}');
        singleWorkout.value =
            SingleWorkoutModel.fromJson(response.body["data"]);
        isLoading.value = false;
      }
    } catch (e) {
      debugPrint('------------${e.toString()}');
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  void nextExercise(String id) async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.patchData(
          ApiConstant.hitNextWorkOut(id), headers: headers, {});

      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;
        getSingleWorkOutPlan(id);
      } else {
        //Show SnackBar
        Get.snackbar(
          'Error',
          response.body["message"],
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: AppColors.splashColor,
        );
        isLoading.value = false;
      }
    } catch (e) {
      debugPrint('------------${e.toString()}');
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  void joinAWorkOutPlan(String workoutId) async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };

    var body = {"workoutPlanId": workoutId};
    try {
      final response = await ApiClient.postData(
        ApiConstant.createUserWorkoutPlan,
        headers: headers,
        jsonEncode(body),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;
        hasJoined.value = true;
      }
      getAllWorkOutPlan();
    } catch (e) {
      debugPrint('------------${e.toString()}');
    }
    isLoading.value = false;
  }

  void addExerciseTime({required int time}) async {
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };
    final body = {
      "time": time,
    };
    try {
      final response = await ApiClient.postData(
          ApiConstant.addWorkOutTime, headers: headers, jsonEncode(body));
      if (response.body["status"] == 200) {
        isLoading.value = false;
      }
    } catch (e) {
      debugPrint('------------${e.toString()}');
    }
    isLoading.value = false;
  }

  void dailyWorkOutUpdate({required String workOutId}) async {
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };
    final body = {
      "exerciseId": workOutId,
    };
    try {
      final response = await ApiClient.postData(
          ApiConstant.dailyWorkOut, headers: headers, jsonEncode(body));
      if (response.body["status"] == 200) {
        isLoading.value = false;
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
