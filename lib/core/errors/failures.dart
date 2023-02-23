
import 'package:dartz/dartz.dart';

abstract class Failure extends Error {
  final String message;
  Failure({required this.message});
}

class ConnectFailure extends Failure {
  ConnectFailure(String message) : super(message: message);
}

class NetworkFailure extends Failure {
  NetworkFailure(String message)
      : super(message: "$message. You may be offline.");
}

class ErrorHandler {
  static Future<Either<Failure, T>> async<T>(
    Future<T> source,
  ) async {
    try {
      final sourceValue = await source;
      return Right(sourceValue);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  static Either<Failure, T> sync<T>(
    T source,
  ) {
    try {
      return Right(source);
    } catch (e) {
      return Left(e as Failure);
    }
  }

  static String message(Failure failure) {
    switch (failure.runtimeType) {
      case ConnectFailure:
      case NetworkFailure:
        return failure.message;
      default:
        return 'Unexpected error';
    }
  }
}
