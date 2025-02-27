import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/community_group_controller.dart';
import 'package:zen_active/views/components/comment_section.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Expanded(child: CommentSection()),
            ],
          ),
        ),
      ),
    );
  }
}
