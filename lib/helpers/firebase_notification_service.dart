import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:zen_active/utils/prefs_helper.dart';

class FirebaseNotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  static late IO.Socket socket;

  static Future<void> initialize() async {
    // Request permission for notifications
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
      debugPrint("Notification permission denied");
      return;
    }

    // Initialize local notifications
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initSettings =
        InitializationSettings(android: androidInitSettings);
    await _localNotifications.initialize(initSettings);

    // Handle different states of FCM messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("App opened from notification: ${message.data}");
    });
  }

  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint(
        "Received foreground notification: ${message.notification?.title}");

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'channel_id',
            'channel_name',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
          ),
        ),
      );
    }
  }

  static Future<String?> getFCMToken() async {
    return await _firebaseMessaging.getToken();
  }

  static Future<String?> printFCMToken() async {
    String? token = await FirebaseNotificationService.getFCMToken();
    debugPrint("FCM Token: $token");
    return token;
  }

  static Future<void> initializeSocket() async {
    socket = IO.io('http://192.168.10.170:5000/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('connect', (_) async {
      debugPrint('Connected to socket server');
      final String token = await PrefsHelper.getString('fcmToken');

      String title = "Sample Title"; // Replace with your title
      String body = "Sample Body"; // Replace with your body
      if (token.isNotEmpty) {
        socket.emit('subscribeToFCM',
            jsonEncode({'title': title, 'body': body, 'token': token}));
      } else {
        String? token = await FirebaseNotificationService.getFCMToken();
        if (token != null) {
          PrefsHelper.setString('fcmToken', token);
          socket.emit('subscribeToFCM',
              jsonEncode({'title': title, 'body': body, 'token': token}));
        }
      }
    });

    socket.on('notificationSent', (data) {
      debugPrint('Notification sent: $data');
    });

    socket.on('disconnect', (_) {
      debugPrint('Disconnected from socket server');
    });
  }
}
