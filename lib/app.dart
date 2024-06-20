import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kdays_client/constants/env.dart';
import 'package:kdays_client/features/auth/bloc/auth_bloc.dart';
import 'package:kdays_client/features/auth/repository/auth_repository.dart';
import 'package:kdays_client/features/settings/cubit/settings_cubit.dart';
import 'package:kdays_client/features/settings/models/settings_map.dart';
import 'package:kdays_client/features/storage/bloc/storage_bloc.dart';
import 'package:kdays_client/features/storage/database/database.dart';
import 'package:kdays_client/features/storage/repository/storage_repository.dart';
import 'package:kdays_client/routes/routes.dart';
import 'package:kdays_client/shared/models/credential.dart';
import 'package:kdays_client/shared/providers/net_client_provider/net_client_provider.dart';
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
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AppDatabase>(
            create: (_) => AppDatabase(),
          ),
          RepositoryProvider<StorageRepository>(
            create: (context) => StorageRepository(
              RepositoryProvider.of(context),
            ),
          ),
        ],
        child: FutureBuilder(
          future: Future.wait([
            RepositoryProvider.of<StorageRepository>(context).loadAllSettings(),
            // RepositoryProvider.of<StorageRepository>(context)
            //     .saveUserCredential(),
            // TODO: Get user input and credential.
            Future.value(...),
          ]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Scaffold();
            }
            final settingsMap = snapshot.data![0] as SettingsMap;
            final userCredential = snapshot.data![1];
            return MultiBlocProvider(
              providers: [
                RepositoryProvider<NetClientProvider>(
                  create: (_) => NetClientProvider(
                    userCenterCredential: const Credential(
                      url: Env.userCenterUrl,
                      apiKey: Env.userCenterApiKey,
                      apiSecret: Env.userCenterApiSecret,
                      accessToken: null,
                    ),
                    forumCredential: const Credential(
                      url: Env.forumUrl,
                      apiKey: Env.forumApiKey,
                      apiSecret: Env.forumApiSecret,
                      accessToken: null,
                    ),
                  ),
                ),
                RepositoryProvider<AuthRepository>(
                  create: (context) => AuthRepository(
                    // TODO: Init with user credential.
                    RepositoryProvider.of<NetClientProvider>(context)
                        .getClient(...),
                  ),
                ),
                BlocProvider<SettingsCubit>(
                  create: (context) => SettingsCubit(
                    RepositoryProvider.of(context),
                    settingsMap,
                  ),
                ),
                BlocProvider(
                  create: (context) => AuthBloc(
                    RepositoryProvider.of(context),
                  ),
                ),
                BlocProvider(
                  create: (context) =>
                      StorageBloc(RepositoryProvider.of(context)),
                ),
              ],
              child: app,
            );
          },
        ),
      ),
    );
  }
}
