import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/auth_controller.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_drop_down.dart';
import 'package:zen_active/views/components/custom_text_field.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  State<ProfileInformationScreen> createState() =>
      _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text:
            "${authController.user.value.name!.firstName!} ${authController.user.value.name!.lastName!}");
    emailController =
        TextEditingController(text: authController.user.value.email!);
    genderController =
        TextEditingController(text: authController.user.value.gender);
    ageController = TextEditingController(
        text: authController.user.value.dateOfBirth!.toString());
    heightController = TextEditingController(
        text: authController.user.value.height.toString());
    weightController = TextEditingController(
        text: authController.user.value.weight.toString());
    primaryGoalController = TextEditingController(
        text: authController.user.value.primaryGoal.toString());
    dietController =
        TextEditingController(text: authController.user.value.diet.toString());
    restrictionController = TextEditingController(
        text: authController.user.value.restriction.toString());
    activityLevelController = TextEditingController(
        text: authController.user.value.activityLevel.toString());
    injuryController = TextEditingController(
        text: authController.user.value.injury.toString());
    movementDifficultyController = TextEditingController(
        text: authController.user.value.movementDifficulty.toString());
  }

  final authController = Get.find<AuthController>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController genderController;
  late TextEditingController ageController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController primaryGoalController;
  late TextEditingController dietController;
  late TextEditingController restrictionController;
  late TextEditingController activityLevelController;
  late TextEditingController injuryController;
  late TextEditingController movementDifficultyController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Profile Information",
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 24,
                    children: [
                      Obx(() {
                        return Align(
                          child: InkWell(
                            onTap: () {
                              if (authController.isEditing.value) {
                                authController.pickImage();
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Stack(
                                children: [
                                  if (authController.user.value.image != null)
                                    Image.network(
                                      imageUrl(
                                          authController.user.value.image!),
                                      width: 96,
                                      height: 96,
                                      fit: BoxFit.cover,
                                    )
                                  else
                                    Image.asset(
                                      "assets/images/user.png",
                                      width: 96,
                                      height: 96,
                                      fit: BoxFit.cover,
                                    ),
                                  if (authController.isEditing.value)
                                    Container(
                                      height: 96,
                                      width: 96,
                                      color: Colors.black.withAlpha(102),
                                      child: Center(
                                        child: svgViewer(
                                          asset: "assets/svg/camera.svg",
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      CustomTextField(
                        title: "Your Name",
                        isDisabled: !authController.isEditing.value,
                        controller: nameController,
                      ),
                      CustomTextField(
                        title: "Email",
                        isDisabled: true,
                        controller: emailController,
                      ),
                      CustomTextField(
                        title: "Gender",
                        isDisabled: !authController.isEditing.value,
                        controller: genderController,
                      ),
                      CustomTextField(
                        title: "Age",
                        isDisabled: !authController.isEditing.value,
                        controller: ageController,
                      ),
                      CustomTextField(
                        title: "Height",
                        isDisabled: !authController.isEditing.value,
                        controller: heightController,
                      ),
                      CustomTextField(
                        title: "Weight",
                        isDisabled: !authController.isEditing.value,
                        controller: weightController,
                      ),
                      CustomDropDown(
                        title: "Primary Goals",
                        hintText: authController.user.value.primaryGoal,
                        isActive: authController.isEditing.value,
                        supportsMultiSelection: true,
                        options: [
                          "Build Muscle",
                          "Lose Weight",
                          "Improve Endurance",
                          "Increase Flexibility",
                          "Boost Energy",
                          "Enhance Mental Health",
                          "Gain Weight",
                        ],
                        svgPaths: [
                          "assets/svg/build_muscle.svg",
                          "assets/svg/lose_weight.svg",
                          "assets/svg/improve_endurance.svg",
                          "assets/svg/increase_flexibility.svg",
                          "assets/svg/boost_energy.svg",
                          "assets/svg/enhance_mental_health.svg",
                          "assets/svg/gain_weight.svg",
                        ],
                        onChanged: (p0) {
                          authController.user.value.primaryGoal = p0;
                        },
                      ),
                      CustomDropDown(
                        title: "Diet Preference",
                        hintText: authController.user.value.diet,
                        isActive: authController.isEditing.value,
                        options: [
                          "No Preference",
                          "Vegan",
                          "Vegetarian",
                          "Keto/Low Carb",
                          "High-Protein",
                        ],
                        svgPaths: [
                          "assets/svg/no_preference.svg",
                          "assets/svg/vegan.svg",
                          "assets/svg/vegitable.svg",
                          "assets/svg/ketogenic.svg",
                          "assets/svg/high_protein.svg",
                        ],
                        onChanged: (p0) {
                          authController.user.value.diet = p0;
                        },
                      ),
                      CustomDropDown(
                        title: "Restrictions",
                        isActive: authController.isEditing.value,
                        hintText: authController.user.value.restriction,
                        options: [
                          "Gluten-Free",
                          "Nut-Free",
                          "Dairy-Free",
                        ],
                        svgPaths: [
                          "assets/svg/gluten_free.svg",
                          "assets/svg/nut_free.svg",
                          "assets/svg/dairy_free.svg",
                        ],
                        onChanged: (p0) {
                          authController.user.value.restriction = p0;
                        },
                      ),
                      CustomDropDown(
                        title: "Activity Level",
                        isActive: authController.isEditing.value,
                        hintText: authController.user.value.activityLevel,
                        options: [
                          "Sedentary (little to no excercise)",
                          "Lightly Active (light excercise 1-3 days/week)",
                          "Moderately Active (excercise 3-5 days/week)",
                          "Very Active (hard excercise 6-7 days/week)",
                          "Super Active (intense excercise every day)",
                        ],
                        onChanged: (p0) {
                          authController.user.value.activityLevel = p0;
                        },
                      ),
                      Obx(() {
                        return CustomButton(
                          buttonName: authController.isEditing.value
                              ? "Update Profile"
                              : "Edit Profile",
                          isSecondary: !authController.isEditing.value,
                          isLoading: authController.isLoading.value,
                          onPressed: () {
                            if (authController.isEditing.value) {
                              updateProfile();
                            } else {
                              authController.isEditing.value = true;
                            }
                          },
                        );
                      }),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateProfile() {
    authController.updateUserProfile(
      firstName: nameController.text.split(" ")[0],
      lastName: nameController.text.split(" ")[1],
      restriction: restrictionController.text.trim(),
      diet: dietController.text.trim(),
      primaryGoal: primaryGoalController.text.trim(),
      activityLevel: activityLevelController.text.trim(),
      dateOfBirth: ageController.text.trim(),
      gender: genderController.text.trim(),
      height: heightController.text.trim(),
      weight: weightController.text.trim(),
    );
  }
}
