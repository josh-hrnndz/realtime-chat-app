import 'package:get_it/get_it.dart';
import 'package:realtime_chat_app/core/router.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  registerCubits();
  registerSources();
  registerRepositories();
  registerServices();
}

registerCubits() {

}

registerSources() {

}

registerRepositories() {

}

registerServices() {
  sl.registerLazySingleton<Routes>(
    () => Routes(),
  );
}