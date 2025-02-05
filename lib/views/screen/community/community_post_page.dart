import 'package:flutter/material.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';

class CommunityPostPage extends StatelessWidget {
  const CommunityPostPage({super.key});

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
                      height: 140,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: Image.asset(
                              "assets/images/faces/4.png",
                              height: 40,
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
                                      
                                    },
                                    child: svgViewer(
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
