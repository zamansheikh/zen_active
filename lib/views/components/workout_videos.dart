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

/* 
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WorkoutVideos extends StatefulWidget {
  final String videoUrl;
  final String? title;
  final bool isPlaying;
  final Function()? onTap;

  const WorkoutVideos({
    super.key,
    required this.videoUrl,
    this.title,
    this.isPlaying = false,
    this.onTap,
  });

  @override
  _WorkoutVideosState createState() => _WorkoutVideosState();
}

class _WorkoutVideosState extends State<WorkoutVideos> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the video player controller
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {}); // Ensure the UI updates once the video is initialized
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffFEFEFF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: widget.isPlaying
                  ? BorderRadius.vertical(top: Radius.circular(8))
                  : BorderRadius.circular(8),
              child: Stack(
                children: [
                  widget.isPlaying
                      ? SizedBox(
                          width: double.infinity,
                          height: 210,
                          child: VideoPlayer(_controller),
                        )
                      : Image.asset(
                          'assets/images/video_placeholder.png', // Placeholder image
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                  if (!widget.isPlaying)
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
                              child: Icon(
                                Icons.play_arrow,
                                color: Color(0xff174C6B),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (!widget.isPlaying)
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
            if (widget.isPlaying)
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
                    widget.title ??
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
                IconButton(
                  icon: Icon(Icons.download),
                  onPressed: () {
                    // Handle download functionality here
                  },
                ),
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


*/
