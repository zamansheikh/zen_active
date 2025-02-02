import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_active/utils/app_colors.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';
import 'package:zen_active/views/components/custom_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:zen_active/views/components/random_popup.dart';

class ModeTrackerScreen extends StatefulWidget {
  const ModeTrackerScreen({super.key});

  @override
  State<ModeTrackerScreen> createState() => _ModeTrackerScreenState();
}

class _ModeTrackerScreenState extends State<ModeTrackerScreen> {
  final GlobalKey _modeCardKey = GlobalKey();

  Future<void> _shareScreenshot() async {
    try {
      RenderRepaintBoundary boundary = _modeCardKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/screenshot.png').create();
      await file.writeAsBytes(pngBytes);

      Share.shareXFiles([XFile(file.path)], text: 'Check out my mode!');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              backgroundColor: AppColors.scaffoldBackgroundColor,
              title: 'Mode Tracker',
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RepaintBoundary(
                    key: _modeCardKey,
                    child: ModeCard(
                      mode: "You’re feeling great today!",
                      onShare: _shareScreenshot,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Activity suggestion:",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                    buttonColor: Colors.transparent,
                    buttonName: "HIIT 💪️",
                    textColor: AppColors.primaryTextColor,
                    onPressed: () {},
                  ),
                  SizedBox(height: 12.h),
                  CustomButton(
                    buttonColor: Colors.transparent,
                    buttonName: "Cardio 🏃‍♀️",
                    textColor: AppColors.primaryTextColor,
                    onPressed: () {},
                  ),
                  SizedBox(height: 12.h),
                  CustomButton(
                    buttonColor: Colors.transparent,
                    buttonName: "Dance 💃",
                    textColor: AppColors.primaryTextColor,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              //Make color transparent padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              contentPadding: EdgeInsets.zero,
                              content: RandomPopup(
                                hasCrossButton: true,
                                title:
                                    'Feeling tired? A quick nap could recharge you!',
                                svgPath: 'assets/svg/nap.svg',
                              ),
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModeCard extends StatelessWidget {
  final String mode;
  final Function onShare;

  const ModeCard({super.key, required this.mode, required this.onShare});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            border: Border.all(
              color: AppColors.splashColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 14.w,
              ),
              svgViewer(
                asset: "assets/svg/mood_tracker.svg",
                height: 205.h,
                width: 205.w,
              ),
              SizedBox(
                width: 14.w,
              ),
              Text(
                mode,
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 12,
          top: 12,
          child: InkWell(
            onTap: () => onShare(),
            child: svgViewer(
                asset: "assets/svg/share.svg", height: 24.h, width: 24.w),
          ),
        ),
      ],
    );
  }
}
