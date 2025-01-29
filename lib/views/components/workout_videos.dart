import 'package:flutter/material.dart';
import 'package:zen_active/utils/uitls.dart';

class WorkoutVideos extends StatelessWidget {
  final String assetPath;
  final String? title;
  final bool isPlaying;
  final Function()? onTap;
  const WorkoutVideos({
    super.key,
    required this.assetPath,
    this.title,
    this.isPlaying = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffFEFEFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: isPlaying
                  ? BorderRadius.vertical(top: Radius.circular(8))
                  : BorderRadius.circular(8),
              child: Stack(
                children: [
                  Image.asset(
                    assetPath,
                    height: isPlaying ? 210 : 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  if (!isPlaying)
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.black.withAlpha(102),
                        child: Center(
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffEBF8FF),
                            ),
                            child: Center(
                              child: svgViewer(
                                asset: "assets/svg/play.svg",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (!isPlaying)
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Color(0xff174C6B),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          "15:00",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffEBF8FF),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (isPlaying)
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width / 2,
                  color: Color(
                    0xff32A5E8,
                  ),
                ),
              ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    "Full-Body Stretch | Calories Burned Estimate: ~80 kcal | Relax and improve flexibility with this beginner-friendly routine",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff2d2d2d),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
                svgViewer(asset: "assets/svg/download.svg"),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
