import 'package:flutter/material.dart';
import 'package:kdays_client/app.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ResponsiveBreakpoints.builder(
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
      ],
      child: const App(),
    ),
  );
}
