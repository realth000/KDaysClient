part of 'auth_bloc.dart';

/// 用户认证相关的事件
@freezed
sealed class AuthEvent with _$AuthEvent {
  /// 登录用户中心
  ///
  /// 使用用户名或邮箱[username]及密码[password]登录
  const factory AuthEvent.loginUserCenter({
    /// 用户名或邮箱
    required String username,

    /// 密码
    required String password,
  }) = _LoginUserCenter;

  /// 登录论坛
  ///
  /// 使用用户中心的认证凭据[accessToken]登录
  const factory AuthEvent.loginForum({
    /// 用户中心的认证凭据
    required String accessToken,
  }) = _LoginForum;
}
