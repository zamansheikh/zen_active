import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/helpers/route.dart';
import 'package:zenactive/services/download_service.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/custom_video_player.dart';

class WorkoutVideoPlayingPage extends StatefulWidget {
  const WorkoutVideoPlayingPage({super.key});

  @override
  State<WorkoutVideoPlayingPage> createState() =>
      _WorkoutVideoPlayingPageState();
}

class _WorkoutVideoPlayingPageState extends State<WorkoutVideoPlayingPage> {
  final videoController = Get.find<DownloadService>();

  List<SavedFile> savedDownloads = [
    SavedFile(
      path:
          "https://www.sample-videos.com/video321/mp4/480/big_buck_bunny_480p_5mb.mp4",
      fileName:
          "Full-Body Stretch | Calories Burned Estimate: ~80 kcal | Relax and improve flexibility with this beginner-friendly routine",
      fileType: "mp4",
    ),
    SavedFile(
      path:
          "https://www.sample-videos.com/video321/mp4/480/big_buck_bunny_480p_5mb.mp4",
      fileName:
          "Full-Body Stretch | Calories Burned Estimate: ~80 kcal | Relax and improve flexibility with this beginner-friendly routine",
      fileType: "mp4",
    ),
  ];

  final List<String> thumbnails = [
    'https://www.befunky.com/images/wp/wp-2019-11-BeFunky-YouTube-Thumbnail-Maker-15.jpg?auto=avif,webp&format=jpg&width=1136&crop=16:9',
    'https://www.befunky.com/images/wp/wp-2019-11-BeFunky-YouTube-Thumbnail-Maker-15.jpg?auto=avif,webp&format=jpg&width=1136&crop=16:9',
    'https://www.befunky.com/images/wp/wp-2019-11-BeFunky-YouTube-Thumbnail-Maker-15.jpg?auto=avif,webp&format=jpg&width=1136&crop=16:9',
  ];
  @override
  void initState() {
    videoController.fetchDownloadedVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Workout Videos",
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: ListView.builder(
                  itemCount: savedDownloads.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 12,
                      children: [
                        CustomVideoPlayer(
                          showSeekbar: true,
                          borderRadius: 16,
                          thumbnailPath: thumbnails[index],
                          videoPath: imageUrl(
                              "/medias/8084750-uhd_3840_2160_25fps-1739262146617.mp4"),
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
                            Obx(() {
                              return GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  videoController.startDownload(
                                    savedDownloads[index].path,
                                    savedDownloads[index].fileName,
                                  );
                                },
                                child: true.obs.value
                                    ? CircularProgressIndicator()
                                    : svgViewer(
                                        asset: "assets/svg/download.svg"),
                              );
                            }),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.workoutVideoCommentsPage);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Color(0xffFEFEFF),
                                borderRadius: BorderRadius.circular(4)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Comments ",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff222222),
                                      ),
                                    ),
                                    Text(
                                      "255",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff525252),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(999),
                                      child: Image.asset(
                                        "assets/images/faces/2.png",
                                         filterQuality: FilterQuality.none,
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Ask CDCR San Quintin State Prison 2008. We installed Purex dispensers throughout the prison.....",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff222222),
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
