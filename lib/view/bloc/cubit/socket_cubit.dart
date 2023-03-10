import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:realtime_chat_app/domain/repository/socket.repository.dart';

import '../../../core/errors/failures.dart';
import '../../../data/model/response.model.dart';

part 'socket_state.dart';

class SocketCubit extends Cubit<SocketState> {
  final SocketRepository socketRepository;
  SocketCubit({required this.socketRepository}) : super(SocketInitial());

  StreamSubscription? _streamSubscription;
  connect(bool isReconnect) {
    isReconnect ? emit(ReconnectUserState()) : emit(ConnectingState());

    _streamSubscription?.cancel();
    _streamSubscription = null;
    socketRepository.connect().then(
          (res) => res.fold(
            (failure) => isReconnect
                ? emit(ReconnectionFailedState(failure))
                : emit(ConnectionFailedState(failure)),
            (success) {
              socketRepository.setUser(success.userId);
              socketRepository.clearResponses();
              socketRepository.setRoomName(success.roomName);
              isReconnect
                  ? emit(ReconnectionSuccessState())
                  : emit(ConnectionSuccessState());
            },
          ),
        );
  }

  getMessages() {
    socketRepository.getMessages().then(
          (res) => res.fold(
            (failure) => emit(ConnectionFailedState(failure)),
            (success) {
              _streamSubscription =
                  res.getOrElse(() => const Stream.empty()).listen((response) {
                if (response.userId != socketRepository.userId) {
                  socketRepository.addResponse(response);
                }
                emit(ReceiveMessagesState(
                    socketRepository.responses, socketRepository.userId));
              }, cancelOnError: true);
            },
          ),
        );
  }

  sendMessage(String message) {
    socketRepository.addResponse(Response(
        userId: socketRepository.userId,
        message: message,
        roomName: socketRepository.roomName));
    emit(ReceiveMessagesState(
        socketRepository.responses, socketRepository.userId));
    socketRepository
        .sendMessage(
            socketRepository.userId, message, socketRepository.roomName)
        .then(
          (res) => res.fold(
            (failure) => {
              socketRepository.setResponseStatus(true),
              emit(ConnectionFailedState(failure)),
            },
            (success) => {},
          ),
        );
  }

  stopConnection(bool isNext) {
    isNext ? emit(ReconnectUserState()) : null;
    socketRepository.stopConnection().then(
          (res) => res.fold(
            (failure) => emit(ConnectionFailedState(failure)),
            (success) => {
              _streamSubscription?.cancel(),
              _streamSubscription = null,
              emit(DisconnectSuccessState()),
            },
          ),
        );
  }
}
