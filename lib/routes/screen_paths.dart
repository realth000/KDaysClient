import 'package:kdays_client/routes/route_params.dart';

/// 路由定义
final class ScreenPaths {
  const ScreenPaths._();

  /// 根
  static const String root = '/';

  /// 首页
  static const String home = '/home';

  /// 设置
  static const String settings = '/settings';

  /// 当前用户
  static const String my = '/my';

  /// 登录
  static const String login = '/login';

  /// 登录过程中，等待用户在网页中给app授权
  static const String loginWaitAuth = 'waitAuth/:${RouteParams.input}/'
      ':${RouteParams.password}/:${RouteParams.authUrl}';
}
