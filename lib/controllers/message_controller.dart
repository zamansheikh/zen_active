import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:zen_active/controllers/auth_controller.dart';
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

  final TextEditingController textController = TextEditingController();

  late IO.Socket socket;

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
      required String message}) async {
    try {
      socket.emit("sendMessage", {
        "message": message,
        "receiverId": rcvId,
        "senderId": senderId,
      });
      textController.clear();
    } catch (e) {
      debugPrint('Error sending message: ${e.toString()}');
    }
  }

  void listenMessage() {
    final myId = Get.find<AuthController>().user.value.id;
    socket.on("receiver-$myId", (data) {
      llg("Received message: $data");
      if (data != null && data["senderId"] != null && data["content"] != null) {
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
  }

  void initializeSocket() {
    socket = IO.io(ApiConstant.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('connect', (_) {
      debugPrint('✅ Connected to socket server');
    });

    socket.on('disconnect', (_) {
      debugPrint('❌ Disconnected from socket server');
    });

    socket.on('connect_error', (error) {
      debugPrint('❌ Socket connection error: $error');
    });

    socket.on('reconnect', (attempt) {
      debugPrint('✅ Reconnected to socket server on attempt $attempt');
    });

    socket.on('reconnect_attempt', (attempt) {
      debugPrint('🔄 Reconnecting to socket server, attempt $attempt');
    });
  }

  @override
  void onInit() {
    super.onInit();
    initializeSocket();
    listenMessage();
    debugPrint("On Init  $title");
  }

  @override
  void onClose() {
    super.onClose();
    socket.dispose();
    debugPrint("Socket closed");
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint("On onReady  $title");
  }
}
