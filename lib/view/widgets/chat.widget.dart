import 'package:flutter/material.dart';
import 'package:realtime_chat_app/core/const/colors.dart';

class Chat extends StatelessWidget {
  final String message;
  final bool isUser;
  const Chat({
    super.key,
    required this.isUser,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          isUser ? "You" : "Stranger",
          style: const TextStyle(
            color: DARK,
            fontSize: 13,
          ),
          textAlign: isUser ? TextAlign.right : TextAlign.left,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isUser ? PRIMARY_LIGHT : SECONDARY,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isUser ? 20 : 0),
              topRight: Radius.circular(isUser ? 0 : 20),
              bottomLeft: const Radius.circular(20),
              bottomRight: const Radius.circular(20),
            ),
          ),
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
