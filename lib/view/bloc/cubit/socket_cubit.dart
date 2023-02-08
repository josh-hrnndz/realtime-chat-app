import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:realtime_chat_app/domain/repository/socket.repository.dart';

import '../../../core/errors/failures.dart';
import '../../../data/model/response.model.dart';

part 'socket_state.dart';

class SocketCubit extends Cubit<SocketState> {
  final SocketRepository socketRepository;
  SocketCubit({required this.socketRepository}) : super(SocketInitial());

  connect() {
    emit(ConnectingState());

    socketRepository.connect().then(
          (res) => res.fold(
            (failure) => emit(ConnectionFailedState(failure)),
            (success) {
              print(success.userId);
              socketRepository.setUser(success.userId);
              emit(ConnectionSuccessState());
            },
          ),
        );
  }

  getMessages() {
    socketRepository.getMessages().then(
          (res) => res.fold(
            (failure) => emit(ConnectionFailedState(failure)),
            (success) {
              final stream = res.getOrElse(() => const Stream.empty());
              stream.listen((response) {
                if (response.userId != socketRepository.userId) {
                  socketRepository.addResponse(response);
                }
                emit(ReceiveMessagesState(
                    socketRepository.responses, socketRepository.userId));
              });
            },
          ),
        );
  }

  sendMessage(String userId, String message) {
    socketRepository.addResponse(Response(userId: userId, message: message));
    emit(ReceiveMessagesState(
        socketRepository.responses, socketRepository.userId));
    socketRepository.sendMessage(userId, message).then(
          (res) => res.fold(
            (failure) => emit(ConnectionFailedState(failure)),
            (success) => {},
          ),
        );
  }
}
