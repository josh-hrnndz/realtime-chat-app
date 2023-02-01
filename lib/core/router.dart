import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_chat_app/core/const/index.dart';

import '../view/pages/index.dart';

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
      path: '/$START',
      builder: (BuildContext context, GoRouterState state) {
        return const StartPage();
      },
    ),
    GoRoute(
      name: CHAT,
      path: '/',
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
