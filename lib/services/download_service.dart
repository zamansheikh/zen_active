import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class DownloadService extends GetxController {
  Dio dio = Dio();
  final urlController = TextEditingController();

  // List of active downloads
  var downloads = <DownloadItem>[].obs;

  // List of saved/downloaded files
  var savedDownloads = <SavedFile>[].obs;

  // Fetch all downloaded files from storage
  Future<void> fetchDownloadedFiles() async {
    Directory? dir = await getExternalStorageDirectory();
    if (dir == null) return;

    List<FileSystemEntity> files = dir.listSync();
    savedDownloads.assignAll(files
        .map((e) => SavedFile(
              path: e.path,
              fileName: e.path.split('/').last,
              fileType: e.statSync().type.toString(),
            ))
        .toList());
  }

  //Fetch only video files from storage
  Future<void> fetchDownloadedVideos() async {
    Directory? dir = await getExternalStorageDirectory();
    if (dir == null) return;

    List<FileSystemEntity> files = dir.listSync();
    savedDownloads.assignAll(files
        .where((e) {
          return e.path.endsWith('.mp4') ||
              e.path.endsWith('.3gp') ||
              e.path.endsWith('.avi') ||
              e.path.endsWith('.mkv');
        })
        .map((e) => SavedFile(
              path: e.path,
              fileName: e.path.split('/').last,
              fileType: e.statSync().type.toString(),
            ))
        .toList());
  }

  // Start a new file download and add it to the queue
  Future<void> startDownload(String url, String? fileName) async {
    await requestPermissions();

    Directory? dir = await getExternalStorageDirectory();
    if (dir == null) {
      Get.snackbar("Error", "Could not access storage");
      return;
    }

    String filePath = "${dir.path}/${fileName ?? url.split('/').last}";
    var downloadItem = DownloadItem(filePath: filePath, url: url);
    downloads.add(downloadItem);

    try {
      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            downloadItem.progress.value = (received / total * 100).toDouble();
          }
        },
      );
      downloadItem.isCompleted.value = true;
      Get.snackbar("Download Complete", "File saved at: $filePath");

      // Refresh file list after download
      fetchDownloadedFiles();
    } catch (e) {
      Get.snackbar("Download Failed", "Error: $e");
      downloads.remove(downloadItem);
    }
  }

  // Open a downloaded file
  Future<void> openFile(String path) async {
    try {
      await OpenFile.open(path);
    } catch (e) {
      Get.snackbar("Error", "Could not open file");
    }
  }

  // Delete a downloaded file
  Future<void> deleteFile(String path) async {
    File file = File(path);
    if (await file.exists()) {
      try {
        await file.delete();
        Get.snackbar("File Deleted",
            "Successfully deleted ${file.path.split('/').last}");

        // Refresh file list after deletion
        fetchDownloadedFiles();
      } catch (e) {
        Get.snackbar("Error", "Could not delete file: $e");
      }
    } else {
      Get.snackbar("Error", "File not found");
    }
  }

  // Request storage permissions
  Future<void> requestPermissions() async {
    if (Platform.isAndroid) {
      var status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        Get.snackbar("Permission Denied", "Storage permission is required");
      }
    }
  }
}

// Saved file model
class SavedFile {
  String path;
  String fileName;
  String fileType;
  SavedFile({
    required this.path,
    required this.fileName,
    required this.fileType,
  });
}

// Download Item Model (For Tracking Active Downloads)
class DownloadItem {
  String filePath;
  String url;
  RxDouble progress = 0.0.obs;
  RxBool isCompleted = false.obs;

  DownloadItem({required this.filePath, this.url = ""});
}
