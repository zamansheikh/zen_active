import 'package:flutter/material.dart';
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
  bool isEditing = false;
  TextEditingController nameController =
      TextEditingController(text: "Arlene Flores");
  TextEditingController emailController =
      TextEditingController(text: "ArleneFlores@mail.com");
  TextEditingController genderController =
      TextEditingController(text: "Female");
  TextEditingController ageController = TextEditingController(text: "24 yrs");
  TextEditingController heightController =
      TextEditingController(text: "178 cm");
  TextEditingController weightController = TextEditingController(text: "55 kg");

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
                      Align(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Stack(
                            children: [
                              Image.asset(
                                "assets/images/user.png",
                                width: 96,
                                height: 96,
                                fit: BoxFit.cover,
                              ),
                              if (isEditing)
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
                      CustomTextField(
                        title: "Your Name",
                        isDisabled: !isEditing,
                        controller: nameController,
                      ),
                      CustomTextField(
                        title: "Email",
                        isDisabled: !isEditing,
                        controller: emailController,
                      ),
                      CustomTextField(
                        title: "Gender",
                        isDisabled: !isEditing,
                        controller: genderController,
                      ),
                      CustomTextField(
                        title: "Age",
                        isDisabled: !isEditing,
                        controller: ageController,
                      ),
                      CustomTextField(
                        title: "Height",
                        isDisabled: !isEditing,
                        controller: heightController,
                      ),
                      CustomTextField(
                        title: "Weight",
                        isDisabled: !isEditing,
                        controller: weightController,
                      ),
                      CustomDropDown(
                        title: "Primary Goals",
                        isActive: isEditing,
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
                      ),
                      CustomDropDown(
                        title: "Diet Preference",
                        isActive: isEditing,
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
                      ),
                      CustomDropDown(
                        title: "Restrictions",
                        isActive: isEditing,
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
                      ),
                      CustomDropDown(
                        title: "Activity Level",
                        isActive: isEditing,
                        options: [
                          "Sedentary (little to no excercise)",
                          "Lightly Active (light excercise 1-3 days/week)",
                          "Moderately Active (excercise 3-5 days/week)",
                          "Very Active (hard excercise 6-7 days/week)",
                          "Super Active (intense excercise every day)",
                        ],
                      ),
                      CustomButton(
                        buttonName:
                            isEditing ? "Update Profile" : "Edit Profile",
                        isSecondary: !isEditing,
                        onPressed: () {
                          setState(() {
                            isEditing = !isEditing;
                          });
                        },
                      ),
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
}
