import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kdays_client/constants/env.dart';
import 'package:kdays_client/features/auth/bloc/auth_bloc.dart';
import 'package:kdays_client/features/auth/repository/auth_repository.dart';
import 'package:kdays_client/features/init/bloc/init_bloc.dart';
import 'package:kdays_client/features/settings/bloc/settings_bloc.dart';
import 'package:kdays_client/features/storage/bloc/storage_bloc.dart';
import 'package:kdays_client/features/storage/database/database.dart';
import 'package:kdays_client/features/storage/repository/storage_repository.dart';
import 'package:kdays_client/routes/routes.dart';
import 'package:kdays_client/shared/models/app_credential.dart';
import 'package:kdays_client/shared/models/settings/settings_map.dart';
import 'package:kdays_client/shared/models/user_credential.dart';
import 'package:kdays_client/shared/providers/net_client_provider/net_client_provider.dart';
import 'package:kdays_client/theme/theme.dart';
import 'package:kdays_client/utils/logger.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// 顶层应用
class App extends StatelessWidget with LoggerMixin {
  /// Constructor.
  const App({super.key});

  Widget _buildBody(
    BuildContext context,
    SettingsMap settingsMap,
    UserCredential? userCredential,
  ) {
    debug('app: preload user credential: ${userCredential != null}');
    final app = MaterialApp.router(
      title: 'KDays客户端',
      theme: AppTheme.makeLight(context),
      darkTheme: AppTheme.makeDark(context),
      routerConfig: router,
    );
    // 到这里，函数外部已经加载好存储的数据，可以使用
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<NetClientProvider>(
          create: (_) => NetClientProvider(
            userCenterCredential: const AppCredential(
              url: Env.userCenterUrl,
              apiKey: Env.userCenterApiKey,
              apiSecret: Env.userCenterApiSecret,
            ),
            forumCredential: const AppCredential(
              url: Env.forumUrl,
              apiKey: Env.forumApiKey,
              apiSecret: Env.forumApiSecret,
            ),
            // 装填从存储中获取到的用户认证凭据
            userCredential: userCredential,
          ),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) =>
              AuthRepository(RepositoryProvider.of<NetClientProvider>(context)),
        ),
        BlocProvider(
          create: (_) => SettingsBloc(
            RepositoryProvider.of(context),
            settingsMap,
          ),
        ),
        BlocProvider(
          create: (context) => AuthBloc(RepositoryProvider.of(context))
            ..add(const AuthEvent.checkLogin()),
        ),
        BlocProvider(
          create: (context) => StorageBloc(RepositoryProvider.of(context)),
        ),
      ],
      child: app,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
      ],
      // 首先实例化存储，保证数据能够加载
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AppDatabase>(
            create: (_) => AppDatabase(),
          ),
          RepositoryProvider<StorageRepository>(
            create: (context) =>
                StorageRepository(RepositoryProvider.of(context)),
          ),
        ],
        child: BlocProvider(
          create: (context) => InitBloc(RepositoryProvider.of(context))
            ..add(const InitEvent.loadData()),
          child: BlocBuilder<InitBloc, InitState>(
            builder: (context, state) => switch (state) {
              Initial() || LoadingData() => MaterialApp(
                  title: 'KDays客户端',
                  theme: AppTheme.makeLight(context),
                  darkTheme: AppTheme.makeDark(context),
                  home: const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  ),
                ),
              Success(:final settingsMap, :final userCredential) =>
                _buildBody(context, settingsMap, userCredential),
            },
          ),
        ),
      ),
    );
  }
}
