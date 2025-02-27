import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/auth_controller.dart';
import 'package:zen_active/models/leader_board_model.dart';
import 'package:zen_active/services/api_client.dart';
import 'package:zen_active/services/api_constant.dart';
import 'package:zen_active/utils/app_constants.dart';
import 'package:zen_active/utils/prefs_helper.dart';

class LeaderBoardController extends GetxController implements GetxService {
  String title = "Leader Board Screen";
  RxBool isLoading = false.obs;
  RxList<LeaderboardModel> leaderBoardList = <LeaderboardModel>[].obs;
  Rx<LeaderboardModel> myself = LeaderboardModel().obs;
  void getLeaderBoard() async {
    "Get Leader Board".printInfo;
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.getData(
        ApiConstant.getLeaderBoard,
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          leaderBoardList.value =
              response.body["data"].map<LeaderboardModel>((e) {
            if (e["userId"]["_id"] ==
                Get.find<AuthController>().user.value.id) {
              myself.value = LeaderboardModel.fromJson(e);
            }
            return LeaderboardModel.fromJson(e);
          }).toList();
          isLoading.value = false;
        } catch (e) {
          debugPrint('Model Convertion Error: ${e.toString()}');
          isLoading.value = false;
        }
      }
    } catch (e) {
      debugPrint('------------${e.toString()}');
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    debugPrint("On Init  $title");
    getLeaderBoard();
    super.onInit();
  }

  @override
  void onReady() {
    debugPrint("On onReady  $title");
    super.onReady();
  }
}
