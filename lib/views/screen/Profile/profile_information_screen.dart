import 'package:flutter/material.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_text_field.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  State<ProfileInformationScreen> createState() =>
      _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  bool isEditing = false;
  TextEditingController nameController = TextEditingController(text: "Arlene Flores");
  TextEditingController emailController = TextEditingController(text: "ArleneFlores@mail.com");
  TextEditingController genderController = TextEditingController(text: "Female");
  TextEditingController ageController = TextEditingController(text: "24 yrs");
  TextEditingController heightController = TextEditingController(text: "178 cm");
  TextEditingController weightController = TextEditingController(text: "55 kg");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomAppBar(
          title: "Profile Information",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            spacing: 24,
            children: [
              Align(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "assets/images/user.png",
                    width: 96,
                    height: 96,
                    fit: BoxFit.cover,
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
              CustomButton(
                buttonName: isEditing ? "Update Profile" : "Edit Profile",
                isSecondary: !isEditing,
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
