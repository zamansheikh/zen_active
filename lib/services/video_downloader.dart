import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

class VideoDownloader {
  static const String _savedVideosKey = "downloaded_videos";
  static final RxMap<String, double> downloadProgress = <String, double>{}.obs;
  static final RxMap<String, String> taskIdToFileName = <String, String>{}.obs;
  static final RxList<String> downloadedVideos = <String>[].obs;
  static ReceivePort? _port;

  /// **Register Port for Isolate Communication**
  static void registerDownloadPort() {
    _port = ReceivePort();
    IsolateNameServer.registerPortWithName(
        _port!.sendPort, 'downloader_send_port');
    _port!.listen((dynamic data) {
      String id = data[0] as String;
      DownloadTaskStatus status = data[1] as DownloadTaskStatus;
      int progress = data[2] as int;

      if (status == DownloadTaskStatus.running) {
        downloadProgress[id] = progress.toDouble();
      } else if (status == DownloadTaskStatus.complete) {
        downloadProgress.remove(id);
        // Optionally, show a snackbar notification for completion.
        Get.snackbar(
            "Download Complete", "${taskIdToFileName[id]} has been downloaded.",
            snackPosition: SnackPosition.BOTTOM);
        loadDownloadedVideos();
      }
    });
  }

  /// **Initialize Download Progress Tracking**
  static void trackDownloadProgress() {
    FlutterDownloader.registerCallback(downloadCallback);
  }

  /// **Static Callback Function (for Background Execution)**
  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, DownloadTaskStatus.fromInt(status), progress]);
  }

  /// **Download Video & Prevent Duplicates**
  static Future<String?> downloadVideo(
      String videoUrl, String videoName) async {
    if (Platform.isAndroid) {
      var status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) return null;
    }

    Directory dir = await getApplicationDocumentsDirectory();
    String savePath = "${dir.path}/$videoName.mp4";

    if (File(savePath).existsSync()) {
      return null; // Prevent duplicate downloads
    }

    final taskId = await FlutterDownloader.enqueue(
      url: videoUrl,
      savedDir: dir.path,
      fileName: "$videoName.mp4",
      showNotification: true,
      openFileFromNotification: true,
    );

    if (taskId != null) {
      // Use taskId as key for tracking progress and map the file name.
      downloadProgress[taskId] = 0.0;
      taskIdToFileName[taskId] = "$videoName.mp4";
      await _saveVideoPath(savePath);
      return savePath;
    }
    return null;
  }

  /// **Save Video Path**
  static Future<void> _saveVideoPath(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> videos = prefs.getStringList(_savedVideosKey) ?? [];
    if (!videos.contains(path)) {
      videos.add(path);
      await prefs.setStringList(_savedVideosKey, videos);
      downloadedVideos.assignAll(videos);
    }
  }

  /// **Load Downloaded Videos**
  static Future<void> loadDownloadedVideos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    downloadedVideos.assignAll(prefs.getStringList(_savedVideosKey) ?? []);
  }

  /// **Delete Video**
  static Future<bool> deleteVideo(String videoPath) async {
    try {
      File videoFile = File(videoPath);
      if (await videoFile.exists()) {
        await videoFile.delete();
      } else {
        return false;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> videos = prefs.getStringList(_savedVideosKey) ?? [];
      videos.remove(videoPath);
      await prefs.setStringList(_savedVideosKey, videos);
      downloadedVideos.assignAll(videos);

      return true;
    } catch (e) {
      return false;
    }
  }

  /// **Open Downloaded Video**
  static void openDownloadedVideo(String videoPath) {
    OpenFile.open(videoPath);
  }
}
