import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/models/commnet_model.dart';
import 'package:zen_active/models/discover_group_model.dart';
import 'package:zen_active/models/group_post_model.dart';
import 'package:zen_active/models/my_group_model.dart';
import 'package:zen_active/models/post_model.dart';
import 'package:zen_active/services/api_client.dart';
import 'package:zen_active/services/api_constant.dart';
import 'package:zen_active/utils/app_constants.dart';
import 'package:zen_active/utils/prefs_helper.dart';

class CommunityGroupController extends GetxController {
  String title = "Community Screen";
  RxBool isLoading = false.obs;
  RxList<Widget> customPages = <Widget>[].obs;

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
}
