import 'package:get_it/get_it.dart';
import 'package:realtime_chat_app/core/router.dart';
import 'package:realtime_chat_app/core/services/api.service.dart';
import 'package:realtime_chat_app/data/repository/socket.repository.impl.dart';
import 'package:realtime_chat_app/data/sources/socket.source.impl.dart';
import 'package:realtime_chat_app/domain/repository/socket.repository.dart';
import 'package:realtime_chat_app/domain/sources/socket.source.dart';
import '../view/bloc/cubit/socket_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  registerCubits();
  registerSources();
  registerRepositories();
  registerServices();
}

registerCubits() {
  sl.registerFactory<SocketCubit>(
    () => SocketCubit(
      socketRepository: sl<SocketRepository>(),
    ),
  );
}

registerSources() {
  sl.registerLazySingleton<SocketSource>(
    () => SocketSourceImpl(
      api: sl<ApiService>(),
    ),
  );
}

registerRepositories() {
  sl.registerLazySingleton<SocketRepository>(
    () => SocketRepositoryImpl(
      source: sl<SocketSource>(),
    ),
  );
}

registerServices() {
  sl.registerLazySingleton<Routes>(
    () => Routes(),
  );
  sl.registerLazySingleton<ApiService>(() => ApiService());
}
