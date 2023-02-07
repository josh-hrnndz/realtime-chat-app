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
    api.serverSocket.on('message', (data) {
      var response = Response.fromJson(data);
      completer.complete(response);
    });

    return completer.future.timeout(const Duration(seconds: 5), onTimeout: () {
      throw NetworkFailure("Connection failed");
    });
  }
}
