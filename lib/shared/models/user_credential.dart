import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_credential.freezed.dart';

/// 用户认证凭据
@freezed
final class UserCredential with _$UserCredential {
  /// Constructor.
  const factory UserCredential({
    /// 用户名或邮箱
    required String input,

    /// 密码
    required String password,

    /// 用户中心token
    required String userCenterToken,

    /// 论坛token
    required String forumToken,
  }) = UserCredentialData;
}
