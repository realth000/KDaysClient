import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kdays_client/constants/env.dart';
import 'package:kdays_client/features/auth/bloc/auth_bloc.dart';
import 'package:kdays_client/features/auth/repository/auth_repository.dart';
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
              RepositoryProvider.of<NetClientProvider>(context).getClient(),
            ),
          ),
          BlocProvider(
            create: (context) =>
                AuthBloc(RepositoryProvider.of<AuthRepository>(context)),
          ),
        ],
        child: app,
      ),
    );
  }
}
