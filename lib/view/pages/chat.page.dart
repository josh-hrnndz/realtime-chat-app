import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_chat_app/core/const/index.dart';
import 'package:realtime_chat_app/view/bloc/cubit/socket_cubit.dart';
import 'package:realtime_chat_app/view/widgets/button.widget.dart';
import 'package:realtime_chat_app/view/widgets/chat.widget.dart';
import 'package:realtime_chat_app/view/widgets/chatbox.widget.dart';
import 'package:realtime_chat_app/view/widgets/control.button.widget.dart';

import '../../data/model/response.model.dart';
import '../widgets/modals.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final chatBoxController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String userId = "";
  List<Response> responses = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isUser = false;

    return BlocConsumer<SocketCubit, SocketState>(
      listenWhen: (previous, current) {
        if (previous is ReconnectUserState &&
            current is DisconnectSuccessState) {
          BlocProvider.of<SocketCubit>(context).connect(true);
        }
        if (current is ReconnectUserState &&
            previous is DisconnectSuccessState) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return LoadingModal(
                height: height,
                message: "Finding strangers...",
              );
            },
          );
        }
        if (current is ReconnectionFailedState &&
            previous is ReconnectingUserState) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return ConnectionFailedModal(
                height: height,
                title: "Connection Failed",
                message: current.failure.message,
              );
            },
          );
          Future.delayed(
            const Duration(seconds: 2),
            () {
              Navigator.pop(context);
            },
          );
        }
        if (current is ReconnectionSuccessState &&
            previous is ReconnectUserState) {
          Navigator.pop(context);
          responses = [];
          BlocProvider.of<SocketCubit>(context).getMessages();
        }
        if (current is DisconnectSuccessState &&
            previous is ReceiveMessagesState) {
          context.goNamed(START);
        }
        return true;
      },
      listener: (context, state) {
        if (state is ReceiveMessagesState) {
          userId = state.userId;
          responses = state.responses;
        }
      },
      builder: (context, state) {
        if (state is SocketInitial) {
          BlocProvider.of<SocketCubit>(context).getMessages();
        }
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  ControlButton(
                    height: height * .1,
                    width: width * .5,
                    buttonColor: TINT_GREEN,
                    label: NEXT,
                    onTap: () {
                      BlocProvider.of<SocketCubit>(context)
                          .stopConnection(true);
                    },
                  ),
                  ControlButton(
                    height: height * .1,
                    width: width * .5,
                    buttonColor: TINT_RED,
                    label: STOP,
                    onTap: () {
                      BlocProvider.of<SocketCubit>(context)
                          .stopConnection(false);
                    },
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .03),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: responses.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == responses.length - 1) {
                        _scrollToBottom();
                      }
                      responses[index].userId == userId
                          ? isUser = true
                          : isUser = false;
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: height * .005),
                        child: Align(
                          alignment: isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Chat(
                            isUser: isUser,
                            message: responses[index].message,
                            isFailed: responses[index].isFailed,
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
                        textEditingController: chatBoxController,
                        hintText: CHATBOX_HINTTEXT,
                      ),
                    ),
                    SizedBox(
                      width: width * .15,
                      height: height * .07,
                      child: AppButton(
                        buttonType: "icon",
                        icon: Icons.send,
                        isIconRotated: true,
                        iconRotation: 320,
                        fontSize: 25,
                        borderRadius: 25,
                        onClick: () {
                          BlocProvider.of<SocketCubit>(context)
                              .sendMessage(chatBoxController.text);
                          chatBoxController.text = "";
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }
}
