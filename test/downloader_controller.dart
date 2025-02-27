import 'package:get/get.dart';

class DownloaderController extends GetxController {
  RxInt downloadProgress = 0.obs;
  RxString taskId = "".obs;
  @override
  void onInit() {
    print("DownloaderController onInit ${downloadProgress.value}");
    super.onInit();
  }
}
