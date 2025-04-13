import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/auth_controller.dart';
import 'package:zenactive/helpers/socket_service.dart';
import 'package:zenactive/models/user_chats_model.dart';
import 'package:zenactive/services/api_client.dart';
import 'package:zenactive/services/api_constant.dart';
import 'package:zenactive/utils/app_constants.dart';
import 'package:zenactive/utils/prefs_helper.dart';
import 'package:zenactive/utils/uitls.dart';

class MessageController extends GetxController implements GetxService {
  String title = "Message Screen";
  RxBool isLoading = false.obs;
  Rx<UserChatsModel> messages = UserChatsModel().obs;

  final TextEditingController textController = TextEditingController();
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
          isLoading.value = false;
        } catch (e) {
          debugPrint('Model Conversion Error: ${e.toString()}');
          isLoading.value = false;
        }
      }
    } catch (e) {
      debugPrint('Error fetching messages: ${e.toString()}');
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  void sendMessage(
      {required String rcvId,
      required String senderId,
      required String message, required String connectionId}) async {
    try {
      SocketServices.socket.emit("sendMessage", {
        "message": message,
        "receiverId": rcvId,
        "senderId": senderId,
        "connectionId": connectionId
      });
      textController.clear();
    } catch (e) {
      debugPrint('Error sending message: ${e.toString()}');
    }
  }

  void listenMessage({required String connectionId}) {
    final myId = Get.find<AuthController>().user.value.id;
    try {
      SocketServices.socket.on("receiver-$connectionId", (data) {
        llg("Received message: $data");
        if (data != null &&
            data["senderId"] != null &&
            data["content"] != null) {
          if (data["senderId"] == myId) {
            debugPrint("This is my message : $data");
            try {
              messages.value = messages.value.addMessage(
                  message: data["content"],
                  senderId: data["senderId"],
                  receiverId: data["receiverId"]);
            } catch (e) {
              debugPrint('Error adding message: ${e.toString()}');
            }
          } else if (data["receiverId"] == myId) {
            debugPrint("This is my friend's message");
            try {
              messages.value = messages.value.addMessage(
                  message: data["content"],
                  senderId: data["senderId"],
                  receiverId: data["receiverId"]);
            } catch (e) {
              debugPrint('Error adding message: ${e.toString()}');
            }
          }
        } else {
          debugPrint("Received invalid data: $data");
        }
      });
    } catch (e) {
      debugPrint('Error listening message: ${e.toString()}');
    } finally {
      debugPrint("Socket on : receiver-$connectionId");
    }
  }

  void closeListenMessage({required String connectionId}) {
    SocketServices.socket.off("receiver-$connectionId");
    debugPrint("Socket off : receiver-$connectionId");
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint("On Init  $title");
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint("Socket closed");
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint("On onReady  $title");
  }
}
