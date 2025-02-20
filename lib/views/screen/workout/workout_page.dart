import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/controllers/workout_controller.dart';
import 'package:zen_active/helpers/route.dart';
import 'package:zen_active/utils/uitls.dart';
import 'package:zen_active/views/components/custom_loading.dart';
import 'package:zen_active/views/components/workout_plans.dart';
import 'package:zen_active/views/components/workout_videos.dart';
import 'package:zen_active/views/screen/workout/plan_details_page.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final WorkoutController controller = Get.put(WorkoutController());
  int workoutPlanIndex = 0;
  @override
  void initState() {
    controller.getAllWorkOutPlan();
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
                  // const SizedBox(
                  //   height: 12,
                  // ),
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
                  controller.isLoading.value
                      ? Center(
                          child: CustomLoading(
                            size: 24,
                          ),
                        )
                      : WorkoutVideos(
                          assetPath: "assets/images/workout_videos/1.png",
                          onTap: () =>
                              Get.toNamed(AppRoutes.workoutVideoPlayingPage),
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
