import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/settings_controller.dart';
import 'package:zenactive/utils/uitls.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';
import 'package:zenactive/views/screen/profile/about_us_page.dart';
import 'package:zenactive/views/screen/profile/privary_policy_page.dart';
import 'package:zenactive/views/screen/profile/terms_of_services_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> data = [
      [
        "assets/svg/privacy_policy.svg",
        "Privacy Policy",
        PrivaryPolicyPage(),
      ],
      [
        "assets/svg/terms_of_services.svg",
        "Terms of Services",
        TermsOfServicesPage()
      ],
      ["assets/svg/about_us.svg", "About Us", AboutUsPage()],
    ];
    final settingsController = Get.put(SettingsController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Settings",
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    spacing: 12,
                    children: [
                      for (int index = 0; index < data.length; index++)
                        GestureDetector(
                          onTap: () {
                            Get.to(data[index][2]);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xffFEFEFF),
                              border: Border.all(
                                width: 0.5,
                                color: Color(0xff79CDFF),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                svgViewer(
                                  asset: data[index][0],
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  data[index][1],
                                  style: TextStyle(
                                    color: Color(0xff4B4B4B),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    height: 1,
                                  ),
                                ),
                                const Spacer(),
                                svgViewer(
                                  asset: "assets/svg/arrow_forward.svg",
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 24),
                      // Delete Account Button
                      Obx(() => GestureDetector(
                            onTap: settingsController.isDeleting.value
                                ? null
                                : () => _showDeleteAccountDialog(
                                    context, settingsController),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffFEFEFF),
                                border: Border.all(
                                  width: 0.5,
                                  color: Color(0xffFF6B6B),
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete_forever,
                                    color: Color(0xffFF6B6B),
                                    size: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    "Delete Account",
                                    style: TextStyle(
                                      color: Color(0xffFF6B6B),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      height: 1,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (settingsController.isDeleting.value)
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Color(0xffFF6B6B),
                                        ),
                                      ),
                                    )
                                  else
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color(0xffFF6B6B),
                                      size: 16,
                                    ),
                                ],
                              ),
                            ),
                          )),
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

  void _showDeleteAccountDialog(
      BuildContext context, SettingsController controller) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.warning,
                color: Color(0xffFF6B6B),
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Delete Account',
                style: TextStyle(
                  color: Color(0xffFF6B6B),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This action cannot be undone. Your account and all associated data will be permanently deleted.',
                style: TextStyle(
                  color: Color(0xff4B4B4B),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'To confirm, type "deleteme" below:',
                style: TextStyle(
                  color: Color(0xff4B4B4B),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller.deleteConfirmationController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xff79CDFF)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xff79CDFF), width: 2),
                  ),
                  hintText: 'Type "deleteme"',
                  hintStyle: TextStyle(color: Color(0xff999999)),
                ),
                style: TextStyle(color: Color(0xff4B4B4B)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.deleteConfirmationController.clear();
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xff4B4B4B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Obx(() => ElevatedButton(
                  onPressed: controller.isDeleting.value
                      ? null
                      : () {
                          if (controller.deleteConfirmationController.text
                                  .trim() ==
                              'deleteme') {
                            Navigator.of(context).pop();
                            controller.deleteAccount();
                          } else {
                            Get.snackbar(
                              'Invalid Input',
                              'Please type "deleteme" to confirm account deletion.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.orange,
                              colorText: Colors.white,
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFF6B6B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: controller.isDeleting.value
                      ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          'Delete Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                )),
          ],
        );
      },
    );
  }
}
