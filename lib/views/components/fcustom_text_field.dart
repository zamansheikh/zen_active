import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/app_constants.dart';
import 'package:zen_active/utils/uitls.dart';

class FCustomTextField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;

  const FCustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
  });

  @override
  FCustomTextFieldState createState() => FCustomTextFieldState();
}

class FCustomTextFieldState extends State<FCustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: TextField(
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
          prefixIcon: svgViewer(asset: AppConstants.lockIcon),
          prefixIconConstraints: BoxConstraints(
            minWidth: 40.w,
            minHeight: 40.h,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: AppColors.hintColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 1.w, color: AppColors.textInputBorderColor),
            borderRadius: BorderRadius.circular(8.h),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.w,
              color: AppColors.textInputBorderColor,
            ),
            borderRadius: BorderRadius.circular(8.h),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.w,
              color: AppColors.textInputBorderColor,
            ),
            borderRadius: BorderRadius.circular(8.h),
          ),
        ),
      ),
    );
  }
}
