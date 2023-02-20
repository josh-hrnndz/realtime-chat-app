import 'package:flutter/material.dart';
import 'package:realtime_chat_app/core/const/colors.dart';

class Chat extends StatelessWidget {
  final String message;
  final bool isUser;
  final bool isFailed;
  const Chat({
    super.key,
    required this.isUser,
    required this.message,
    this.isFailed = false,
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
        Row(
          mainAxisAlignment:
              isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            isFailed && isUser
                ? const Icon(
                    Icons.warning_amber_rounded,
                    color: TINT_RED,
                    size: 40,
                  )
                : Container(),
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
        ),
      ],
    );
  }
}
