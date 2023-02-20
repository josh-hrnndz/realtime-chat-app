class Response {
  String userId;
  String message;
  String roomName;
  bool isFailed;

  Response({
    required this.userId,
    required this.message,
    required this.roomName,
    this.isFailed = false,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      userId: json["userId"] ?? "",
      message: json["message"] ?? "",
      roomName: json["roomName"] ?? "",
    );
  }
}
