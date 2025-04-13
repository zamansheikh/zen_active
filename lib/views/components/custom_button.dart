import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_loading.dart';
import '../../utils/app_colors.dart';

class CustomButton extends StatefulWidget {
  final String buttonName;
  final Color? buttonColor;
  final Color? textColor;
  final double height;
  final double width;
  final double? textSize;
  final double borderRadius;
  final bool isSecondary;
  final String? leadingIcon;
  final bool isLoading;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.buttonName,
    this.height = 50.0,
    this.width = double.infinity,
    this.textSize,
    this.isSecondary = false,
    this.onPressed,
    this.buttonColor,
    this.textColor,
    this.leadingIcon,
    this.borderRadius = 8,
    this.isLoading = false,
  });

  @override
  FCustomButtonState createState() => FCustomButtonState();
}

class FCustomButtonState extends State<CustomButton> {
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
          borderRadius: BorderRadius.circular(widget.borderRadius),
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
            child: widget.isLoading
                ? CustomLoading()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.leadingIcon != null)
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 5.0,
                            right: 4,
                          ),
                          child: svgViewer(
                            asset: widget.leadingIcon!,
                            height: widget.textSize ?? 24,
                          ),
                        ),
                      Text(
                        widget.buttonName,
                        style: TextStyle(
                          color: widget.isSecondary
                              ? widget.textColor ?? Color(0xff174C6B)
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
