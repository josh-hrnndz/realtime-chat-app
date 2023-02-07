import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:realtime_chat_app/domain/repository/socket.repository.dart';

import '../../../core/errors/failures.dart';

part 'socket_state.dart';

class SocketCubit extends Cubit<SocketState> {
  final SocketRepository socketRepository;
  SocketCubit({required this.socketRepository}) : super(SocketInitial());

  connect(){
    emit(ConnectingState());

    socketRepository.connect().then(
      (res) => res.fold(
        (failure) => emit(ConnectionFailedState(failure)),
        (success) => emit(ConnectionSuccessState()),
      ),
    );
  }
  
}
