import 'package:flutter/material.dart';
import 'package:kdays_client/routes/routes.dart';

/// 顶层应用
class App extends StatelessWidget {
  /// Constructor.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'KDays客户端',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
