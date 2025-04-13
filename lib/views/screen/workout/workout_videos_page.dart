import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/workout_controller.dart';
import 'package:zenactive/services/download_service.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/components/custom_video_player.dart';

class WorkoutVideosPage extends StatefulWidget {
  const WorkoutVideosPage({super.key});

  @override
  State<WorkoutVideosPage> createState() => _WorkoutVideosPageState();
}

class _WorkoutVideosPageState extends State<WorkoutVideosPage> {
  final WorkoutController workoutController = Get.find();
  final DownloadService videoController = Get.find();
  @override
  Widget build(BuildContext context) {
    List<String> plans = ["HIIT", "Cardio", "Dance"];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Workout Videos",
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 25,
                        child: ListView.builder(
                          clipBehavior: Clip.none,
                          scrollDirection: Axis.horizontal,
                          itemCount: plans.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xffC1E8FF),
                                  border: Border.all(
                                    width: index == 0 ? 1.5 : 0,
                                    color: Color(0xff37B5FF),
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  heightFactor: 5,
                                  child: Text(
                                    plans[index],
                                    style: kTextStyle.copyWith(
                                      fontSize: 14,
                                      color: Color(
                                        index == 0 ? 0xff174C6B : 0xff32A5E8,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xffFEFEFF),
                          border: Border.all(
                            color: Color(0xff79CDFF),
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff8B8B8B),
                                  ),
                                  hintText: "Search Workout videos...",
                                ),
                              ),
                            ),
                            Icon(
                              Icons.search_rounded,
                              color: Color(0xff8B8B8B),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        itemCount: workoutController.allWorkOutVideo.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 16),
                            height: 280,
                            width: MediaQuery.of(context).size.width - 48,
                            decoration: BoxDecoration(
                              color: Color(0xffFEFEFF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Video player with fixed dimensions
                                      SizedBox(
                                        width: double.infinity,
                                        height: 200,
                                        child: CustomVideoPlayer(
                                          showSeekbar: true,
                                          borderRadius: 16,
                                          thumbnailPath: imageUrl(
                                              workoutController
                                                  .allWorkOutVideo[index]
                                                  .image),
                                          videoPath: imageUrl(workoutController
                                              .allWorkOutVideo[index].video),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      // Content beside video
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 10,
                                                  left: 20,
                                                  right: 20,
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        workoutController
                                                            .allWorkOutVideo[
                                                                index]
                                                            .name,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              Color(0xff2d2d2d),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Obx(() {
                                                      // Find if there's an active download for this video
                                                      final downloadItem = videoController
                                                          .downloads
                                                          .firstWhereOrNull((item) =>
                                                              item.url ==
                                                              imageUrl(
                                                                  workoutController
                                                                      .allWorkOutVideo[
                                                                          index]
                                                                      .video));

                                                      // If there's an active download, show progress
                                                      if (downloadItem !=
                                                              null &&
                                                          !downloadItem
                                                              .isCompleted
                                                              .value) {
                                                        return Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            SizedBox(
                                                              width: 24,
                                                              height: 24,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                strokeWidth: 2,
                                                                value: downloadItem
                                                                        .progress
                                                                        .value /
                                                                    100,
                                                              ),
                                                            ),
                                                            Text(
                                                              "${downloadItem.progress.value.toStringAsFixed(0)}%",
                                                              style: TextStyle(
                                                                  fontSize: 10),
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                      // If download is complete, show a checkmark
                                                      else if (downloadItem !=
                                                              null &&
                                                          downloadItem
                                                              .isCompleted
                                                              .value) {
                                                        return Icon(
                                                            Icons.check_circle,
                                                            color: Colors.green,
                                                            size: 24);
                                                      }
                                                      // Otherwise show download button
                                                      else {
                                                        return GestureDetector(
                                                          behavior:
                                                              HitTestBehavior
                                                                  .translucent,
                                                          onTap: () {
                                                            videoController
                                                                .startDownload(
                                                              imageUrl(
                                                                  workoutController
                                                                      .allWorkOutVideo[
                                                                          index]
                                                                      .video),
                                                              "${workoutController.allWorkOutVideo[index].name}.${workoutController.allWorkOutVideo[index].video.split('.').last}",
                                                            );
                                                          },
                                                          child: svgViewer(
                                                              asset:
                                                                  "assets/svg/download.svg"),
                                                        );
                                                      }
                                                    })
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      // Add some bottom padding
                      const SizedBox(height: 16),
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
