import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_app_bar.dart';

class OfflineVideosPage extends StatelessWidget {
  const OfflineVideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      "Full-Body Stretch | Calories Burned Estimate: ~80 kcal | Relax and improve flexibility with this beginner-friendly routine",
      "Strength Circuit: Upper Body | Calories Burned Estimate: ~300 kcal | Build muscle and tone your arms, chest, and back",
      "Power Yoga Flow | Calories Burned Estimate: ~250 kcal | Combine strength and mindfulness with this energizing flow",
      "Full-Body Stretch | Calories Burned Estimate: ~80 kcal | Relax and improve flexibility with this beginner-friendly routine",
      "Full-Body Stretch | Calories Burned Estimate: ~80 kcal | Relax and improve flexibility with this beginner-friendly routine",
      "Power Yoga Flow | Calories Burned Estimate: ~250 kcal | Combine strength and mindfulness with this energizing flow",
      "Full-Body Stretch | Calories Burned Estimate: ~80 kcal | Relax and improve flexibility with this beginner-friendly routine",
      "Full-Body Stretch | Calories Burned Estimate: ~80 kcal | Relax and improve flexibility with this beginner-friendly routine",
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Offline Videos",
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    spacing: 12,
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      for (int index = 0; index < titles.length; index++)
                        Slidable(
                          endActionPane: ActionPane(
                            extentRatio: 0.22,
                            motion: const DrawerMotion(),
                            children: [
                              Flexible(
                                child: Container(
                                  width: 75,
                                  height: 85,
                                  decoration: BoxDecoration(
                                    color: Color(0xffC1E8FF),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: svgViewer(
                                      asset: "assets/svg/delete.svg",
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xffFEFEFF),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.asset(
                                    "assets/images/offline_videos/${index + 1}.png",
                                    height: 68,
                                    width: 68,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    titles[index],
                                    style: TextStyle(
                                      color: Color(0xff2D2D2D),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
