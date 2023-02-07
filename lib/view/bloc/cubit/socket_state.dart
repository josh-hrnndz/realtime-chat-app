part of 'socket_cubit.dart';

@immutable
abstract class SocketState {}

class SocketInitial extends SocketState {}

class ConnectingState extends SocketState {}

class ConnectionSuccessState extends SocketState {}

class ConnectionFailedState extends SocketState {
  final Failure failure;

  ConnectionFailedState(this.failure);
}

class SocketEmittingState extends SocketState {}
