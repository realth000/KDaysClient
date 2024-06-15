import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kdays_client/features/home/view/home_page.dart';
import 'package:kdays_client/features/my/view/my_page.dart';
import 'package:kdays_client/features/root/view/root_page.dart';
import 'package:kdays_client/routes/screen_paths.dart';

final _rootRouteKey = GlobalKey<NavigatorState>();

/// 路由定义实例，整个应用的路由页面都定义在这里。
final router = GoRouter(
  navigatorKey: _rootRouteKey,
  initialLocation: ScreenPaths.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, router, navigator) => RootPage(navigator),
      branches: [
        StatefulShellBranch(
          routes: [
            _AppRoute(
              path: ScreenPaths.home,
              builder: (_) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            _AppRoute(
              path: ScreenPaths.my,
              builder: (_) => const MyPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

/// 包一层路由的定义
class _AppRoute extends GoRoute {
  _AppRoute({
    required super.path,
    required Widget Function(GoRouterState s) builder,
    List<GoRoute> routes = const [],
    // super.parentNavigatorKey,
    // super.redirect,
  }) : super(
          name: path,
          routes: routes,
          pageBuilder: (context, state) => MaterialPage<void>(
            name: path,
            arguments: state.pathParameters,
            child: builder(state),
          ),
        );
}
