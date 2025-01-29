import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_active/utils/uitls.dart';
import '../../utils/app_colors.dart';

class CustomSelectionButton extends StatefulWidget {
  final bool hasIcon;
  final Color? buttonColor;
  final String buttonName;
  final Color? textColor;
  final double height;
  final double width;
  final String? svgPath;
  final double? textSize;
  final bool isSecondary;
  final VoidCallback? onPressed;

  const CustomSelectionButton({
    super.key,
    required this.hasIcon,
    this.height = 50.0,
    required this.buttonName,
    this.width = double.infinity,
    this.svgPath,
    this.textSize,
    this.isSecondary = false,
    this.onPressed,
    this.buttonColor,
    this.textColor,
  });

  @override
  FCustomButtonState createState() => FCustomButtonState();
}

class FCustomButtonState extends State<CustomSelectionButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: widget.height.h,
        width: widget.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xff1E648C),
          ),
          borderRadius: BorderRadius.circular(8.h),
          color: widget.buttonColor ??
              (widget.isSecondary
                  ? Color(0xffebf8ff)
                  : AppColors.splashButtonColor),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 3,
            ),
            child: Row(
              children: [
                SizedBox(width: 24.w),
                if (widget.svgPath != null)
                  svgViewer(
                    asset: widget.svgPath!,
                    color: widget.isSecondary
                        ? widget.textColor ?? Color(0xff2d2d2d)
                        : widget.textColor ?? AppColors.splashBackgrond,
                    height: 32.h,
                    width: 24.w,
                  ),
                SizedBox(width: 8.w),
                Text(
                  widget.buttonName,
                  style: TextStyle(
                    color: widget.isSecondary
                        ? widget.textColor ?? Color(0xff2d2d2d)
                        : widget.textColor ?? AppColors.splashBackgrond,
                    fontSize: widget.textSize ?? 16.sp,
                    fontFamily: "khula",
                    height: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
