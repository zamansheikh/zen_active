import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:zenactive/services/api_constant.dart';
import 'package:zenactive/utils/app_constants.dart';
import 'package:zenactive/utils/prefs_helper.dart';

class SocketApi {
  // Private constructor
  SocketApi._internal();

  // Singleton instance
  static final SocketApi _instance = SocketApi._internal();

  // Factory constructor to return the singleton instance
  factory SocketApi() => _instance;

  IO.Socket? _socket; // Make socket nullable

  // Getter for the socket instance.  Initializes if needed.
  IO.Socket get socket {
    if (_socket == null) {
      init(); // Initialize if it doesn't exist
    }
    return _socket!; // Use null-check operator since we know it's initialized
  }

  // Flag to track initialization
  bool _isInitialized = false;

  // Initialization method
  Future<void> init() async {
    if (_isInitialized) {
      debugPrint("SocketApi already initialized.");
      return; // Prevent multiple initializations
    }

    final token = await PrefsHelper.getString(AppConstants.bearerToken);
    //  token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyRW1haWwiOiJ6YW1hbjY1NDVAZ21haWwuY29tIiwidXNlcklkIjoiNjdhNDZjN2E5YWNmYzExOTNhOTgzMjIwIiwidXNlclJvbGUiOiJVU0VSIiwiaWF0IjoxNzQxMDYwOTk1LCJleHAiOjE3NDg4MzY5OTV9.U2LspNjwbRsD9vQUulfFEZc_er13t5AymiXoTQb-bcs"; //Remove hard coded

    if (kDebugMode) {
      print('Token: $token');
    }

    try {
      // _socket = IO.io(
      //   ApiConstant.socketUrl,
      //   IO.OptionBuilder()
      //       .setTransports(['websocket'])
      //       .setExtraHeaders({'Authorization': 'Bearer $token'})
      //       .enableAutoConnect() // Automatically connect
      //       .build(),
      // );

      // _socket = IO.io(
      //   ApiConstant.socketUrl,
      //   IO.OptionBuilder()
      //       .setTransports(['websocket'])
      //       .setAuth({'token': token})
      //       .enableAutoConnect() // Automatically connect
      //       .build(),
      // );

      _socket = IO.io(
        ApiConstant.socketUrl,
        IO.OptionBuilder().setTransports(['websocket']).build(),
      );
      // _socket = IO.io(
      //   'http://192.168.10.18:3500/?token=$token',
      //   IO.OptionBuilder().setTransports(['websocket']).build(),
      // );

      // --- Connection Event Handlers (for debugging and state management) ---
      _socket!.onConnect((_) {
        debugPrint('Socket Connected');
      });

      _socket!.onDisconnect((_) {
        debugPrint('Socket Disconnected');
      });

      _socket!.onConnectError((data) {
        debugPrint('Socket Connection Error: $data');
      });

      _socket!.onError((data) {
        debugPrint('Socket Error: $data');
      });

      _isInitialized = true; // Set initialization flag
    } catch (e) {
      debugPrint('Socket initialization error: $e');
      // Consider throwing the error or handling it appropriately,
      // maybe setting _socket back to null.
      _socket = null; // Reset socket on error
      rethrow; // Re-throw the exception for higher-level handling
    }
  }

  // --- Utility Methods ---

  // Send a message and wait for acknowledgment
  Future<dynamic> emitWithAck(String event, dynamic body) async {
    if (_socket == null || !_socket!.connected) {
      debugPrint("Socket not connected or null. Cannot emit with ack.");
      return null; // Or throw an exception, depending on your needs
    }

    final completer = Completer<dynamic>();

    _socket!.emitWithAck(event, body, ack: (data) {
      if (data != null) {
        debugPrint('Emit With Ack: $data');
        completer.complete(data);
      } else {
        debugPrint('Emit With Ack: Null response');
        completer.complete(null); // Complete with null, or handle as needed
      }
    });

    return completer.future;
  }

  // Send a message without waiting for acknowledgment
  void emit(String event, dynamic body) {
    if (_socket == null || !_socket!.connected) {
      debugPrint("Socket not connected or null. Cannot emit.");
      return; // Or throw an exception
    }
    if (body != null) {
      _socket!.emit(event, body);
    }
  }

  // Connect explicitly (optional if autoConnect is enabled)
  void connect() {
    if (_socket != null && !_socket!.connected) {
      _socket!.connect();
    }
  }

  // Disconnect
  void disconnect() {
    if (_socket != null) {
      _socket!.disconnect();
    }
  }

  // Dispose of the socket (important for cleanup)
  void dispose() {
    if (_socket != null) {
      _socket!.disconnect();
      _socket = null; // Set _socket to null after disconnecting
      _isInitialized = false;
    }
  }
}
