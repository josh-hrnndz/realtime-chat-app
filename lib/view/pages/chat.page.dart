import 'package:flutter/material.dart';
import 'package:realtime_chat_app/core/const/colors.dart';
import 'package:realtime_chat_app/core/const/index.dart';
import 'package:realtime_chat_app/view/widgets/button.widget.dart';
import 'package:realtime_chat_app/view/widgets/chat.widget.dart';
import 'package:realtime_chat_app/view/widgets/chatbox.widget.dart';
import 'package:realtime_chat_app/view/widgets/control.button.widget.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final chat = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool isUser = false;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              ControlButton(
                height: height * .08,
                width: width * .5,
                buttonColor: TINT_GREEN,
                label: NEXT,
                onTap: () {},
              ),
              ControlButton(
                height: height * .08,
                width: width * .5,
                buttonColor: TINT_RED,
                label: STOP,
                onTap: () {},
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .03),
              child: ListView.builder(
                reverse: true,
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  index % 2 == 0 ? isUser = true : isUser = false;
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: height * .005),
                    child: Align(
                      alignment:
                          isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Chat(
                        isUser: isUser,
                        message:
                            "Hello Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vel est sed magna laoreet tristique vitae ac arcu. Aenean laoreet neque elit, non volutpat turpis consequat nec. Mauris at mi sit amet metus cursus sodales. ${20 - 1 - index}",
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * .02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width * .75,
                  child: ChatBox(
                    textEditingController: chat,
                    hintText: CHATBOX_HINTTEXT,
                  ),
                ),
                SizedBox(
                  width: width * .13,
                  height: height * .07,
                  child: AppButton(
                    buttonType: "icon",
                    icon: Icons.send,
                    isIconRotated: true,
                    iconRotation: 320,
                    fontSize: 25,
                    borderRadius: 25,
                    onClick: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
