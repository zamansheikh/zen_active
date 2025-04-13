import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:zenactive/firebase_options.dart';
import 'package:zenactive/helpers/firebase_notification_service.dart';
import 'package:zenactive/helpers/socket_service.dart';
import 'package:zenactive/services/download_service.dart';
import 'package:zenactive/services/gemini_service.dart';
import 'package:zenactive/utils/app_colors.dart';
import 'package:zenactive/utils/app_constants.dart';
import 'package:zenactive/utils/message.dart';
import 'controllers/localization_controller.dart';
import 'controllers/theme_controller.dart';
import 'helpers/di.dart' as di;
import 'helpers/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseNotificationService.initialize();
  Get.put(DownloadService());
  GeminiService.init(apiKey: "AIzaSyCP7WPliATqWAZnEBCgGS6Xm7XVWteSShM");
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors
        .scaffoldBackgroundColor, // Change this to your preferred color
    statusBarIconBrightness:
        Brightness.dark, // Use Brightness.dark for dark icons
  ));
  SocketServices.init();
  Map<String, Map<String, String>> languages = await di.init();
  runApp(MyApp(
    languages: languages,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languages});
  final Map<String, Map<String, String>> languages;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return ScreenUtilInit(
            designSize: const Size(402, 852),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return GlobalLoaderOverlay(
                overlayWidgetBuilder: (_) {
                  //ignored progress for the moment
                  return Center(
                    child: SpinKitFadingCircle(
                      color: AppColors.primaryColor,
                      size: 60.0,
                    ),
                  );
                },
                child: GetMaterialApp(
                  title: AppConstants.APPNAME,
                  debugShowCheckedModeBanner: false,
                  navigatorKey: Get.key,
                  // theme: themeController.darkTheme ? dark() : light(),
                  theme: ThemeData(
                    fontFamily: "Khula",
                    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
                  ),
                  defaultTransition: Transition.topLevel,
                  locale: localizeController.locale,
                  translations: Messages(languages: languages),
                  fallbackLocale: Locale(AppConstants.languages[0].languageCode,
                      AppConstants.languages[0].countryCode),
                  transitionDuration: const Duration(milliseconds: 500),
                  getPages: AppRoutes.pages,
                  initialRoute: AppRoutes.splashScreen,
                ),
              );
            });
      });
    });
  }
}
