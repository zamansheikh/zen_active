import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zen_active/models/commnet_model.dart';
import 'package:zen_active/models/discover_group_model.dart';
import 'package:zen_active/models/group_model.dart';
import 'package:zen_active/models/group_post_model.dart';
import 'package:zen_active/models/my_group_model.dart';
import 'package:zen_active/models/notification_model.dart';

import 'package:zen_active/services/api_client.dart';
import 'package:zen_active/services/api_constant.dart';
import 'package:zen_active/utils/app_constants.dart';
import 'package:zen_active/utils/prefs_helper.dart';
import 'package:zen_active/views/screen/community/groups/community_group_details.dart';

class CommunityGroupController extends GetxController {
  String title = "Community Screen";
  RxBool isLoading = false.obs;
  RxList<Widget> customPages = <Widget>[].obs;
  XFile? file;

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = image;
      update();
    }
  }

  TextEditingController groupNameController = TextEditingController();
  TextEditingController groupDescriptionController = TextEditingController();

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
  RxList<CommentModel> commnetList = <CommentModel>[].obs;
  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;
  Rx<GroupModel> groupInfo = GroupModel().obs;
  void getAllMyGroups() async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
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

  void getAllPost() async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
      final response = await ApiClient.getData(
        ApiConstant.allGroupPost,
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

  void getAllCommmets(String id) async {
    isLoading.value = true;
    final bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $bearerToken',
    };
    try {
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
      'Content-Type': 'application/x-www-form-urlencoded',
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
        {
          "name": groupNameController.text.trim(),
          "goal": groupDescriptionController.text.trim(),
          "type": "Public",
        },
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

  void fetchSingleGroupData(String id) async {
    isLoading.value = true;
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
        try {
          groupInfo.value = GroupModel.fromJson(response.body["data"]);
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
}
