import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadController extends GetxController {
  final RxMap<String, double> downloadProgress = <String, double>{}.obs;
  final RxList<String> downloadedVideos = <String>[].obs;
  final String _savedVideosKey = "downloaded_videos";
  final Map<String, String> _taskIdToPath = {};

  @override
  void onInit() {
    super.onInit();
    _initializeDownloader();
    _loadDownloadedVideos();
    askForPermission();
  }

  void askForPermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) return null;
      print(status);
    }
  }

  void _initializeDownloader() async {
    await FlutterDownloader.initialize();
    FlutterDownloader.registerCallback(_downloadCallback);
  }

  @pragma('vm:entry-point')
  static void _downloadCallback(String id, int status, int progress) {
    final downloadStatus = DownloadTaskStatus.fromInt(status);
    final SendPort? sendPort =
        IsolateNameServer.lookupPortByName('downloader_port');
    if (sendPort != null) {
      if (downloadStatus == DownloadTaskStatus.running) {
        sendPort.send([id, progress.toDouble()]);
      } else if (downloadStatus == DownloadTaskStatus.complete) {
        sendPort.send(id);
      }
    }
  }

  Future<void> _loadDownloadedVideos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    downloadedVideos.assignAll(prefs.getStringList(_savedVideosKey) ?? []);
  }

  Future<String?> downloadVideo(String videoUrl, String videoName) async {
    if (Platform.isAndroid && !await _requestManageExternalStorage()) {
      print("Permission denied");
      return null;
    }

    final dir = await getApplicationDocumentsDirectory();
    final fileName = "$videoName.mp4";
    final savePath = "${dir.path}/$fileName";

    if (await File(savePath).exists()) return null;

    final taskId = await FlutterDownloader.enqueue(
      url: videoUrl,
      savedDir: dir.path,
      fileName: fileName,
      showNotification: true,
      openFileFromNotification: true,
    );

    if (taskId != null) {
      _taskIdToPath[taskId] = savePath;
      return taskId;
    }
    return null;
  }

  Future<bool> _requestManageExternalStorage() async {
    if (Platform.isAndroid) {
      final status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        return false;
      } else {
        return status.isGranted;
      }
    }
    return false;
  }

  void updateDownloadProgress(String taskId, double progress) {
    downloadProgress[taskId] = progress;
  }

  Future<void> handleDownloadComplete(String taskId) async {
    final path = _taskIdToPath[taskId];
    if (path == null) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> videos = [...downloadedVideos];
    if (!videos.contains(path)) {
      videos.add(path);
      await prefs.setStringList(_savedVideosKey, videos);
      downloadedVideos.assignAll(videos);
    }
    downloadProgress.remove(taskId);
    _taskIdToPath.remove(taskId);
  }

  Future<bool> deleteVideo(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) await file.delete();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String> videos = [...downloadedVideos]..remove(path);
      await prefs.setStringList(_savedVideosKey, videos);
      downloadedVideos.assignAll(videos);
      return true;
    } catch (e) {
      return false;
    }
  }

  void openVideo(String path) {
    FlutterDownloader.open(taskId: path);
  }
}
