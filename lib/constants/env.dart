import 'package:envied/envied.dart';

part 'env.g.dart';

/// 环境变量
@Envied(path: '.env.dev')
abstract class Env {
  /// 用户中心地址
  @EnviedField(varName: 'UC_URL', defaultValue: '')
  static const String userCenterUrl = _Env.userCenterUrl;

  /// 用户中心API key
  @EnviedField(varName: 'UC_API_KEY', defaultValue: '')
  static const String userCenterApiKey = _Env.userCenterApiKey;

  /// 用户中心API secret
  @EnviedField(varName: 'UC_API_SECRET', defaultValue: '')
  static const String userCenterApiSecret = _Env.userCenterApiSecret;

  /// 论坛地址
  @EnviedField(varName: 'FORUM_URL', defaultValue: '')
  static const String forumUrl = _Env.forumUrl;

  /// 论坛API key
  @EnviedField(varName: 'FORUM_API_KEY', defaultValue: '')
  static const String forumApiKey = _Env.forumApiKey;

  /// 论坛API secret
  @EnviedField(varName: 'FORUM_API_SECRET', defaultValue: '')
  static const String forumApiSecret = _Env.forumApiSecret;
}
