import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zen_active/models/exercise_model.dart';
import 'package:zen_active/models/signle_exercise_model.dart';
import 'package:zen_active/services/api_client.dart';
import 'package:zen_active/services/api_constant.dart';
import 'package:zen_active/utils/app_constants.dart';
import 'package:zen_active/utils/prefs_helper.dart';

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

  void getSingleChallege(String id) async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
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
