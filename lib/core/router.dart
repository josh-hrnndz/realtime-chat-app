import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../view/pages/start.page.dart';
import 'const/strings.dart';

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
      pageBuilder: (context, state) {
        return const MaterialPage(child: StartPage());
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
