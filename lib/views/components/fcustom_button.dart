import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_colors.dart';

class FCustomButton extends StatefulWidget {
  final String buttonName;
  final double height;
  final double width;
  final double? textSize;
  final VoidCallback? onPressed;

  const FCustomButton({
    super.key,
    required this.buttonName,
    this.height = 50.0,
    this.width = double.infinity,
    this.textSize,
    this.onPressed,
  });

  @override
  FCustomButtonState createState() => FCustomButtonState();
}

class FCustomButtonState extends State<FCustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: widget.height.h,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.h),
          color: AppColors.splashButtonColor,
        ),
        child: Center(
          child: Text(
            widget.buttonName,
            style: TextStyle(
              color: AppColors.splashBackgrond,
              fontSize: widget.textSize ?? 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
