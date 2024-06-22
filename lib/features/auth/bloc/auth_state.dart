part of 'auth_bloc.dart';

/// 用户认证的状态
@freezed
sealed class AuthState with _$AuthState {
  /// 初始状态，未认证
  const factory AuthState.initial() = AuthStateInitial;

  /// 正在获取用户中心的认证
  ///
  /// 此时临时持有用户名或邮箱[input]和密码[password]
  const factory AuthState.processingUserCenter({
    /// 用户名或邮箱
    required String input,

    /// 密码
    required String password,
  }) = ProcessingUserCenter;

  /// 正在获取论坛的认证
  ///
  /// 此时已经获取到了用户中心的认证凭据
  const factory AuthState.processingForum({
    /// 用户名或邮箱
    required String input,

    /// 用户中心的认证凭据
    required String userCenterAccessToken,
  }) = ProcessingForum;

  /// 登录用户中心或者论坛失败
  ///
  /// 此时不持有任何数据，需要重新登录
  /// 允许用户重试登录
  const factory AuthState.failed({
    required AuthException e,
  }) = Failed;

  /// 已认证
  ///
  /// 此时同时拥有用户中心和论坛的认证凭据
  const factory AuthState.authed({
    /// 用户名或邮箱
    required String input,

    /// 用户中心的认证凭据
    required String userCenterToken,

    /// 用户中心的认证凭据
    required String forumToken,
  }) = Authed;

  /// 没有登录
  const factory AuthState.notAuthed() = NotAuthed;

  const AuthState._();

  /// 是否认证通过
  bool get isAuthed => this is Authed;
}
