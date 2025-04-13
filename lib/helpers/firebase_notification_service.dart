// ignore_for_file: library_prefixes
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:zenactive/services/api_constant.dart';
import 'package:zenactive/utils/app_constants.dart';
import 'package:zenactive/utils/prefs_helper.dart';

class FirebaseNotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Make socket instance static for global access
  static late IO.Socket socket;

  // Singleton pattern
  FirebaseNotificationService._privateConstructor();
  static final FirebaseNotificationService instance =
      FirebaseNotificationService._privateConstructor();

  /// **Initialize Firebase Notifications and Socket**
  static Future<void> initialize() async {
    // Request notification permission
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint("🚫 Notification permission denied");
      return;
    }

    // Print FCM token
    await printFCMToken();

    // Retrieve and set APNS token
    String? apnsToken = await _firebaseMessaging.getAPNSToken();
    if (apnsToken != null) {
      debugPrint("🔑 APNS Token: $apnsToken");
    } else {
      debugPrint("⚠️ APNS Token is not available yet.");
    }

    // Initialize local notifications
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings iosInitSettings =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    final InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );
    await _localNotifications.initialize(initSettings);

    // Handle FCM messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("📩 App opened from notification: ${message.data}");
    });

    // Initialize socket connection
    await initializeSocket();
  }

  /// **Handle foreground FCM messages and show local notification**
  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint(
      "📩 Received foreground notification: ${message.notification?.title}",
    );

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null) {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: android != null
              ? AndroidNotificationDetails(
                  'reservation_channel',
                  'Gestion App',
                  importance: Importance.max,
                  priority: Priority.high,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                )
              : null,
          iOS: const DarwinNotificationDetails(),
        ),
      );
    }
  }

  /// **Retrieve FCM Token**
  static Future<String?> getFCMToken() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      // Retrieve APNS token for iOS
      String? apnsToken = await _firebaseMessaging.getAPNSToken();
      if (apnsToken != null) {
        debugPrint("🔑 APNS Token: $apnsToken");
        return apnsToken;
      } else {
        debugPrint("⚠️ APNS Token is not available yet.");
        return null;
      }
    } else {
      // Retrieve FCM token for other platforms
      return await _firebaseMessaging.getToken();
    }
  }

  /// **Print FCM Token & Store it in Preferences**
  static Future<void> printFCMToken() async {
    String token = await PrefsHelper.getString(AppConstants.fcmToken);
    if (token.isNotEmpty) {
      debugPrint("🔑 FCM Token (Stored): $token");
    } else {
      token = await getFCMToken() ?? '';
      PrefsHelper.setString(AppConstants.fcmToken, token);
      debugPrint("🔑 FCM Token (New): $token");
    }
  }

  /// **Initialize Socket Connection**
  static Future<void> initializeSocket() async {
    socket = IO.io(ApiConstant.baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.connect();

    socket.on('connect', (_) async {
      debugPrint('✅ Connected to socket server');
      final String token = await PrefsHelper.getString(AppConstants.fcmToken);
      final String userId = await PrefsHelper.getString(AppConstants.user);

      await Future.delayed(const Duration(seconds: 7));

      if (token.isNotEmpty) {
        socket.emit('fcmToken', {'userId': userId, 'fcmToken': token});
      } else {
        socket.emit('fcmToken', {'userId': userId, 'fcmToken': ''});
      }
    });

    socket.on('notificationSent', (data) {
      debugPrint('📨 Notification sent: $data');
    });

    socket.on('disconnect', (_) {
      debugPrint('❌ Disconnected from socket server');
    });
  }

  /// **Emit Socket Events from Anywhere**
  static void sendSocketEvent(String eventName, dynamic data) {
    if (socket.connected) {
      socket.emit(eventName, data);
      debugPrint('📤 Socket emit: $eventName - $data');
    } else {
      debugPrint('⚠️ Socket is not connected!');
    }
  }
}
