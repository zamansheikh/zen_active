import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:zen_active/services/api_constant.dart';

///<------------------------- Socket Class ---------------->
class SocketApi {
  // Factory constructor to return the same static instance every time you create an object.
  factory SocketApi() {
    return _socketApi;
  }

  // An internal private constructor to access it only once for the static instance of the class.
  SocketApi._internal();

  ///<------------------------- Socket Initialization ---------------->
  static void init() {
    debugPrint(
        '=============> Socket initialization, connected: ${socket.connected}');
    if (!socket.connected) {
      // socket.connect();
      socket.onConnect((_) {
        debugPrint('===============> Socket Connected');
      });
    } else {
      debugPrint('Socket instance already connected');
    }
  }

  static final SocketApi _socketApi = SocketApi._internal();

  ///<------------------------- Socket Client ---------------->

  static IO.Socket socket = IO.io(
    ApiConstant.socketUrl,
    IO.OptionBuilder().setTransports(['websocket']).build(),
  );

  ///<------------------------- Send Message and Response ---------------->

  static Future<dynamic> emitWithAck(String event, dynamic body) async {
    Completer<dynamic> completer = Completer<dynamic>();

    socket.emitWithAck(event, body, ack: (data) {
      if (data != null) {
        debugPrint('===========> Emit With Ack $data');
        completer.complete(data);
      } else {
        debugPrint('===========> Null');
        completer.complete(1);
      }
    });
    return completer.future;
  }

  ///<------------------------- Send Message ---------------->

  static emit(String event, dynamic body) {
    if (body != null) {
      socket.emit(event, body);
      debugPrint('===========> Emit');
    }
  }
}
