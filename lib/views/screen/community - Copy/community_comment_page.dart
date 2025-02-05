import 'package:flutter/material.dart';
import 'package:zen_active/views/components/comment_section.dart';

class CommunityCommentPage extends StatelessWidget {
  const CommunityCommentPage({super.key});

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
