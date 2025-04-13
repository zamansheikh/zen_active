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
    Get.put(SettingsController());
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
