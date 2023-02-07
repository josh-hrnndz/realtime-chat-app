import 'package:realtime_chat_app/data/model/response.model.dart';
import 'package:realtime_chat_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:realtime_chat_app/domain/repository/socket.repository.dart';

import '../../domain/sources/socket.source.dart';

class SocketRepositoryImpl implements SocketRepository {
  final SocketSource source;

  SocketRepositoryImpl({required this.source});

  @override
  Future<Either<Failure, Response>> connect() {
    return ErrorHandler.async<Response>(source.connect());
  }
}
