import 'package:freezed_annotation/freezed_annotation.dart';

part 'exception.freezed.dart';

/// 认证过程中可能发生的异常
@freezed
sealed class AuthException with _$AuthException {
  /// 应用未授权
  ///
  /// 指用户尚未给本应用授予登录权限
  const factory AuthException.appNotAuthed() = _AppNotAuthed;

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

  /// 网络错误
  const factory AuthException.networkError({
    required int? code,
    required String? message,
  }) = _NetworkError;

  /// 未知错误
  ///
  /// 其他类型的错误
  const factory AuthException.unknown({
    required int code,
    required String? message,
  }) = _Unknown;
}

/// 扩展方法
extension AuthExceptionExt on AuthException {
  /// 获取message
  String get message => switch (this) {
        _AppNotAuthed() => '应用未授权',
        _AvatarNotSet() => '用户未设置头像',
        _AccountNotCreated() => '用户不存在',
        _AccoutOrPasswordError() => '用户不存在或密码错误',
        _NetworkError(:final code) => '网络错误（$code）',
        _Unknown(:final message) => '其他错误($message)',
      };
}
