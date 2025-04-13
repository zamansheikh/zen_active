import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zenactive/models/commnet_model.dart';
import 'package:zenactive/models/discover_group_model.dart';
import 'package:zenactive/models/group_model.dart';
import 'package:zenactive/models/group_post_model.dart';
import 'package:zenactive/models/invite_model.dart';
import 'package:zenactive/models/last_message_model.dart';
import 'package:zenactive/models/my_group_model.dart';
import 'package:zenactive/models/notification_model.dart';
import 'package:zenactive/services/api_checker.dart';

import 'package:zenactive/services/api_client.dart';
import 'package:zenactive/services/api_constant.dart';
import 'package:zenactive/utils/app_constants.dart';
import 'package:zenactive/utils/prefs_helper.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/screen/community/groups/community_group_details.dart';

class CommunityGroupController extends GetxController {
  String title = "Community Screen";
  RxBool isLoading = false.obs;
  RxList<Widget> customPages = <Widget>[].obs;

  XFile? file;
  XFile? coverfile;

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = image;
      update();
    }
  }

  void pickImageAndSave(String id) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      coverfile = image;
      update();
      updateGroup(id, File(coverfile!.path));
    }
  }

  TextEditingController postController = TextEditingController();

  TextEditingController groupNameController = TextEditingController();
  TextEditingController groupDescriptionController = TextEditingController();
  TextEditingController commnentTextController = TextEditingController();
  TextEditingController groupTypeController = TextEditingController();

  void push(Widget page) {
    customPages.add(page);
  }

  void pop() {
    if (customPages.isNotEmpty) {
      customPages.removeAt(customPages.length - 1);
    }
  }

  //List of MyGroup
  RxList<MyGroupModel> myGroups = <MyGroupModel>[].obs;
  RxList<DiscoverGroupModel> discoverGroups = <DiscoverGroupModel>[].obs;
  RxList<GroupPostModel> postList = <GroupPostModel>[].obs;
  RxList<GroupPostModel> allGroupPosts = <GroupPostModel>[].obs;
  RxList<CommentModel> commnetList = <CommentModel>[].obs;
  RxList<InviteModel> inviteList = <InviteModel>[].obs;
  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;
  RxList<LastMessageModel> lastMessages = <LastMessageModel>[].obs;
  Rx<GroupModel> groupInfo = GroupModel().obs;

  void getAllMyGroups() async {
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      isLoading.value = true;
      final response = await ApiClient.getData(
        ApiConstant.allMyGroup,
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          myGroups.value = response.body["data"]
              .map<MyGroupModel>((e) => MyGroupModel.fromJson(e))
              .toList();
          isLoading.value = false;
          myGroups.length.printError();
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

  void getAllInvity(String id) async {
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      isLoading.value = true;
      final response = await ApiClient.getData(
        ApiConstant.inviteToAGroup(id),
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          inviteList.value = response.body["data"]
              .map<InviteModel>((e) => InviteModel.fromJson(e))
              .toList();
          isLoading.value = false;
          inviteList.length.printError();
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

  void inviteToGroup(String friendId, String groupId) async {
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      isLoading.value = true;
      final response = await ApiClient.postData(
        ApiConstant.inviteFriendToAGroup,
        jsonEncode({
          "groupId": groupId,
          "receiverId": friendId,
        }),
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        int index = inviteList.indexWhere((element) => element.id == friendId);
        InviteModel model = inviteList[index].copyWith(isInvited: true);
        inviteList[index] = model;
        inviteList.refresh();
        isLoading.value = false;
      }
    } catch (e) {
      debugPrint('------------${e.toString()}');
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  void getLastMesssage() async {
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      isLoading.value = true;

      final response = await ApiClient.getData(
        ApiConstant.getLastMessages,
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          lastMessages.value = response.body["data"]
              .map<LastMessageModel>((e) => LastMessageModel.fromJson(e))
              .toList();
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

  // /user-group/all-user-group?searchTerm=111
  void searchGroups(String searchTerms) async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.getData(
        ApiConstant.allMyGroupWithSearch(searchTerms),
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          myGroups.value = response.body["data"]
              .map<MyGroupModel>((e) => MyGroupModel.fromJson(e))
              .toList();
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

  void joinAgroup(String groupId) async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.patchData(
        ApiConstant.joinGroup(groupId),
        {},
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          getAllMyGroups();
          getAllDiscoverGroups();
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

  void getAllDiscoverGroups() async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.getData(
        ApiConstant.getAllGroup,
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          discoverGroups.value = response.body["data"]
              .map<DiscoverGroupModel>((e) => DiscoverGroupModel.fromJson(e))
              .toList();
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

  Future<void> getAllPost(String groupId) async {
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      isLoading.value = true;
      final response = await ApiClient.getData(
        ApiConstant.allGroupPostbyId(groupId),
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          postList.value = response.body["data"]
              .map<GroupPostModel>((e) => GroupPostModel.fromJson(e))
              .toList();
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

  Future<void> getAllPostAllGroup() async {
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      isLoading.value = true;
      final response = await ApiClient.getData(
        ApiConstant.allGroupPost,
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          allGroupPosts.value = response.body["data"]
              .map<GroupPostModel>((e) => GroupPostModel.fromJson(e))
              .toList();
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

  void getAllCommmets(String id) async {
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      isLoading.value = true;
      final response = await ApiClient.getData(
        ApiConstant.getSinglePostCommnent(id),
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          commnetList.value = response.body["data"]
              .map<CommentModel>((e) => CommentModel.fromJson(e))
              .toList();
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

  void addComment({required String commnet, required String postId}) async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.postData(
        ApiConstant.addComment,
        {"postId": postId, "comment": commnet},
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          commnentTextController.clear();
          getAllCommmets(postId);
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

  void toggleLike(
      {required String postId, required Function(bool) onToggle}) async {
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };

    try {
      // isLoading.value = true;
      final response = await ApiClient.postData(
        ApiConstant.togglelike,
        jsonEncode(
          {"postId": postId},
        ),
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        onToggle(response.body["data"]["isLiked"]);
      } else {
        onToggle(false);
      }
    } catch (e) {
      debugPrint('------------${e.toString()}');
      onToggle(false);
    } finally {
      // isLoading.value = false;
    }
  }

  void fetchNotifications() async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.getData(
        ApiConstant.getNotifications,
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          notificationList.value = response.body["data"]
              .map<NotificationModel>((e) => NotificationModel.fromJson(e))
              .toList();
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

  void readNofication(String id) async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.patchData(
        ApiConstant.readNotification(id),
        jsonEncode({}),
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          fetchNotifications();
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

  void createGroup() async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };
    if (groupNameController.text.trim().isEmpty ||
        groupDescriptionController.text.trim().isEmpty ||
        file == null) {
      isLoading.value = false;
      return;
    }
    try {
      final response = await ApiClient.postData(
        ApiConstant.createGroup,
        jsonEncode(
          {
            "name": groupNameController.text.trim(),
            "goal": groupDescriptionController.text.trim(),
            "type": groupTypeController.text.trim(),
          },
        ),
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          updateGroup(
            response.body["data"]["_id"],
            File(file!.path),
          );
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

  Future<bool> pathGroupData({
    required String groupName,
    required String type,
    required String goal,
    required String id,
  }) async {
    print(id);
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    };

    var data = {
      "name": groupName,
    };
    var body = {
      "data": jsonEncode(data),
    };

    try {
      final response = await ApiClient.patchData(
        ApiConstant.updateGroup(id),
        jsonEncode(body),
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          Get.snackbar("Success", "Group Updated Successfully");
          isLoading.value = false;
          return true;
        } catch (e) {
          debugPrint('Model Convertion Error: ${e.toString()}');
          isLoading.value = false;
          return false;
        }
      }
    } catch (e) {
      debugPrint('------------${e.toString()}');
      isLoading.value = false;
      return false;
    }
    isLoading.value = false;
    return false;
  }

  void updateGroup(String id, File photo) async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    List<MultipartBody> multipartBody = [MultipartBody("image", photo)];
    try {
      final response = await ApiClient.patchMultipartData(
        ApiConstant.updateGroup(id),
        multipartBody: multipartBody,
        {
          "data": jsonEncode({}),
        },
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          push(CommunityGroupDetails(groupId: id));
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

  String? _lastFetchedGroupId; // Keep track of the last fetched group ID.

  Future<void> fetchSingleGroupData(String id) async {
    // Only fetch if the ID has changed or groupInfo is empty.
    if (_lastFetchedGroupId != id) {
      //isLoading.value = true;  // REMOVE THIS
      _lastFetchedGroupId = id; // Update the last fetched ID.
      final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $bearerToken',
      };
      try {
        final response = await ApiClient.getData(
          ApiConstant.getSingleGroupDetails(id),
          headers: headers,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          groupInfo.value = GroupModel.fromJson(response.body["data"]);
        } else {
          // Handle non-200 responses (e.g., 404 Not Found)
          groupInfo.value = GroupModel(); // Set to a default/empty state
          // Optionally show a snackbar/dialog indicating the error
          Get.snackbar(
              "Error", "Failed to load group details: ${response.statusCode}");
        }
      } catch (e) {
        debugPrint('------------${e.toString()}');
        groupInfo.value = GroupModel(); // Set to empty state on error
        Get.snackbar("Error", "An error occurred: $e");
      }
    }
  }

  postwithImage(
      {required XFile? pickedFile,
      required String groupId,
      String? text}) async {
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
      List<MultipartBody> multipartBody = [MultipartBody("image", file)];
      Map<String, String> body = {
        "data": jsonEncode({
          "text": text ?? "",
          "groupId": groupId,
        })
      };
      final headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $bearerToken',
      };
      try {
        final response = await ApiClient.postMultipartData(
          ApiConstant.addPost,
          body,
          multipartBody: multipartBody,
          headers: headers,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.back();
          showSnackBar(
              message: response.body["message"],
              isSucess: response.statusCode == 200);
        } else {
          ApiChecker.checkApi(response);
        }
      } catch (e) {
        debugPrint('Model Convertion Error: ${e.toString()}');
        isLoading.value = false;
      }
    }
  }

  post(String groupId, String text) async {
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    List<MultipartBody> multipartBody = [];
    Map<String, String> body = {
      "data": jsonEncode({
        "text": text.trim(),
        "groupId": groupId,
      })
    };
    final headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.postMultipartData(
        ApiConstant.addPost,
        body,
        multipartBody: multipartBody,
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        showSnackBar(
            message: response.body["message"],
            isSucess: response.statusCode == 200 || response.statusCode == 201);
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      debugPrint('Model Convertion Error: ${e.toString()}');
      isLoading.value = false;
    }
  }

  void clearGroupInfo() {
    groupInfo.value = GroupModel(); // Resets to initial, empty state.
    _lastFetchedGroupId = null; // Reset the last fetched ID.
  }
}
