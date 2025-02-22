import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/models/user_chats_model.dart';
import 'package:zen_active/services/api_client.dart';
import 'package:zen_active/services/api_constant.dart';
import 'package:zen_active/utils/app_constants.dart';
import 'package:zen_active/utils/prefs_helper.dart';
import 'package:zen_active/utils/uitls.dart';

class MessageController extends GetxController implements GetxService {
  String title = "Message Screen";
  RxBool isLoading = false.obs;
  Rx<UserChatsModel> messages = UserChatsModel().obs;

  final TextEditingController postController = TextEditingController();
  void getAllMessage({required String id}) async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.getData(
        ApiConstant.getUserMessages(id),
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          messages.value = UserChatsModel.fromJson(response.body["data"]);

          llg(messages.value.userChat?.length);
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

    super.onInit();
  }

  @override
  void onReady() {
    debugPrint("On onReady  $title");
    super.onReady();
  }
}
