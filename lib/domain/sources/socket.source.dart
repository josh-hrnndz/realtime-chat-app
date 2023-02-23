import '../../data/model/response.model.dart';

abstract class SocketSource {
  Future<Response> connect();
  Stream<Response> getMessages();
  Future<void> sendMessage(String userId, String message, String roomName);
  Future<void> stopConnection();
}
