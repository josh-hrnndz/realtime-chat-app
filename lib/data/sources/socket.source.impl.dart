import 'dart:async';

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

    return completer.future.timeout(const Duration(seconds: 20), onTimeout: () {
      throw NetworkFailure("Connection failed");
    });
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
  Future<void> sendMessage(String userId, String message) async {
    api.sendMessage(userId, message);
  }

  @override
  Future<void> stopConnection() async {
    api.serverSocket.disconnect();

    await Future.delayed(
      const Duration(seconds: 2),
      () {},
    ).timeout(const Duration(seconds: 20), onTimeout: () {
      throw NetworkFailure("Connection failed");
    });
  }
}
