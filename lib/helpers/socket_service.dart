// ignore_for_file: library_prefixes
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:zenactive/services/api_constant.dart';
import 'package:zenactive/utils/prefs_helper.dart';
import '../utils/app_constants.dart';

class SocketServices {
  static var token = '';
  static var userId = '';

  // Flag to check if socket is already initialized
  static bool _isInitialized = false;

  factory SocketServices() {
    return _socketApi;
  }

  SocketServices._internal();

  static final SocketServices _socketApi = SocketServices._internal();
  // static IO.Socket socket = IO.io(
  //     'ApiConstant.socketUrl',
  //     IO.OptionBuilder().setTransports(['websocket']).setExtraHeaders(
  //         {"authorization": 'Bearer $token'}).build());

  static IO.Socket socket = IO.io(ApiConstant.socketUrl, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  static void init() async {
    // Ensure that the socket is initialized only once
    if (!_isInitialized) {
      token = await PrefsHelper.getString(AppConstants.bearerToken);
      userId = await PrefsHelper.getString(AppConstants.userId);

      debugPrint("✨--------> Socket call");
      socket = IO.io(ApiConstant.socketUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      socket.connect();
      socket.onConnect((_) {
        debugPrint('✅ Connected to socket server');
      });

      socket.onConnectError((err) {
        debugPrint('❌ Socket connection error: $err');
      });
      socket.onDisconnect((_) {
        debugPrint('❌ Disconnected from socket server');
      });

      socket.onReconnect((attempt) {
        debugPrint('✅ Reconnected to socket server on attempt $attempt');
      });

      socket.onReconnectAttempt((attempt) {
        debugPrint('🔄 Reconnecting to socket server, attempt $attempt');
      });

      socket.emit('register', userId);

      _isInitialized = true; // Mark as initialized
    } else {
      debugPrint("✨--------> Socket already initialized");
    }
  }

  static Future<dynamic> emitWithAck(String event, dynamic body) async {
    Completer<dynamic> completer = Completer<dynamic>();
    socket.emitWithAck(event, body, ack: (data) {
      if (data != null) {
        completer.complete(data);
      } else {
        completer.complete(1);
      }
    });
    return completer.future;
  }

  static emit(String event, dynamic body) {
    if (body != null) {
      socket.emit(event, body);
      debugPrint('✨--------> Socket emitted: $event');
    }
  }
}
