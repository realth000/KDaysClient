import 'package:flutter/material.dart';
import 'package:kdays_client/app.dart';
import 'package:kdays_client/features/cache/repository/image_cache_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initImageCache();
  runApp(const App());
}
