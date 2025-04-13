import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/utils/app_constants.dart';
import 'package:zenactive/utils/uitls.dart';

class FCustomTextField extends StatefulWidget {
  final String hintText;
  final String svgIcon;
  final bool isPassword;
  final TextEditingController? controller;

  const FCustomTextField({
    super.key,
    required this.hintText,
    required this.svgIcon,
    this.isPassword = false,
    this.controller,
  });

  @override
  FCustomTextFieldState createState() => FCustomTextFieldState();
}

class FCustomTextFieldState extends State<FCustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      scrollPadding: EdgeInsets.all(0),
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        prefixIcon: svgViewer(
          asset: widget.svgIcon,
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 60.w,
          minHeight: 24.h,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: _obscureText
                    ? svgViewer(asset: AppConstants.eyeOff)
                    : svgViewer(asset: AppConstants.eyeOn),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        suffixIconConstraints: BoxConstraints(
          minWidth: 60.w,
          minHeight: 24.h,
        ),
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
    );
  }
}
