import 'package:realtime_chat_app/data/model/response.model.dart';
import 'package:realtime_chat_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:realtime_chat_app/domain/repository/socket.repository.dart';

import '../../domain/sources/socket.source.dart';

class SocketRepositoryImpl implements SocketRepository {
  final SocketSource source;
  final List<Response> _responses = [];
  String _userId = "";

  SocketRepositoryImpl({required this.source});

  @override
  String get userId => _userId;

  @override
  List<Response> get responses => _responses;

  @override
  void addResponse(Response response) {
    _responses.add(response);
  }

  @override
  void setUser(String userId) {
    _userId = userId;
  }

  @override
  Future<Either<Failure, Response>> connect() {
    return ErrorHandler.async<Response>(source.connect());
  }

  @override
  Future<Either<Failure, Stream<Response>>> getMessages() {
    try {
      return Future.value(Right(source.getMessages()));
    } catch (e) {
      return Future.value(Left(ConnectFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage(String userId, String message) {
    return ErrorHandler.async<void>(source.sendMessage(userId, message));
  }
}
