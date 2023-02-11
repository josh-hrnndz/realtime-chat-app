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

class ReceiveMessagesState extends SocketState {
  final List<Response> responses;
  final String userId;

  ReceiveMessagesState(this.responses, this.userId);
}

class DisconnectSuccessState extends SocketState {}

class ReconnectUserState extends SocketState {}

class ReconnectingUserState extends SocketState {}

class ReconnectionSuccessState extends SocketState {}

class ReconnectionFailedState extends SocketState {
  final Failure failure;

  ReconnectionFailedState(this.failure);
}