import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/uitls.dart';

class RandomPopup extends StatelessWidget {
  final String svgPath;
  final bool hasCrossButton;
  final String title;
  const RandomPopup({
    super.key,
    required this.svgPath,
    this.hasCrossButton = false,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 360.w,
          height: 230.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              svgViewer(asset: svgPath, width: 64.w, height: 64.h),
              SizedBox(height: 20.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryTextColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    width: hasCrossButton ? 120.w : 81.w,
                    height: 33.h,
                    decoration: BoxDecoration(
                      color: Color(0xff2781B5),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: !hasCrossButton
                        ? Center(
                            child: Text(
                              'Okay',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Row(
                                spacing: 5.w,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  svgViewer(
                                      asset: "assets/svg/call.svg",
                                      width: 16.w,
                                      height: 16.h),
                                  Text(
                                    'Call Now',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
        if (hasCrossButton)
          Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Color(0xff5FC4FF),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4.r),
                    bottomLeft: Radius.circular(4.r),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20.r,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
