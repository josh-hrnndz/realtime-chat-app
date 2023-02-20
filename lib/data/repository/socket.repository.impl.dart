import 'package:realtime_chat_app/data/model/response.model.dart';
import 'package:realtime_chat_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:realtime_chat_app/domain/repository/socket.repository.dart';

import '../../domain/sources/socket.source.dart';

class SocketRepositoryImpl implements SocketRepository {
  final SocketSource source;
  List<Response> _responses = [];
  String _userId = "";
  String _roomName = "";

  SocketRepositoryImpl({required this.source});

  @override
  String get userId => _userId;

  @override
  List<Response> get responses => _responses;

  @override
  String get roomName => _roomName;

  @override
  void addResponse(Response response) {
    _responses.add(response);
  }

  @override
  void setResponseStatus(bool isFailed) {
    _responses[_responses.length - 1].isFailed = isFailed;
  }

  @override
  void setUser(String userId) {
    _userId = userId;
  }

  @override
  void clearResponses() {
    _responses = [];
  }

  @override
  void setRoomName(String roomName) {
    _roomName = roomName;
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
  Future<Either<Failure, void>> sendMessage(String userId, String message, String roomName) {
    return ErrorHandler.async<void>(source.sendMessage(userId, message, roomName));
  }

  @override
  Future<Either<Failure, void>> stopConnection() {
    return ErrorHandler.async<void>(source.stopConnection());
  }
}
