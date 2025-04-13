import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:open_file/open_file.dart';
import 'package:zenactive/services/download_service.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';

class OfflineVideosPage extends StatefulWidget {
  const OfflineVideosPage({super.key});

  @override
  State<OfflineVideosPage> createState() => _OfflineVideosPageState();
}

class _OfflineVideosPageState extends State<OfflineVideosPage> {
  final videoController = Get.find<DownloadService>();

  @override
  void initState() {
    videoController.fetchDownloadedVideos();
    super.initState();
  }

  Future<Uint8List?> _generateThumbnail(String videoPath) async {
    print("Video Path: $videoPath");
    return await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128, // Specify the width of the thumbnail
      quality: 25, // Adjust quality as needed
    );
  }

  @override
  Widget build(BuildContext context) {
    // No need to call fetchDownloadedVideos() here; it's done in initState
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Offline Videos",
            ),
            Expanded(
              child: Obx(() {
                // Wrap with Obx to react to changes in savedDownloads
                if (videoController.savedDownloads.isEmpty) {
                  return Center(
                    child: Text(
                      "No videos downloaded yet.",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Column(
                        // spacing: 12,  // Remove this line
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          for (int index = 0;
                              index < videoController.savedDownloads.length;
                              index++)
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 12.0), // Add padding here
                              child: Slidable(
                                endActionPane: ActionPane(
                                  extentRatio: 0.22,
                                  motion: const DrawerMotion(),
                                  children: [
                                    Flexible(
                                      child: InkWell(
                                        onTap: () {
                                          videoController.deleteFile(
                                              videoController
                                                  .savedDownloads[index].path);
                                          print(
                                              "Delete: ${videoController.savedDownloads[index].path}");
                                        },
                                        child: Container(
                                          width: 75,
                                          height: 85,
                                          decoration: BoxDecoration(
                                            color: Color(0xffC1E8FF),
                                            borderRadius:
                                                BorderRadius.circular(4),
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
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    OpenFile.open(videoController
                                        .savedDownloads[index].path);
                                  },
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
                                        FutureBuilder<Uint8List?>(
                                          future: _generateThumbnail(
                                              videoController
                                                  .savedDownloads[index].path),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              print(
                                                  "Thumbnail generation started for: ${videoController.savedDownloads[index].path}");
                                              return Container(
                                                height: 68,
                                                width: 68,
                                                color: Colors.grey[300],
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              );
                                            } else if (snapshot.hasError ||
                                                snapshot.data == null) {
                                              print("Error: ${snapshot.error}");
                                              print(
                                                  "Thumbnail generation failed for: ${videoController.savedDownloads[index].path}");
                                              return Container(
                                                height: 68,
                                                width: 68,
                                                color: Colors.grey,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.error_outline,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              print(
                                                  "Thumbnail generated successfully for: ${videoController.savedDownloads[index].path}");
                                              return ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: Image.memory(
                                                  snapshot.data!,
                                                  height: 68,
                                                  width: 68,
                                                  fit: BoxFit.cover,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            videoController
                                                .savedDownloads[index].fileName,
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
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
