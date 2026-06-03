import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/router/app.router.dart';
import '../features/users/providers/auth.provider.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late final router;

  @override
  void initState() {
    super.initState();

    final authProvider = context.read<AuthProvider>();

    router = createRouter(authProvider);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,

      debugShowCheckedModeBanner: false,
      title: 'Mini Universidad',

      themeMode: ThemeMode.system,

      theme: FlexThemeData.light(scheme: FlexScheme.blueM3, useMaterial3: true),

      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.outerSpace,
        useMaterial3: true,
      ),
    );
  }
}


