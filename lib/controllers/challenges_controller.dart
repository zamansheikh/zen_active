import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zenactive/models/exercise_model.dart';
import 'package:zenactive/models/signle_exercise_model.dart';
import 'package:zenactive/services/api_client.dart';
import 'package:zenactive/services/api_constant.dart';
import 'package:zenactive/utils/app_constants.dart';
import 'package:zenactive/utils/prefs_helper.dart';

class ChallengesController extends GetxController implements GetxService {
  String title = "Challenges Screen";
  RxBool isLoading = false.obs;
  RxList<ExerciseModel> exercises = <ExerciseModel>[].obs;
  Rx<SingleExerciseModel> singleExercise = SingleExerciseModel().obs;

  void getChallenges() async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.getData(
        ApiConstant.getExercise,
        headers: headers,
      );
      if (response.body["status"] == 200) {
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

  void getSingleChallege(String id) async {
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      isLoading.value = true;
      final response = await ApiClient.getData(
        ApiConstant.getExercise + id,
        headers: headers,
      );
      if (response.body["status"] == 200) {
        try {
          singleExercise.value =
              SingleExerciseModel.fromJson(response.body["data"]);
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
