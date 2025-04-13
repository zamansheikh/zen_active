import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zenactive/utils/app_colors.dart';

class SuggestionCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Function()? onTap;
  const SuggestionCard({
    required this.title,
    required this.imageUrl,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 253.w,
      height: 133.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Stack(
        children: [
          Container(
            width: 253.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey,
                    child: Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 40.w,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      title,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.inversePrimaryTextColor,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: 12.h),
                    InkWell(
                      onTap: onTap,
                      child: Container(
                        alignment: Alignment.center,
                        height: 25.h,
                        width: 90.h,
                        decoration: BoxDecoration(
                          color: Color(0xFF174C6B),
                          borderRadius: BorderRadius.circular(4.r),
                          border:
                              Border.all(width: 1.w, color: Color(0xFF79CDFF)),
                        ),
                        child: Text(
                          'Start Now',
                          style: TextStyle(
                            height: 2,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 79.w),
            ],
          ),
        ],
      ),
    );
  }
}
