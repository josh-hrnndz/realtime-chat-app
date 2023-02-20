import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:realtime_chat_app/data/model/response.model.dart';
import 'package:realtime_chat_app/domain/sources/socket.source.dart';

import '../../core/errors/failures.dart';
import '../../core/services/api.service.dart';

class SocketSourceImpl extends SocketSource {
  final ApiService api;

  SocketSourceImpl({
    required this.api,
  });

  @override
  Future<Response> connect() async {
    api.serverSocket.connect();

    final completer = Completer<Response>();
    api.serverSocket.on('onConnect', (data) {
      if (!completer.isCompleted) {
        var response = Response.fromJson(data);
        Future.delayed(
          const Duration(seconds: 2),
          () {
            completer.complete(response);
          },
        );
      }
    });

    Future.microtask(() async {
      await Future.delayed(const Duration(seconds: 100));
      if (!completer.isCompleted) {
        throw NetworkFailure("Connection failed");
      }
    });

    return completer.future;
  }

  @override
  Stream<Response> getMessages() {
    final StreamController<Response> responseController =
        StreamController<Response>();

    api.serverSocket.on('message', (data) {
      var response = Response.fromJson(data);
      responseController.add(response);
    });

    return responseController.stream;
  }

  @override
  Future<void> sendMessage(
      String userId, String message, String roomName) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw NetworkFailure("Connection Failed");
    }
    await api.sendMessage(userId, message, roomName);
  }

  @override
  Future<void> stopConnection() async {
    api.serverSocket.disconnect();

    await Future.delayed(
      const Duration(seconds: 2),
      () {},
    ).timeout(const Duration(seconds: 60), onTimeout: () {
      throw NetworkFailure("Connection failed");
    });
  }
}
