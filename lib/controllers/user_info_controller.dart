//UserInfoController

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Gender {
  male,
  female,
}

class UserInfoController extends GetxController {
  RxInt currentIndex = 0.obs;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameControler = TextEditingController();
  RxString dateOfBirth = 'DD/MM/YEAR'.obs;
  RxString dateTimeStr = ''.obs;

  final RxString gender =
      Gender.male.toString().split('.').last.capitalize!.obs;
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController primaryGoalController = TextEditingController();
  final TextEditingController dietController = TextEditingController();
  final TextEditingController restrictinController = TextEditingController();
  final TextEditingController injuryController = TextEditingController();
  final TextEditingController activityLevelController = TextEditingController();
  final TextEditingController movementDifficultyController =
      TextEditingController();
  final TextEditingController medicalConditionController =
      TextEditingController();
  final TextEditingController occupationController = TextEditingController();
}
