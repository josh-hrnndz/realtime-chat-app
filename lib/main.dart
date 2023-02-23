import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

import 'core/di.dart';
import 'core/router.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await init();
  Routes routes = sl<Routes>();
  GoRouter router = routes.getRouter();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(fontFamily: 'Inter'),
    ),
  );
}
