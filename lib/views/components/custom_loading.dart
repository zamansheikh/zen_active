import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zen_active/utils/uitls.dart';

class CustomLoading extends StatefulWidget {
  final double? size;
  final Color? color;
  const CustomLoading({super.key, this.size, this.color});

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * pi,
            child: child,
          );
        },
        child: svgViewer(
          asset: "assets/svg/loading.svg",
          color: widget.color,
        ),
      ),
    );
  }
}
