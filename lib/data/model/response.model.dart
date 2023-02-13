class Response {
  String userId;
  String message;
  String roomName;

  Response({
    required this.userId,
    required this.message,
    required this.roomName,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      userId: json["userId"] ?? "",
      message: json["message"] ?? "",
      roomName: json["roomName"] ?? "",
    );
  }
}
