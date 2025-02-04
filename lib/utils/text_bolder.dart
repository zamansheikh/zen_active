import 'package:flutter/material.dart';

RichText textBolder(String text, TextStyle style) {
  text = text.replaceAll("#", "##");
  RegExp regex = RegExp(r'`([^`]+)`|#(\S+)');
  List<TextSpan> spans = [];
  int currentIndex = 0;

  TextStyle defaultStyle = style;
  TextStyle boldStyle = style.copyWith(fontWeight: FontWeight.bold);

  for (final match in regex.allMatches(text)) {
    if (match.start > currentIndex) {
      spans.add(TextSpan(text: text.substring(currentIndex, match.start)));
    }

    String? boldSegment;
    if (match.group(1) != null) {
      boldSegment = match.group(1);
    } else if (match.group(2) != null) {
      boldSegment = match.group(2);
    }

    if (boldSegment != null) {
      spans.add(
        TextSpan(
          text: boldSegment,
          style: boldStyle,
        ),
      );
    }

    currentIndex = match.end;
  }

  if (currentIndex < text.length) {
    spans.add(TextSpan(text: text.substring(currentIndex)));
  }

  return RichText(
    text: TextSpan(
      style: defaultStyle,
      children: spans,
    ),
  );
}
