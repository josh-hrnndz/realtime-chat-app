import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../const/strings.dart';

class ApiService {
  IO.Socket serverSocket = IO.io(API, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  sendMessage(String userId, String message, String roomName) {
    serverSocket.emit('message',
        {'userId': userId, 'message': message, 'roomName': roomName});
  }
}
