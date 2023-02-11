import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../data/model/response.model.dart';

abstract class SocketRepository {
  get userId;
  get responses;
  void addResponse(Response response);
  void setUser(String userId);
  void clearResponses();
  Future<Either<Failure, Response>> connect();
  Future<Either<Failure, Stream<Response>>> getMessages();
  Future<Either<Failure, void>> sendMessage(String userId, String message);
  Future<Either<Failure, void>> stopConnection();
}
