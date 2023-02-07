class Response {
  String userId;
  String message;

  Response({
    required this.userId,
    required this.message,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      userId: json["userId"] ?? "",
      message: json["data"] ?? "",
    );
  }
}
