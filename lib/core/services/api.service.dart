import 'package:socket_io_client/socket_io_client.dart' as IO;

class ApiService {
  IO.Socket serverSocket =
      IO.io('http://192.168.254.105:3000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  sendMessage(String userId, String message) {
    serverSocket.emit('message', {'userId': userId, 'message': message});
  }
}
