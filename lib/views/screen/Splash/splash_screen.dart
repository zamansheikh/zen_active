import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(15.sp, -0.2.sp),
              child: Container(
                height: 300.sp,
                width: 300.sp,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-15.sp, -0.2.sp),
              child: Container(
                height: 300.sp,
                width: 300.sp,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.sp, -1.3.sp),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFAB40),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 100.0,
                sigmaY: 100.0,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
