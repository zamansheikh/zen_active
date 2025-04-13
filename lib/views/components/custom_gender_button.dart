import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenactive/utils/app_constants.dart';
import 'package:zenactive/utils/uitls.dart';
import '../../utils/app_colors.dart';

class CustomGenderButton extends StatefulWidget {
  final bool isMale;
  final Color? buttonColor;
  final Color? textColor;
  final double height;
  final double width;
  final double? textSize;
  final bool isSecondary;
  final VoidCallback? onPressed;

  const CustomGenderButton({
    super.key,
    required this.isMale,
    this.height = 50.0,
    this.width = double.infinity,
    this.textSize,
    this.isSecondary = false,
    this.onPressed,
    this.buttonColor,
    this.textColor,
  });

  @override
  FCustomButtonState createState() => FCustomButtonState();
}

class FCustomButtonState extends State<CustomGenderButton> {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                svgViewer(
                  asset: widget.isMale
                      ? AppConstants.maleIcon
                      : AppConstants.femaleIcon,
                  color: widget.isSecondary
                      ? widget.textColor ?? Color(0xff2d2d2d)
                      : widget.textColor ?? AppColors.splashBackgrond,
                  height: 20.h,
                  width: 20.w,
                ),
                SizedBox(width: 4.w),
                Text(
                  widget.isMale ? "Male" : "Female",
                  style: TextStyle(
                    color: widget.isSecondary
                        ? widget.textColor ?? Color(0xff2d2d2d)
                        : widget.textColor ?? AppColors.splashBackgrond,
                    fontSize: widget.textSize ?? 20,
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
