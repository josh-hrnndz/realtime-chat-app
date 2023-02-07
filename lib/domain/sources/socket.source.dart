import '../../data/model/response.model.dart';

abstract class SocketSource {
  Future<Response> connect();
}
