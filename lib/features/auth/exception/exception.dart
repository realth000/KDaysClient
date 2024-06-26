import 'package:freezed_annotation/freezed_annotation.dart';

part 'exception.freezed.dart';

/// 认证过程中可能发生的异常
@freezed
sealed class AuthException with _$AuthException {
  const AuthException._();

  /// 应用未授权
  ///
  /// 指用户尚未给本应用授予登录权限
  const factory AuthException.appNotAuthed({
    /// 用户给app授权的页面地址，临时生成
    required String authUrl,
  }) = AppNotAuthed;

  /// 头像未设置
  ///
  /// 指用户的头像尚未设置
  const factory AuthException.avatarNotSet() = _AvatarNotSet;

  /// 账户未创建
  ///
  /// 指用户账户尚未创建
  const factory AuthException.accountNotCreated() = _AccountNotCreated;

  /// 用户不存在或密码错误
  const factory AuthException.accountOrPasswordError() = _AccoutOrPasswordError;

  /// 没有登录过的用户
  const factory AuthException.noCredential() = _NoCredential;

  /// 凭据对不上，需要重新登录
  const factory AuthException.tokenMismatch() = _TokenMismatch;

  /// 网络错误
  const factory AuthException.networkError({
    required int? code,
    required String? message,
  }) = _NetworkError;

  /// 请求中未找到token
  const factory AuthException.tokenNotFound() = _TokenNotFound;

  /// 未知错误
  ///
  /// 其他类型的错误
  const factory AuthException.unknown({
    required int? code,
    required String? message,
  }) = _Unknown;

  /// 获取message
  ///
  /// 这里实际上不会返回null，但是不可空的话freezed生成的代码编译不过
  String? get message => switch (this) {
        AppNotAuthed() => '应用未授权',
        _AvatarNotSet() => '用户未设置头像',
        _AccountNotCreated() => '用户不存在',
        _AccoutOrPasswordError() => '用户不存在或密码错误',
        _NetworkError(:final code) => '网络错误（$code）',
        _TokenNotFound() => '响应中未找到用户凭据',
        _TokenMismatch() => '认证出错，需要重新登录',
        _NoCredential() => '没有登录过的用户',
        _Unknown(:final message) => '其他错误($message)',
      };
}
