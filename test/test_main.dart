import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_active/services/download_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(DownloadService()); // Global Initialization
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Download Manager',
      home: const DownloadManager(),
    );
  }
}

class DownloadManager extends StatelessWidget {
  const DownloadManager({super.key});

  @override
  Widget build(BuildContext context) {
    final DownloadService downloadService = Get.find();
    downloadService.fetchDownloadedFiles();

    return Scaffold(
      appBar: AppBar(title: const Text('Download Manager')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // URL Input Field
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter URL',
                  border: OutlineInputBorder(),
                ),
                controller: downloadService.urlController,
              ),
              const SizedBox(height: 10),

              // Start Download Button (for custom URL)
              ElevatedButton(
                onPressed: () {
                  downloadService.startDownload(
                    downloadService.urlController.text.trim(),
                    null,
                  );
                },
                child: const Text('Download from URL'),
              ),
              const SizedBox(height: 10),

              // Quick Download Example
              ElevatedButton(
                onPressed: () {
                  downloadService.startDownload(
                    'https://www.sample-videos.com/video321/mp4/480/big_buck_bunny_480p_10mb.mp4',
                    'big_buck_bunny.mp4',
                  );
                },
                child: const Text('Download Sample Video'),
              ),
              const SizedBox(height: 20),

              // ACTIVE DOWNLOADS SECTION
              const Text('Active Downloads',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: downloadService.downloads.length,
                    itemBuilder: (context, index) {
                      final item = downloadService.downloads[index];
                      return Obx(() {
                        return ListTile(
                          title: Text(item.filePath.split('/').last),
                          subtitle: item.isCompleted.value
                              ? const Text("Download Complete")
                              : Text(
                                  "Progress: ${item.progress.value.toStringAsFixed(2)}%"),
                          trailing: item.isCompleted.value
                              ? IconButton(
                                  icon: const Icon(Icons.open_in_new),
                                  onPressed: () =>
                                      downloadService.openFile(item.filePath),
                                )
                              : null,
                        );
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 20),

              // SAVED FILES SECTION
              const Text('Downloaded Files',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: downloadService.savedDownloads.length,
                    itemBuilder: (context, index) {
                      final item = downloadService.savedDownloads[index];
                      return ListTile(
                        title: Text(item.fileName),
                        subtitle: Text("File Type: ${item.fileType}"),
                        trailing: Wrap(
                          spacing: 10,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.open_in_new),
                              onPressed: () =>
                                  downloadService.openFile(item.path),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  downloadService.deleteFile(item.path),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
