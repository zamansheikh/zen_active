import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/community_group_controller.dart';
import 'package:zenactive/views/components/comment_section.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';

class CommunityCommentPage extends StatefulWidget {
  const CommunityCommentPage({super.key, required this.postId});
  final String postId;

  @override
  State<CommunityCommentPage> createState() => _CommunityCommentPageState();
}

class _CommunityCommentPageState extends State<CommunityCommentPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CommunityGroupController>().getAllCommmets(widget.postId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 32,
              child: CustomAppBar(
                title: "Commnets",
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: CommentSection(postId: widget.postId),
            )),
          ],
        ),
      ),
    );
  }
}
