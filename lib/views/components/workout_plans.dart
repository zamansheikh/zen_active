import 'package:flutter/material.dart';
import 'package:zenactive/utils/uitls.dart';

class WorkoutPlans extends StatelessWidget {
  final String assetPath;
  final String title;
  final String subTitle;
  final bool isHighlighted;
  final Function()? onTap;
  const WorkoutPlans({
    super.key,
    required this.assetPath,
    required this.title,
    required this.subTitle,
    this.onTap,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isHighlighted ? Color(0xffC1E8FF) : Color(0xffEBF8FF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color(
              0xff37B5FF,
            ),
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                imageUrl(assetPath),
                height: 80,
                width: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/logo/zen_logo.png",
                    filterQuality: FilterQuality.none,
                    width: 46,
                    height: 33,
                  );
                },
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Color(0xff174C6B),
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(
                      color: Color(0xff4B4B4B),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            svgViewer(
              asset: "assets/svg/arrow_forward.svg",
              height: 32,
              width: 32,
            ),
          ],
        ),
      ),
    );
  }
}
