import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zenactive/controllers/auth_controller.dart';
import 'package:zenactive/controllers/community_feed_controller.dart';
import 'package:zenactive/controllers/community_group_controller.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/custom_button.dart';

class CommunityPostPage extends StatefulWidget {
  final String? groupId;
  const CommunityPostPage({super.key, this.groupId});

  @override
  State<CommunityPostPage> createState() => _CommunityPostPageState();
}

class _CommunityPostPageState extends State<CommunityPostPage> {
  XFile? pickedFile;
  void pickImage() async {
    pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {});
  }

  TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Create Post",
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 160,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: Image.network(
                              imageUrl(
                                Get.find<AuthController>().user.value.image!,
                              ),
                              height: 40,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 16,
                                right: 16,
                                bottom: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffFEFEFF),
                                border: Border.all(
                                  color: Color(0xff79CDFF),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    controller: postController,
                                    decoration: InputDecoration(
                                      hintText: "Share your fitness journey...",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xffAFAFAF),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    maxLines: 3,
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      pickImage();
                                    },
                                    child: (pickedFile != null)
                                        ? Image.file(
                                            File(pickedFile!.path),
                                            height: 50,
                                          )
                                        : svgViewer(
                                            asset: "assets/svg/add_image.svg"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomButton(
                        buttonName: "Post",
                        width: 80,
                        height: 35,
                        textSize: 16,
                        borderRadius: 4,
                        onPressed: () {
                          if (widget.groupId != null) {
                            debugPrint(
                                "Posting to a Single Group : ${widget.groupId}");
                            if (pickedFile != null) {
                              Get.find<CommunityGroupController>()
                                  .postwithImage(
                                pickedFile: pickedFile!,
                                groupId: widget.groupId!,
                                text: postController.text,
                              );
                            } else {
                              Get.find<CommunityGroupController>().post(
                                widget.groupId!,
                                postController.text,
                              );
                            }
                          } else {
                            debugPrint("Posting to my timeline");
                            if (pickedFile != null) {
                              Get.find<CommunityFeedController>().postwithImage(
                                pickedFile: pickedFile!,
                                text: postController.text,
                              );
                            } else {
                              Get.find<CommunityFeedController>().post(
                                postController.text,
                              );
                            }
                          }
                          postController.clear();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
