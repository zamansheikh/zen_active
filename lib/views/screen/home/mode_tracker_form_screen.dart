import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zen_active/services/gemini_service.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:zen_active/views/components/custom_drop_down.dart';
import 'package:zen_active/views/components/custom_text_field.dart';
import 'package:zen_active/views/screen/home/mode_tracker_screen.dart';

class ModeTrackerFormScreen extends StatefulWidget {
  const ModeTrackerFormScreen({super.key});

  @override
  State<ModeTrackerFormScreen> createState() => _ModeTrackerFormScreenState();
}

class _ModeTrackerFormScreenState extends State<ModeTrackerFormScreen> {
  bool isLoading = false;
  String selectedMode = "Happy 😊";
  String selectedPhysical = "Energetic ⚡";
  String selectedEnergyLevel = "High 🔋";
  TextEditingController whatBothering = TextEditingController();
  TextEditingController whatGrateful = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                backgroundColor: AppColors.scaffoldBackgroundColor,
                title: 'Mode Tracker',
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomDropDown(
                      title: "Select your mode",
                      options: [
                        "Happy 😊",
                        "Neutral 😐",
                        "Stressed 😓",
                        "Anxious 😟",
                        "Excited 😄"
                      ],
                      onChanged: (p0) {
                        setState(() {
                          selectedMode = p0;
                        });
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomDropDown(
                      title: "How do you feel physically?",
                      options: [
                        "Energetic ⚡",
                        "Tired 😴",
                        "Calm 🌊",
                        "Restless 🌀",
                        "Balanced ⚖️",
                      ],
                      onChanged: (p0) {
                        setState(() {
                          selectedPhysical = p0;
                        });
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomDropDown(
                      title: "What’s your overall energy level?",
                      options: [
                        "High 🔋",
                        "Medium ⚡",
                        "Low 🌙",
                      ],
                      onChanged: (p0) {
                        setState(() {
                          selectedEnergyLevel = p0;
                        });
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      title: "What’s bothering you right now?",
                      hintText: "Tell us more.....",
                      controller: whatBothering,
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      title: "What’s one thing you’re grateful for today?",
                      hintText: "Tell us more.....",
                      controller: whatGrateful,
                    ),
                    SizedBox(height: 20.h),
                    CustomButton(
                        isLoading: isLoading,
                        buttonName: "Submit",
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          processResponse();
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void processResponse() async {
    String refinedMood = determineRefinedMood();

    String storyString =
        "You are a chatbot (Fitbot) and you are feeling $refinedMood. You are bothered by '${whatBothering.text.trim()}' and you are grateful for '${whatGrateful.text.trim()}'.\n\n"
        "Reply with exactly two lines:\n"
        "1. A single word or short phrase summarizing the mood.\n"
        "2. Two or three activities from this list: HIIT, Cardio, Dance, Yoga, Meditation, Stretching, Walking, Strength Training.";

    GeminiService().chat([
      Content(
        parts: [Part.text(storyString)],
        role: "model",
      ),
    ]).then((response) {
      if (response != null) {
        print("Response: $response");
        List<String> lines = response.split("\n");

        // Extract mood (first line)
        String moodResponse = lines.isNotEmpty ? lines[0] : "Neutral";

        // Extract activities (second line)
        List<String> activitySuggestions = [];
        if (lines.length > 1) {
          activitySuggestions =
              lines[1].split(",").map((e) => e.trim()).toList();
        }

        setState(() {
          isLoading = false;
        });

        // Navigate to ModeTrackerScreen with mood and activities
        Get.to(
          () => ModeTrackerScreen(
            mode: moodResponse.toString(),
            activities: activitySuggestions,
          ),
        );
      }
    });
  }

  String determineRefinedMood() {
    if (selectedMode == "Happy 😊" &&
        selectedPhysical == "Energetic ⚡" &&
        selectedEnergyLevel == "High 🔋") {
      return "Joyful";
    } else if (selectedMode == "Stressed 😓" &&
        selectedPhysical == "Tired 😴" &&
        selectedEnergyLevel == "Low 🌙") {
      return "Exhausted";
    } else if (selectedMode == "Anxious 😟" &&
        selectedPhysical == "Restless 🌀" &&
        selectedEnergyLevel == "High 🔋") {
      return "Jittery";
    } else if (selectedMode == "Excited 😄" &&
        selectedPhysical == "Calm 🌊" &&
        selectedEnergyLevel == "Medium ⚡") {
      return "Hopeful";
    }
    return selectedMode;
  }
}
