import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../data/model/response.model.dart';

abstract class SocketRepository {
  Future<Either<Failure, Response>> connect();
}