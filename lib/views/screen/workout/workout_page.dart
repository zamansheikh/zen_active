import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/workout_controller.dart';
import 'package:zen_active/helpers/route.dart';
import 'package:zen_active/services/download_service.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_loading.dart';
import 'package:zen_active/views/components/custom_video_player.dart';
import 'package:zen_active/views/components/workout_plans.dart';
import 'package:zen_active/views/screen/workout/plan_details_page.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final WorkoutController controller = Get.put(WorkoutController());
  final DownloadService videoController = Get.put(DownloadService());
  int workoutPlanIndex = 0;
  @override
  void initState() {
    controller.getAllWorkOutPlan();
    controller.getALlWorkoutVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Obx(() {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 34,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/logo/zen_logo.png",
                        width: 46,
                        height: 33,
                      ),
                      const Spacer(),
                      svgViewer(
                        asset: "assets/svg/notification.svg",
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.workoutPlansPage);
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Row(
                      children: [
                        Text(
                          "Workout Plans",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff525252),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff525252),
                          ),
                        ),
                        svgViewer(asset: "assets/svg/see_all.svg"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  controller.isLoading.value
                      ? Center(
                          child: CustomLoading(
                            size: 24,
                          ),
                        )
                      : SizedBox(
                          height: 25,
                          child: ListView.builder(
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.workOutPlan.length,
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
                                      controller.workOutPlan[index].name!,
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
                  const SizedBox(
                    height: 20,
                  ),
                  controller.isLoading.value
                      ? Center(
                          child: CustomLoading(
                            size: 24,
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: (controller.workOutPlan.length > 3)
                              ? 3
                              : controller.workOutPlan.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                WorkoutPlans(
                                  assetPath:
                                      controller.workOutPlan[index].image!,
                                  title: controller.workOutPlan[index].name!,
                                  subTitle: controller
                                      .workOutPlan[index].description!,
                                  isHighlighted: controller
                                          .workOutPlan[index].isEnrolled ??
                                      false,
                                  onTap: () {
                                    Get.to(() => PlanDetailsPage(
                                          workoutPlanIndex: index,
                                          workoutIndex: index,
                                        ));
                                  },
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            );
                          },
                        ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.workoutVideosPage);
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Row(
                      children: [
                        Text(
                          "Workout Videos",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff525252),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff525252),
                          ),
                        ),
                        svgViewer(asset: "assets/svg/see_all.svg"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (controller.isLoading.value ||
                      controller.allWorkOutVideo.isEmpty)
                    if (controller.isLoading.value)
                      Center(
                        child: CustomLoading(
                          size: 24,
                        ),
                      )
                    else
                      Center(
                        child: Text("No Workout Videos"),
                      )
                  else
                    Container(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Video player with fixed dimensions
                                SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: CustomVideoPlayer(
                                    showSeekbar: true,
                                    borderRadius: 16,
                                    thumbnailPath: imageUrl(
                                        controller.allWorkOutVideo[0].image!),
                                    videoPath: imageUrl(
                                        controller.allWorkOutVideo[0].video!),
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
                                                  controller
                                                      .allWorkOutVideo[0].name!,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff2d2d2d),
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
                                                        imageUrl(controller
                                                            .allWorkOutVideo[0]
                                                            .video!));

                                                // If there's an active download, show progress
                                                if (downloadItem != null &&
                                                    !downloadItem
                                                        .isCompleted.value) {
                                                  return Stack(
                                                    alignment: Alignment.center,
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
                                                else if (downloadItem != null &&
                                                    downloadItem
                                                        .isCompleted.value) {
                                                  return Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green,
                                                      size: 24);
                                                }
                                                // Otherwise show download button
                                                else {
                                                  return GestureDetector(
                                                    behavior: HitTestBehavior
                                                        .translucent,
                                                    onTap: () {
                                                      videoController
                                                          .startDownload(
                                                        imageUrl(controller
                                                            .allWorkOutVideo[0]
                                                            .video!),
                                                        "${controller.allWorkOutVideo[0].name!}.${controller.allWorkOutVideo[0].video!.split('.').last}",
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
                    ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
