import 'package:flutter/material.dart';
import 'package:kdays_client/routes/routes.dart';
import 'package:kdays_client/theme/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// 顶层应用
class App extends StatelessWidget {
  /// Constructor.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp.router(
      title: 'KDays客户端',
      theme: AppTheme.makeLight(context),
      darkTheme: AppTheme.makeDark(context),
      routerConfig: router,
    );

    return ResponsiveBreakpoints.builder(
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
      ],
      child: app,
    );
  }
}
