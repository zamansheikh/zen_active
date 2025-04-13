import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:zenactive/controllers/settings_controller.dart';
import 'package:zenactive/views/components/custom_app_bar.dart';

class PrivaryPolicyPage extends StatelessWidget {
  const PrivaryPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Privacy Policy",
            ),
            Expanded(
              // Ensure content takes available space
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          " Privacy Policy",
                          style: TextStyle(
                            color: Color(0xff2D2D2D),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xffFEFEFF),
                          border: Border.all(
                            color: Color(0xff79CDFF),
                            width: 0.3,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: HtmlWidget(
                          Get.find<SettingsController>().privacyPolicy.value,
                        ),
                      ),
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
}
