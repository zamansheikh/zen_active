import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/community_group_controller.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_button.dart';
import 'package:zenactive/views/screen/community/Groups/community_groups_describe_your_goal.dart';

class CommunityGroupsCoverPhoto extends StatelessWidget {
  const CommunityGroupsCoverPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommunityGroupController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: GestureDetector(
                  onTap: () {
                    controller.pop();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                  ),
                ),
              ),
              const Text(
                "Add a cover photo",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff3A3A3A),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  controller.pickImage();
                },
                child: controller.file == null
                    ? Container(
                        height: 170,
                        decoration: BoxDecoration(
                          color: const Color(0xffDBE1E4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: svgViewer(asset: "assets/svg/add_image.svg"),
                        ),
                      )
                    : Container(
                        height: 170,
                        decoration: BoxDecoration(
                          color: const Color(0xffDBE1E4),
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: FileImage(File(controller.file!.path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                buttonName: "Next",
                onPressed: () {
                  controller.push(CommunityGroupsDescribeYourGoal());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
