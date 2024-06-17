part of 'auth_bloc.dart';

/// 用户认证的状态
@freezed
sealed class AuthState with _$AuthState {
  /// 初始状态，未认证
  const factory AuthState.initial() = _Initial;

  /// 正在获取用户中心的认证
  ///
  /// 此时临时持有用户名或邮箱[username]和密码[password]
  const factory AuthState.processingUserCenter({
    /// 用户名
    required String username,

    /// 密码
    required String password,
  }) = _ProcessingUserCenter;

  /// 正在获取论坛的认证
  ///
  /// 此时已经获取到了用户中心的认证凭据
  const factory AuthState.processingForum({
    /// 用户名
    required String username,

    /// 用户中心的认证凭据
    required String userCenterAccessToken,
  }) = _ProcessingForum;

  /// 已认证
  ///
  /// 此时同时拥有用户中心和论坛的认证凭据
  const factory AuthState.authed({
    /// 用户名
    required String username,

    /// 用户中心的认证凭据
    required String userCenterAccessToken,

    /// 用户中心的认证凭据
    required String forumAccessToken,
  }) = _Authed;
}
