import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_chat_app/core/const/index.dart';
import 'package:realtime_chat_app/view/widgets/button.widget.dart';
import '../bloc/cubit/socket_cubit.dart';
import '../widgets/modals.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocListener<SocketCubit, SocketState>(
      listener: (context, state) {
        if (state is ConnectionSuccessState) {
          context.goNamed(CHAT);
        }
        if (state is ConnectingState) {
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
        if (state is ConnectionFailedState) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return ConnectionFailedModal(
                height: height,
                title: "Connection Failed",
                message: state.failure.message,
              );
            },
          );
          Future.delayed(
            const Duration(seconds: 2),
            () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: height * .4,
                width: width * .8,
                child: Image.asset(
                  'assets/icon.png',
                ),
              ),
              SizedBox(
                height: height * .07,
                width: width * .5,
                child: AppButton(
                  buttonType: 'text',
                  textLabel: TALK_TO_STRANGER,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  buttonColor: DARK,
                  borderRadius: 21,
                  onClick: () {
                    BlocProvider.of<SocketCubit>(context).connect(false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
