import 'package:flutter/material.dart';
import 'package:realtime_chat_app/core/const/colors.dart';

class ChatBox extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  const ChatBox({
    super.key,
    required this.textEditingController,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: SECONDARY,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
