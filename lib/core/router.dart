import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_chat_app/core/const/index.dart';

import '../view/bloc/cubit/socket_cubit.dart';
import '../view/pages/index.dart';
import 'di.dart';

class Routes {
  GoRouter getRouter() {
    return GoRouter(
      initialLocation: "/",
      routes: Routes.routes,
      errorPageBuilder: Routes.errorPage,
    );
  }

  static List<GoRoute> routes = [
    GoRoute(
      name: START,
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => sl<SocketCubit>(),
          child: const StartPage(),
        );
      },
    ),
    GoRoute(
      name: CHAT,
      path: '/$CHAT',
      builder: (BuildContext context, GoRouterState state) {
        return ChatPage();
      },
    ),
  ];

  static MaterialPage<void> Function(
    BuildContext,
    GoRouterState,
  ) errorPage = (
    context,
    state,
  ) =>
      MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(state.error.toString()),
          ),
        ),
      );
}
